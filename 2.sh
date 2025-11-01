# Lakukan di semua mesin (Durin, Aldarion, Khamul, Gilgalad, Amandil, dll):
apt update
apt install net-tools iputils-ping nano isc-dhcp-client -y
echo "nameserver 192.168.122.1" > /etc/resolv.conf

# Konfigurasi Router Durin (DHCP Relay + NAT)
apt install isc-dhcp-relay iptables-persistent -y

# Konfigurasi interface /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.67.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.67.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.67.3.1
    netmask 255.255.255.0

auto eth4
iface eth4 inet static
    address 10.67.4.1
    netmask 255.255.255.0

auto eth5
iface eth5 inet static
    address 10.67.5.1
    netmask 255.255.255.0

echo 1 > /proc/sys/net/ipv4/ip_forward
nano /etc/sysctl.conf
net.ipv4.ip_forward=1

sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent save

# Konfigurasi DHCP relay
nano /etc/default/isc-dhcp-relay
SERVERS="10.67.4.2"
INTERFACES="eth1 eth2 eth3 eth4 eth5"
OPTIONS=""

# Jalankan relay
systemctl restart isc-dhcp-relay
systemctl enable isc-dhcp-relay
systemctl status isc-dhcp-relay
# Pastikan status: active (running)

# Konfigurasi Aldarion (DHCP Server)
apt install isc-dhcp-server -y

nano /etc/default/isc-dhcp-server
INTERFACESv4="eth0"

# Konfigurasi utama
nano /etc/dhcp/dhcpd.conf
authoritative;

default-lease-time 600;
max-lease-time 7200;

# Subnet Manusia
subnet 10.67.1.0 netmask 255.255.255.0 {
  option routers 10.67.1.1;
  option broadcast-address 10.67.1.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  range 10.67.1.6 10.67.1.34;
  range 10.67.1.68 10.67.1.94;
}

# Subnet Peri
subnet 10.67.2.0 netmask 255.255.255.0 {
  option routers 10.67.2.1;
  option broadcast-address 10.67.2.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  range 10.67.2.35 10.67.2.67;
  range 10.67.2.96 10.67.2.121;
}

# Subnet Erendis–Amdir–Khamul
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

# Subnet Aldarion–Palantir–Narvi
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

# Aktifkan DHCP server
systemctl restart isc-dhcp-server
systemctl enable isc-dhcp-server
systemctl status isc-dhcp-server

# Konfigurasi Client (Dinamis) Contoh: Gilgalad / Amandil
apt install ifupdown -y

nano /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

service networking restart
# Cek IP:
ip a

# Konfigurasi Khamul (Fixed Address)
nano /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static

# Restart DHCP client
apt install isc-dhcp-client ifupdown -y
dhclient -v

ip a
# Harus muncul 10.67.3.95

# Uji Koneksi Dari klien (misal Gilgalad/Khamul/Amandil):
ping 10.67.1.1     # Router Durin
ping 10.67.4.2     # DHCP Server Aldarion
ping 8.8.8.8       # Internet via NAT
ping google.com    # DNS test



