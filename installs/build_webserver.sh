add-apt-repository ppa:ondrej/php
apt update
apt install -y apache2 php libapache2-mod-php php-msql php-curl php-fileinfo imagemagick php-imagick
apt install php-phalcon
cp /vagrant/nugget.conf /etc/apache2/sites-available/
a2ensite nugget
a2disstite 000-default
service apache2 reload
