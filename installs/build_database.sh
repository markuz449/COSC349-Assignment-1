apt-get update

export MYSQL_PWD='insecure_mysqlroot_pw'

# If you run the `apt-get install mysql-server` command
# manually, it will prompt you to enter a MySQL root
# password. The next two lines set up answers to the questions
# the package installer would otherwise ask ahead of it asking,
# so our automated provisioning script does not get stopped by
# the software package management system attempting to ask the
# user for configuration information.
echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections 
echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections

# Install the MySQL database server.
apt-get -y install mysql-server

# Run some setup commands to get the database ready to use.
# First create a database.
echo "CREATE DATABASE nugget;" | mysql

# Then create a database user "webuser" with the given password.
echo "CREATE USER 'webuser'@'%' IDENTIFIED BY 'insecure_db_pw';" | mysql

# Grant all permissions to the database user "webuser" regarding
# the "nugget" database that we just created, above.
echo "GRANT ALL PRIVILEGES ON nugget.* TO 'webuser'@'%'" | mysql

# ... and run all of the SQL within the setup-database.sql file,
# which is part of the repository containing this Vagrantfile, so you
# can look at the file on your host. The mysql command specifies both
# the user to connect as (webuser) and the database to use (nugget).
cat /vagrant/installs/nugget.sql | mysql nugget

echo "FLUSH PRIVILEGES;" | mysql

# Set the MYSQL_PWD shell variable that the mysql command will
# try to use as the database password ...
export MYSQL_PWD='insecure_db_pw'

# By default, MySQL only listens for local network requests,
# i.e., that originate from within the dbserver VM. We need to
# change this so that the webserver VM can connect to the
# database on the dbserver VM. Use of `sed` is pretty obscure,
# but the net effect of the command is to find the line
# containing "bind-address" within the given `mysqld.cnf`
# configuration file and then to change "127.0.0.1" (meaning
# local only) to "0.0.0.0" (meaning accept connections from any
# network interface).
sed -i'' -e '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# We then restart the MySQL server to ensure that it picks up
# our configuration changes.
service mysql restart
