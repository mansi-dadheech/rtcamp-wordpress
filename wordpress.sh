#!/bin/bash

#check whether docker and docker compose installed or not
check_docker()
{
	`command -v $1 >/dev/null 2>&1`


}

install_docker()
{
	sudo yum install yum-utils -y
	sudo yum-config-manager --add-repo "https://download.docker.com/linux/centos/docker-ce.repo"
	sudo yum install $1 -y

}

install_compose()
{
	sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	echo 'export PATH=/usr/local/bin:$PATH' >> /etc/profile
	source /etc/profile

}

start_docker()
{
	
	isrunning=`ps -ef | grep docker | grep -v grep | wc -l`
	if [ $isrunning -gt 0 ];then
		echo "Docker is running"
	else
		`systemctl start docker`
	fi

}

wordpress()
{
	site=$1
	if [ -f env ]; then
		`rm -f env`
	else
		echo "SITE_URL=http://$site" >> env
	fi
	echo "127.0.0.1 $site" >> /etc/hosts  


	`docker-compose --env-file env  up -d`
	echo "127.0.0.1 $site" >> /etc/hosts
	if [ $(docker ps | wc -l) > 2 ];then
		echo "Wordpress created successfully"
	else
		echo "Found Issue....Execute Manually"
	fi

}

enableDisableSite()
{

	if [ $1 == "enable" ];then
		echo "Starting LEMP STACK"
		`docker compose start`

	elif [ $1 == "disable" ];then
		echo "Stopping LEMP STACK"
		`docker compose stop`
	fi

}

delete_site()
{

	echo "Deleting Site"
	rm -f env
	`docker compose down`
}


main()
{
	
	if ! check_docker "docker" ; then
		echo "Docker is not installed, installing docker ..."
		install_docker "docker-ce"
	        if  ! check_docker "docker" ; then
			echo "Failed to install docker"
		else
			echo "Docker Installed Successfully"
		fi
	else
		echo "Docker Already Installed"
		start_docker
	fi

	if  ! check_docker "docker-compose" ; then
                echo "Docker Compose is not installed, installing docker ..."
                install_compose
                if ! check_docker "docker-compose" ; then
                        echo "Failed to install docker-compose"
                else
                        echo "Docker-Compose Installed Successfully"
                fi
	else
		echo "Docker Compose Already Installed"
        fi

	if [ $# -lt 1 ];then
		echo "Please provide the arguements"
		echo " USAGE: ./wordpress.sh <command>"
		exit 1
	fi
	command=$1
	site=$2

	if [ $command == "enable" ] || [ $command == "disable" ]; then
		enableDisableSite "$command"
	elif [ $command == "create" ]; then
		if [ $# -lt 2 ];then
                echo "Please provide the arguements"
                echo " USAGE: ./wordpress.sh <command> <sitename>"
                exit 1
                fi
		wordpress $site
	elif [ $command == "delete" ]; then
		delete_site
	else
		echo "Invalid Command"
        fi


}
main "$@"
