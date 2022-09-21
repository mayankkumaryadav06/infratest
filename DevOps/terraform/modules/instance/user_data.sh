#!/bin/bash

set -e
# Send the log output from this script to startup-script.log, syslog, and the console
exec > >(tee /var/log/instance_startup.log|logger -t instance_startup -s 2>/dev/console) 2>&1

echo "Installing apache"
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service

echo ${html_input} > /var/www/html/index.html
