# Homeassistant Updater
A shell utility script to easily upgrade your Homeassistant installation on Python Venv!

# How to use it:

Add exec permissions to the script in order to use it with:
```
chmod u+x hassupgrade.sh
```
Then run the script as a **privileged** user:
```
./hassupgrade.sh
```
# Rollback
If something bad happens during the update or you need to rollback to a previous version here is how to do it:
```
sudo systemctl stop home-assistant@homeassistant
sudo -u homeassistant -H -s
source /srv/homeassistant/bin/activate
pip3 install homeassistant==0.XXX.X
exit
sudo systemctl start home-assistant@homeassistant
```
***Important: replace 0.XXX.X with the version of homeassistant you want to rollback to***
