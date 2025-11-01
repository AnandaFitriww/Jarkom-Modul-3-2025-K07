# ALDARION — DHCP SERVER (10.67.4.2)
# Persiapan dasar
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-server

# Atur interface DHCP
nano /etc/default/isc-dhcp-server

INTERFACESv4="eth1 eth2 eth3 eth4 eth5"
INTERFACESv6=""

# Konfigurasi file utama DHCP
nano /etc/dhcp/dhcpd.conf
authoritative;

# Lease global (maksimal 1 jam)
max-lease-time 3600;
default-lease-time 600;  # default global 10 menit

# ========== MANUSIA ==========
subnet 10.67.1.0 netmask 255.255.255.0 {
  option routers 10.67.1.1;
  option broadcast-address 10.67.1.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;

  # Lease waktu: 30 menit (1800 detik)
  default-lease-time 1800;

  range 10.67.1.6  10.67.1.34;
  range 10.67.1.68 10.67.1.94;
}

# ========== PERI ==========
subnet 10.67.2.0 netmask 255.255.255.0 {
  option routers 10.67.2.1;
  option broadcast-address 10.67.2.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;

  # Lease waktu: 10 menit (600 detik)
  default-lease-time 600;

  range 10.67.2.35 10.67.2.67;
  range 10.67.2.96 10.67.2.121;
}

# ========== KURCACI / LAINNYA ==========
subnet 10.67.3.0 netmask 255.255.255.0 {
  option routers 10.67.3.1;
  option subnet-mask 255.255.255.0;
}

subnet 10.67.4.0 netmask 255.255.255.0 {
  option routers 10.67.4.1;
  option subnet-mask 255.255.255.0;
}

subnet 10.67.5.0 netmask 255.255.255.0 {
  option routers 10.67.5.1;
  option subnet-mask 255.255.255.0;
}

# Jalankan layanan DHCP server
systemctl restart isc-dhcp-server || service isc-dhcp-server restart
systemctl enable isc-dhcp-server || true
systemctl status isc-dhcp-server --no-pager || true

# Jika sistem tidak menggunakan systemd, cukup:
/etc/init.d/isc-dhcp-server restart

# DURIN — DHCP RELAY (Router)
# Pastikan relay sudah aktif dan diarahkan ke Aldarion.
nano /etc/default/isc-dhcp-relay
SERVERS="10.67.4.2"
INTERFACES="eth1 eth2 eth3 eth4 eth5"
OPTIONS=""

service isc-dhcp-relay restart
systemctl enable isc-dhcp-relay || true

# UJI DARI KLIEN (Manusia & Peri)
# Klien MANUSIA (contoh: Amandil)
# Tambahkan resolver awal
echo "nameserver 192.168.122.1" > /etc/resolv.conf

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
echo "nameserver 192.168.122.1" > /etc/resolv.conf

# Install DHCP client
apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-client

# Jalankan DHCP client
dhclient -r -v && dhclient -v

# Hasil normal:
# DHCPOFFER of 10.67.2.xx from 10.67.2.1
# DHCPACK ... bound to 10.67.2.xx -- renewal in 600 seconds.
# → berarti lease 10 menit (600 detik).



