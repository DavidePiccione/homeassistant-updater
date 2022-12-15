# Homeassistant Updater [![CodeFactor](https://www.codefactor.io/repository/github/davidesky/homeassistant-updater/badge)](https://www.codefactor.io/repository/github/davidesky/homeassistant-updater)
A shell utility script to easily update your Homeassistant installation on Python Venv!

# How to use it:

Add exec permissions to the script in order to use it with:
```
chmod u+x hassupdate.sh
```
Then run the script as a **privileged** user:
```
./hassupdate.sh
```
# Options
When you run the script you can add the option *-h* to display an help menu:
```
./hassupdate.sh -h
```

With the option *-p* you can specify a custom Homeassistant installation path. The default one is */srv/homeassistant*
```
./hassupdate.sh -p <custom_path_to_homeassistant>
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
***Important: replace 0.XXX.X with the version of homeassistant you want to rollback to***.
