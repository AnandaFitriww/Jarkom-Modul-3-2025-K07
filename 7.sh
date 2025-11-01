############################################
# 0) ROUTING DNS & PROXY VIA MINASTIR
############################################
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
export http_proxy=http://10.67.5.2:3128
export https_proxy=http://10.67.5.2:3128
export COMPOSER_ALLOW_SUPERUSER=1

############################################
# 1) DEPENDENSI & REPO SURY (PHP 8.4)
############################################
apt update -o Acquire::ForceIPv4=true -y
apt install -y curl git unzip ca-certificates lsb-release gnupg apt-transport-https

curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/sury.gpg >/dev/null
echo "deb https://packages.sury.org/php $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury.list
apt update -o Acquire::ForceIPv4=true -y

############################################
# 2) PHP 8.4 + NGINX + EKSTENSI WAJIB
############################################
apt install -y \
  php8.4-fpm php8.4-cli php8.4-common php8.4-curl php8.4-mbstring php8.4-xml \
  php8.4-zip php8.4-gd php8.4-intl php8.4-bcmath php8.4-mysql php8.4-sqlite3 \
  nginx

# start/restart FPM (kompatibel lingkungan tanpa systemd)
systemctl restart php8.4-fpm 2>/dev/null || service php8.4-fpm restart || true

############################################
# 3) COMPOSER (GLOBAL)
############################################
php -r "copy('https://getcomposer.org/installer','composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -f composer-setup.php
composer --version

############################################
# 4) BUAT PROYEK LARAVEL (Resource-laravel)
############################################
mkdir -p /var/www
cd /var/www
# Jika belum ada, buat proyek. Kalau sudah ada, langkah ini dilewati.
[ -d resource-laravel ] || composer create-project --prefer-dist --no-dev laravel/laravel resource-laravel

############################################
# 5) .ENV & KONFIG APP (SESSION=file + sqlite dummy)
############################################
cd /var/www/resource-laravel
[ -f .env ] || cp .env.example .env
php artisan key:generate || true

# Pastikan session ke file & DB ke sqlite dummy (agar tak butuh DB server)
sed -i 's/^SESSION_DRIVER=.*/SESSION_DRIVER=file/' .env
sed -i 's/^DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
grep -q '^DB_DATABASE=' .env && \
  sed -i 's|^DB_DATABASE=.*|DB_DATABASE=/var/www/resource-laravel/database/database.sqlite|' .env || \
  echo 'DB_DATABASE=/var/www/resource-laravel/database/database.sqlite' >> .env

mkdir -p database storage/framework/{cache,sessions,views}
[ -f database/database.sqlite ] || touch database/database.sqlite

# User & permission aman
id laravel >/dev/null 2>&1 || useradd -m -s /bin/bash laravel
chown -R laravel:www-data /var/www/resource-laravel
find storage -type d -exec chmod 775 {} \;
find bootstrap/cache -type d -exec chmod 775 {} \;

# Bersihkan cache Laravel
php artisan config:clear || true
php artisan cache:clear  || true
php artisan route:clear  || true
php artisan view:clear   || true

############################################
# 6) NGINX VHOST (GANTI DOMAIN SESUAI HOST INI)
############################################
# Elendil:
# DOMAIN="elendil.K07.com"
# Isildur:
# DOMAIN="isildur.K07.com"
# Anarion:
# DOMAIN="anarion.K07.com"
DOMAIN="REPLACE.ME"

# Matikan default & hapus vhost lama agar tidak konflik
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
rm -f /etc/nginx/sites-enabled/laravel_*.conf 2>/dev/null || true
rm -f /etc/nginx/sites-available/laravel_*.conf 2>/dev/null || true

# Buat vhost baru
cat >/etc/nginx/sites-available/laravel_${DOMAIN}.conf <<'EOF'
server {
    listen 80;
    listen [::]:80;
    server_name DOMAIN_PLACEHOLDER;
    root /var/www/resource-laravel/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }

    location ~* \.(env|ini|log|conf|sql)$ { deny all; }
    client_max_body_size 20M;
    sendfile on;
}
EOF
sed -i "s/DOMAIN_PLACEHOLDER/${DOMAIN}/" /etc/nginx/sites-available/laravel_${DOMAIN}.conf
ln -sf /etc/nginx/sites-available/laravel_${DOMAIN}.conf /etc/nginx/sites-enabled/laravel_${DOMAIN}.conf

############################################
# 7) RELOAD/SERVICE START (PASTIKAN LISTEN :80)
############################################
# Uji config, lalu stop->start supaya pasti bind ke :80 dan buang state lama
nginx -t || exit 1
service nginx stop 2>/dev/null || true
service nginx start 2>/dev/null || (systemctl start nginx 2>/dev/null || true)

# Pastikan FPM aktif (fallback ke daemon manual bila perlu)
service php8.4-fpm restart 2>/dev/null || systemctl restart php8.4-fpm 2>/dev/null || php-fpm8.4 -D

# Verifikasi port & socket
ss -lntp | grep -E ':80\s' || (echo 'ERROR: nginx belum listen di :80'; exit 1)
ls /run/php/php8.4-fpm.sock >/dev/null || (echo 'ERROR: php8.4-fpm.sock tidak ada'; exit 1)

# Uji dari Klien (mis. Pharazon)
# Pastikan DNS via Minastir
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx curl

# Test ketiga worker
lynx -dump http://elendil.K07.com  | head -n 20
lynx -dump http://isildur.K07.com  | head -n 20
lynx -dump http://anarion.K07.com  | head -n 20

curl -I http://elendil.K07.com
curl -I http://isildur.K07.com
curl -I http://anarion.K07.com
############################################