# Palantir – Database Server (10.67.4.3)
# Instal dan siapkan MariaDB
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
apt update -o Acquire::ForceIPv4=true -y
apt install -y mariadb-server mariadb-client

# Buka akses jaringan
sed -i 's/^\(\s*bind-address\s*=\s*\).*/\10.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

