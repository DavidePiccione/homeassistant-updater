#!/bin/bash

# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Homeassistant Updater - A shell script to easily update your homeassistant installation on Python Venv!"
   echo
   echo "Syntax: ./hassupdate.sh [-p|h]"
   echo "options:"
   echo "-p     Allows you to specify a custom Hass path. Default: /srv/homeassistant/"
   echo "-h     Print this Help."
}

############################################################
############################################################
# Main script                                              #
############################################################
############################################################

# Hass installation path
hassPath="/srv/homeassistant"

# Get the options
while getopts ":hp:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      p) # Custom Hass path
         hassPath=${OPTARG%/};;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

# Checks for valid hass installation path
if [[ ! -f "$hassPath/bin/activate" ]] ; then
    echo "Python Venv not found in specified path, exiting..."
    exit
fi

sudo -i -u homeassistant bash << EOF
source "$hassPath/bin/activate"
echo "Currently running version: "
hass --version
EOF

while true; do

read -p "Have you made a backup of your existing configuration? (y/n) " yn

case $yn in
        [yY] )  break;;
        [nN] ) echo exiting...;
                exit;;
        * ) echo invalid response;;
esac

done

while true; do

read -p "Do you want to update homeassistant? (y/n) " yn

case $yn in
        [yY] ) echo Updating...;
                break;;
        [nN] ) echo exiting...;
                exit;;
        * ) echo invalid response;;
esac

done

echo "Stopping Homeassistant..."
sudo systemctl stop home-assistant@homeassistant
echo "Installing latest update..."
sudo -i -u homeassistant bash << EOF
source "$hassPath/bin/activate"
pip3 install --upgrade homeassistant
EOF
echo "Finished installing latest update, starting back up homeassistant (May take a while)!"
sudo systemctl start home-assistant@homeassistant

sudo -i -u homeassistant bash << EOF
source "$hassPath/bin/activate"
echo "Newly installed version: "
hass --version
EOF
