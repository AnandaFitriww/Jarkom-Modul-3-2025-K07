# Persiapan di Elendil, Isildur, dan Anarion
# Atur DNS & Proxy agar bisa konek internet
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" > /etc/resolv.conf
export http_proxy=http://10.67.5.2:3128
export https_proxy=http://10.67.5.2:3128
export COMPOSER_ALLOW_SUPERUSER=1

# Instalasi depemdensi dasar
apt update -o Acquire::ForceIPv4=true -y
apt install -y curl git unzip ca-certificates lsb-release gnupg apt-transport-https

# Tambahkan repo PHP 8.4 (sury.org)
curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/sury.gpg >/dev/null
echo "deb https://packages.sury.org/php $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury.list
apt update -o Acquire::ForceIPv4=true -y

# Instal PHP dan ngix
apt install -y \
  php8.4-fpm php8.4-cli php8.4-common php8.4-curl php8.4-mbstring php8.4-xml \
  php8.4-zip php8.4-gd php8.4-intl php8.4-bcmath php8.4-mysql php8.4-sqlite3 \
  nginx

# Instal composer
curl -o composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -f composer-setup.php
composer --version

#clone proyek laravel
# Pastikan proxy masih ada
export http_proxy=http://10.67.5.2:3128
export https_proxy=http://10.67.5.2:3128

# Pindah ke direktori web
mkdir -p /var/www
cd /var/www

# Hapus folder lama (jika ada)
rm -rf resource-laravel

# Clone resource/bluprint
git clone https://github.com/elshiraphine/laravel-simple-rest-api resource-laravel

# Masuk ke folder dn instal dependensi
cd resource-laravel
composer update --no-dev

# Salin file .env (masih di /var/www/resource-laravel)
cp .env.example .env

# Buat kunci aplikasi
php artisan key:generate

# Atur izin folder
chown -R www-data:www-data /var/www/resource-laravel
chmod -R 775 /var/www/resource-laravel/storage
chmod -R 775 /var/www/resource-laravel/bootstrap/cache

# Konfigurasi nginx di setiap worker
# DI ELENDIL YH
# Tentukan domain untuk worker ini
DOMAIN="elendil.k07.com"

# Hapus vhost default
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

# Buat vhost baru (Port 80)
cat >/etc/nginx/sites-available/laravel.conf <<EOF
server {
    listen 80;
    server_name ${DOMAIN};
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files \$uri \$uri/ /index.php?\$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF

# Aktifkan Vhost & restart service
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart

#SI ISILDUR
# Tentukan domain untuk worker ini
DOMAIN="isildur.k07.com"

# Hapus vhost default
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

# Buat vhost baru (Port 80)
cat >/etc/nginx/sites-available/laravel.conf <<EOF
server {
    listen 80;
    server_name ${DOMAIN};
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files \$uri \$uri/ /index.php?\$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF

# Aktifkan Vhost & restart service
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart

# DI ANARION
# Tentukan domain untuk worker ini
DOMAIN="anarion.k07.com"

# Hapus vhost default
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

# Buat vhost baru (Port 80)
cat >/etc/nginx/sites-available/laravel.conf <<EOF
server {
    listen 80;
    server_name ${DOMAIN};
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files \$uri \$uri/ /index.php?\$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF

# Aktifkan Vhost & restart service
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart

# Verifikasi di klien, misal pharazon
# Pastikan DNS mengarah ke Minastir
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf

# Install lynx (jika belum)
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx

# Tes ketiga worker 
lynx -dump http://elendil.k07.com
lynx -dump http://isildur.k07.com
lynx -dump http://anarion.k07.com
