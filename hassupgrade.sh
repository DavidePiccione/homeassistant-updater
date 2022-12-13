#!/bin/bash

sudo -i -u homeassistant bash << EOF
source /srv/homeassistant/bin/activate
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
source /srv/homeassistant/bin/activate
pip3 install --upgrade homeassistant
EOF
echo "Finished installing latest update, starting back up homeassistant (May take a while)!"
sudo systemctl start home-assistant@homeassistant

sudo -i -u homeassistant bash << EOF
source /srv/homeassistant/bin/activate
echo "Newly installed version: "
hass --version
EOF
