add-apt-repository ppa:ondrej/php
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mysql php-curl imagemagick php-imagick
apt-get install php-phalcon
cp /vagrant/installs/000-default.conf /etc/apache2/sites-available/000-default.conf
a2enmod rewrite
sed -i '/upload_max_filesize/c\upload_max_filesize = 10M' /etc/php/7.3/apache2/php.ini
service apache2 restart

# install composer
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
cd /vagrant/www/
# This command is going to look a lot worse that it is.
# Composer installs a php library for formatting time in a human readable way
# The entire output will be red, but in this case it's fine
composer install
