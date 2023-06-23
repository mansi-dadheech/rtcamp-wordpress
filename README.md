# rtcamp-wordpress

This script allows you to easily create a WordPress site using Docker and Docker Compose with a LEMP stack (Linux, Nginx, MySQL, PHP). It automates the setup process and provides options to start, stop and delete your application.

## System Requirement
This script is build and tested with centos-8

## Usage

1. Clone the repository:
`git clone https://github.com/mansi-dadheech/rtcamp-wordpress`

2. Navigate to the project directory:
`cd rtcamp-wordpress`

3. Make the script executable:
`chmod +x wordpress.sh`

4. Execute the script with the desired command and arguments:
   `./wordpress.sh [command] [sitename] <br/><br/>
   Replace the command with:
   1. create: Create a new WordPress site. Requires providing <site_url> as arguments.
   2. enable: Enable the previously created WordPress site.
   3. disable: Disable the previously created WordPress site.
   4. delete: Delete the previously created WordPress site.<br/><br/>
   Replace <site_url> with the URL for your WordPress site (e.g., example.com). This argument is only required when using the create command.
5. Once the script finishes successfully, you can open the provided site URL in your browser to access the newly created WordPress site.

## Examples

To create a WordPress site, execute the following command:<br/>
```
./wordpress.sh create example.com
```
To enable or disable the site, use the following commands:<br/>
```
./wordpress.sh enable
./wordpress.sh disable
```
To delete the site and clean up all associated containers and files, use the following command:<br/>
```
./wordpress.sh delete
```
