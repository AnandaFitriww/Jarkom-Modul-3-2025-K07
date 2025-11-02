# Di Pharazon
# Pastikan DNS mengarah ke Minastir (kalo blom)
printf "nameserver 10.67.5.2\n" > /etc/resolv.conf

cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

# Instalasi lynx, curl
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx curl

# Uji elendil
lynx -dump http://elendil.K07.com:8001/api/airing
curl http://elendil.K07.com:8001/api/airing

# Uji isildur
lynx -dump http://isildur.K07.com:8002/api/airing
curl http://isildur.K07.com:8002/api/airing

# Uji Anarion
lynx -dump http://anarion.K07.com:8003/api/airing
curl http://anarion.K07.com:8003/api/airing







# Palantir – Database Server (10.67.4.3)
# Instal dan siapkan MariaDB
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
apt update -o Acquire::ForceIPv4=true -y
apt install -y mariadb-server mariadb-client

# Buka akses jaringan
sed -i 's/^\(\s*bind-address\s*=\s*\).*/\10.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

