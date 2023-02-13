 #!/bin/bash

 # A shell script for automatic wordpress download & installation for lazy folks !
 # Made by https://github.com/yasarkaancan/

 # Requirements: wget, unzip, mysql

 # How to use ? :
 # Place this script in to your servers root folder.
 # Make it executable with chmod +x wp.sh if not
 # Run it with ./wp.sh
 # Follow the instructions
 # Enjoy !

 echo "Welcome to wordpress Installation script made by https://github.com/yasarkaancan/"

 echo "Enter database name:"
 read db_name
 
 echo "Enter database username:"
 read db_username
 
 echo "Enter database password:"
 read db_password
 
 echo "Enter database host (default is localhost):"
 read db_host
 
 if [ -z "$db_host" ]
 then
   db_host="localhost"
 fi

 dir=$(pwd)'/'

 echo "Enter folder name to install wordpress on ( Leave empty for here ):"
 read folder_name

 echo "Creating database..."
 mysql -u $db_username -p$db_password -e "CREATE DATABASE $db_name" 

 echo "Downloading latest Wordpress version..."
 wget https://wordpress.org/latest.zip
 
 echo "Extracting latest Wordpress version..."
 unzip -q latest.zip
 
 echo "Moving Wordpress files to $folder_name folder..."

 mv wordpress $dir$folder_name
 
 echo "Remove the latest.zip..."
 rm -rf latest.zip
 
 
 echo "Configuring Wordpress with database details..."
 cp $dir$folder_name/wp-config-sample.php $dir$folder_name/wp-config.php
 sed -in-place "s/database_name_here/$db_name/g" $dir$folder_name/wp-config.php
 sed -in-place "s/username_here/$db_username/g" $dir$folder_name/wp-config.php
 sed -in-place "s/password_here/$db_password/g" $dir$folder_name/wp-config.php
 sed -in-place "s/localhost/$db_host/g" $dir$folder_name/wp-config.php

 echo "Wordpress installation complete."
 
 echo "----------------------------------"
 echo "Database Host : "$db_host
 echo "Database Name : "$db_name
 echo "Database Username : "$db_username
 echo "Database Password : "$db_password
 echo "----------------------------------" # Bingo !
