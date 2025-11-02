# Di Palantir
# Setup akses inet via ministar (egein if nid)
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" > /etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

# install mariadb
apt update -o Acquire::ForceIPv4=true -y
apt install -y mariadb-server

# Buka akses jaringan
sed -i 's/^\(bind-address\s*=\s*\).*/\10.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb restart

# Membuat database dan user baru
mariadb -u root <<'EOF'
CREATE DATABASE IF NOT EXISTS laravel_db;
DROP USER IF EXISTS 'laravel_user'@'%';
CREATE USER 'zeinganteng'@'%' IDENTIFIED BY 'nandakocak';
GRANT ALL PRIVILEGES ON laravel_db.* TO 'zeinganteng'@'%';
FLUSH PRIVILEGES;
EOF

# Di lendil, Isildur, dan Anarion
cd /var/www/resource-laravel

# patch migrasi
cat > database/migrations/2023_02_08_103126_create_airings_table.php <<'EOF'
<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
    public function up() {
        Schema::create('airings', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('status'); 
            $table->date('start_date'); 
            $table->timestamps();
        });
    }
    public function down() {
        Schema::dropIfExists('airings');
    }
};
EOF

# patch seeder
cat > database/seeders/airing.json <<'EOF'
{
  "data": [
    {"title": "Attack on Titan", "status": "Finished Airing", "start_date": "2013-04-07"},
    {"title": "One Piece", "status": "Currently Airing", "start_date": "1999-10-20"},
    {"title": "Jujutsu Kaisen", "status": "Finished Airing", "start_date": "2020-10-03"}
  ]
}
EOF
cat > database/seeders/AiringSeeder.php <<'EOF'
<?php
namespace Database\Seeders;
use App\Models\Airing;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\File;
class AiringSeeder extends Seeder {
    public function run() {
        $json = File::get(database_path('seeders/airing.json'));
        $data = json_decode($json, true);
        Airing::truncate();
        if (isset($data['data'])) {
            foreach ($data['data'] as $item) {
                Airing::create([
                    'title' => $item['title'],
                    'status' => $item['status'],
                    'start_date' => $item['start_date'],
                ]);
            }
        }
    }
}
EOF
cat > database/seeders/DatabaseSeeder.php <<'EOF'
<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
class DatabaseSeeder extends Seeder {
    public function run() {
        $this->call([
            AiringSeeder::class
        ]);
    }
}
EOF

# Konfigurasi .env
sed -i "s/DB_HOST=127.0.0.1/DB_HOST=10.67.4.3/" .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=laravel_db/" .env
sed -i "s/^DB_USERNAME=.*/DB_USERNAME=zeinganteng/" .env
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=nandakocak/" .env

# Di Elendil (/var/www/resource-laravel)
# Migrasi dan seeding
php artisan migrate:fresh --seed

# Konfigurasi nginx
cat > /etc/nginx/sites-available/laravel.conf <<'EOF'
# Blokir akses via IP
server {
    listen 10.67.1.10:8001 default_server;
    server_name _;
    return 403;
}
# Izinkan akses via domain
server {
    listen 10.67.1.10:8001;
    server_name elendil.K07.com;
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files $uri $uri/ /index.php?$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF
nginx -t && service nginx restart

# Di Isildur
# Konfig nginx
cat > /etc/nginx/sites-available/laravel.conf <<'EOF'
# Blokir akses via IP
server {
    listen 10.67.1.11:8002 default_server;
    server_name _;
    return 403;
}
# Izinkan akses via domain
server {
    listen 10.67.1.11:8002;
    server_name isildur.K07.com;
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files $uri $uri/ /index.php?$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF
nginx -t && service nginx restart

# di Anarion
# konfig Nginx
cat > /etc/nginx/sites-available/laravel.conf <<'EOF'
# Blokir akses via IP
server {
    listen 10.67.1.12:8003 default_server;
    server_name _;
    return 403;
}
# Izinkan akses via domain
server {
    listen 10.67.1.12:8003;
    server_name anarion.K07.com;
    root /var/www/resource-laravel/public;
    index index.php index.html;
    location / { try_files $uri $uri/ /index.php?$query_string; }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF
nginx -t && service nginx restart


# Uji/testing di pharazon aj
# Pastikan DNS mengarah ke Minastir
printf "nameserver 10.67.5.2\n" > /etc/resolv.conf

# Install lynx (jika belum)
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx

# Tes blokir akses via IP
lynx -dump http://10.67.1.10:8001
lynx -dump http://10.67.1.11:8002
lynx -dump http://10.67.1.12:8003

# Tes koneksi database
lynx -dump http://elendil.k07.com:8001/api/airing
lynx -dump http://isildur.k07.com:8002/api/airing
lynx -dump http://anarion.k07.com:8003/api/airing
