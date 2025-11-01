# ALDARION — DHCP SERVER (10.67.4.2)
# Persiapan dasar
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-server

# Atur interface DHCP (udh tadi)
nano /etc/default/isc-dhcp-server

INTERFACESv4="eth1 eth2 eth3 eth4 eth5"
INTERFACESv6=""

# Konfigurasi file utama DHCP
cat > /etc/dhcp/dhcpd.conf  <<'EOF'
authoritative;

default-lease-time 600; #maks 1 jem
max-lease-time 3600;

# Subnet Manusia
subnet 10.67.1.0 netmask 255.255.255.0 {
  option routers 10.67.1.1;
  option broadcast-address 10.67.1.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  default-lease-time 1800; #min 30 men
  range 10.67.1.6 10.67.1.34;
  range 10.67.1.68 10.67.1.94;
}

# Subnet Peri
subnet 10.67.2.0 netmask 255.255.255.0 {
  option routers 10.67.2.1;
  option broadcast-address 10.67.2.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  default-lease-time 600; #min 10 men
  range 10.67.2.35 10.67.2.67;
  range 10.67.2.96 10.67.2.121;
}
# Subnet Erendis ^`^sAmdir ^`^sKhamul
subnet 10.67.3.0 netmask 255.255.255.0 {
  option routers 10.67.3.1;
  option broadcast-address 10.67.3.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}

# Reservasi alamat tetap Khamul
host khamul {
  hardware ethernet 02:42:5c:d1:69:00;
  fixed-address 10.67.3.95;
}
# Subnet Aldarion ^`^sPalantir ^`^sNarvi
subnet 10.67.4.0 netmask 255.255.255.0 {
  option routers 10.67.4.1;
  option broadcast-address 10.67.4.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}

# Subnet Minastir
subnet 10.67.5.0 netmask 255.255.255.0 {
  option routers 10.67.5.1;
  option broadcast-address 10.67.5.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}
EOF

# kalankan ulang layanan DHCP server
service isc-dhcp-server restart
service isc-dhcp-server status --no-pager || true

# Jika sistem tidak menggunakan systemd, cukup:
/etc/init.d/isc-dhcp-server restart

# DURIN — DHCP RELAY (Router)
# Pastikan relay sudah aktif dan diarahkan ke Aldarion.
nano /etc/default/isc-dhcp-relay
SERVERS="10.67.4.2"
INTERFACES="eth1 eth2 eth3 eth4 eth5"
OPTIONS=""

service isc-dhcp-relay restart
service isc-dhcp-server status --no-pager || true

# UJI DARI KLIEN (Manusia & Peri)
# Klien MANUSIA (contoh: Amandil)
# Tambahkan resolver awal
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

# Install DHCP client
apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-client

# Dapatkan IP
dhclient -r -v && dhclient -v

# Hasil normal:
# DHCPOFFER of 10.67.1.xx from 10.67.1.1
# DHCPACK ... bound to 10.67.1.xx -- renewal in 1800 seconds.
# → berarti lease 30 menit (1800 detik).

# Klien PERI (contoh: Gilgalad)
# Tambahkan resolver awal
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

# Install DHCP client
apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-client

# Jalankan DHCP client
dhclient -r -v && dhclient -v

# Hasil normal:
# DHCPOFFER of 10.67.2.xx from 10.67.2.1
# DHCPACK ... bound to 10.67.2.xx -- renewal in 600 seconds.
# → berarti lease 10 menit (600 detik).
