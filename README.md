
# Start mongodb local
mongod --config /usr/local/etc/mongod.conf

# Install mongodb manually on the server
http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/debian "$(lsb_release -sc)"/mongodb-org/3.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

apt-get install lsb-release
apt-get update
apt-get install -y mongodb-org=3.0.2 mongodb-org-server=3.0.2 mongodb-org-shell=3.0.2 mongodb-org-mongos=3.0.2 mongodb-org-tools=3.0.2

# freeze installed version to specified one
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Puppet (Missing)

- need mongodb sources list
- need mongodb packages
- need additional packages
- create mongo config file (/etc/mongod.conf)
- set datafile directory (/var/lib/mongodb)
- set logfile directory (/var/log/mongodb)
- service mongod start


# Local Admin

Seeding database
-------------------------------
Creating an initial admin user:
-- email:    errbit@errbit.example.com
-- password: tgJmFmgH3oVD
