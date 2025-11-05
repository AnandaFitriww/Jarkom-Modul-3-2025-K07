# Jarkom-Modul-3-2025-K07

## ANGGOTA 
<table>
  <thead>
    <tr>
      <th>No</th>
      <th>Nama</th>
      <th>NRP</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Zein Muhammad Hasan</td>
      <td>5027241035</td>
    </tr>
    <tr>
      <td>2</td>
      <td>Ananda Fitri Wibowo</td>
      <td>5027241057</td>
    </tr>
  </tbody>
</table>

# Topologi Jaringan

| Nama Kota    | Interface | IP Address  | Gateway   |
|--------------|-----------|-------------|-----------|
| Durin   		| eth1      | 10.67.1.1   | -         |
|              | eth2      | 10.67.2.1   | -         |
|              | eth3      | 10.67.3.1   | -         |
|              | eth4      | 10.67.4.1   | -         |
|              | eth5      | 10.67.5.1   | -         |
| Minastir 	   | eth0      | 10.67.5.2   | 10.67.5.1 |
| Aldarion 		| eth0      | 10.67.4.2   | 10.67.4.1 |
| Erendis  	   | eth0      | 10.67.3.2   | 10.67.3.1 |
| Amdir  		| eth0      | 10.67.3.3   | 10.67.3.1 |
| Palantir   | eth0      | 10.67.4.3   | 10.67.4.1 |
| Narvi  	 | eth0      | 10.67.4.4   | 10.67.4.1 |
| Elros  	 | eth0      | 10.67.1.7   | 10.67.1.1 |
| Pharazon   | eth0      | 10.67.2.7   | 10.67.2.1 |
| Elendil 	  | eth0      | 10.67.1.2   | 10.67.1.1 |
| Isildur 	  | eth0      | 10.67.1.3   | 10.67.1.1 |
| Anarion    | eth0      | 10.67.1.4   | 10.67.1.1 |
| Galadriel	 | eth0      | 10.67.2.2   | 10.67.2.1 |
| Celeborn     | eth0      | 10.67.2.3   | 10.67.2.1 |
| Oropher 	  | eth0      | 10.67.2.4   | 10.67.2.1 |
| Miriel 	  | eth0      | 10.67.1.5   | 10.67.1.1 |
| Celebrimbor   | eth0      | 10.67.2.6   | 10.67.2.1 |
| Gilgalad 	  | eth0      | 10.67.2.5   | 10.67.2.1 |
| Amandil 	  | eth0      | 10.67.1.6   | 10.67.1.1 |
| Khamul 	  | eth0      | 10.67.3.4   | 10.67.3.1 |


## SOAL 1
Di awal Zaman Kedua, setelah kehancuran Beleriand, para Valar menugaskan untuk membangun kembali jaringan komunikasi antar kerajaan. Para Valar menyalakan Minastir, Aldarion, Erendis, Amdir, Palantir, Narvi, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher, Miriel, Amandil, Gilgalad, Celebrimbor, Khamul, dan pastikan setiap node (selain Durin sang penghubung antar dunia) dapat sementara berkomunikasi dengan Valinor/Internet (nameserver 192.168.122.1) untuk menerima instruksi awal.

#### Durin Config
```
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
iface eth5 inet static
	address 10.67.2.1
	netmask 255.255.255.0

auto eth5
iface eth5 inet static
	address 10.67.3.1
	netmask 255.255.255.0
```

#### Minastir Config
```
auto eth0
iface eth0 inet static
    address 10.67.5.2
    netmask 255.255.255.0
    gateway 10.67.5.1
dns-nameservers 192.168.122.1
```

#### Aldarion Config
```
auto eth0
iface eth0 inet static
    address 10.67.4.2
    netmask 255.255.255.0
    gateway 10.67.4.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Erendis Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.2
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Amdir Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.3
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Palantir Config
```
auto eth0
iface eth0 inet static
    address 10.67.4.3
    netmask 255.255.255.0
    gateway 10.67.4.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Narvi Config
```
auto eth0
iface eth0 inet static
    address 10.67.4.4
    netmask 255.255.255.0
    gateway 10.67.4.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elros Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.7
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pharazon Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.7
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elendil Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.2
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Isildur Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.3
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Anarion Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.4
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Galadriel Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.2
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Celeborn Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.3
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Oropher Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.4
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Miriel Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.5
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Celebrimbor Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.6
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Gilgalad Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.5
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Amandil Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.6
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Khamul Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.4
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

## Soal 2
Raja Pelaut Aldarion, penguasa wilayah Númenor, memutuskan cara pembagian tanah client secara dinamis. Ia menetapkan:
- Client Dinamis Keluarga Manusia: Mendapatkan tanah di rentang [prefix ip].1.6 - [prefix ip].1.34 dan [prefix ip].1.68 - [prefix ip].1.94.
- Client Dinamis Keluarga Peri: Mendapatkan tanah di rentang [prefix ip].2.35 - [prefix ip].2.67 dan [prefix ip].2.96 - [prefix ip].2.121.
- Khamul yang misterius: Diberikan tanah tetap di [prefix ip].3.95, agar keberadaannya selalu diketahui. Pastikan Durin dapat menyampaikan dekrit ini ke semua wilayah yang terhubung dengannya.

Lakukan di semua mesin (Durin, Aldarion, Khamul, Gilgalad, Amandil, dll):
```
apt update
apt install net-tools iputils-ping nano isc-dhcp-client -y
echo "nameserver 192.168.122.1" > /etc/resolv.conf
```

Konfigurasi Router Durin (DHCP Relay + NAT)
```
apt install isc-dhcp-relay iptables-persistent -y
```
Konfigurasi interface /etc/network/interfaces
```
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
```
```
echo 1 > /proc/sys/net/ipv4/ip_forward
nano /etc/sysctl.conf
net.ipv4.ip_forward=1
```

```
sysctl -p
```
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent save
```

Konfigurasi DHCP relay
```
nano /etc/default/isc-dhcp-relay
SERVERS="10.67.4.2"
INTERFACES="eth1 eth2 eth3 eth4 eth5"
OPTIONS=""
```

Jalankan relay
```
systemctl restart isc-dhcp-relay
systemctl enable isc-dhcp-relay
systemctl status isc-dhcp-relay
```
Pastikan status: active (running)

Konfigurasi Aldarion (DHCP Server)
```
apt install isc-dhcp-server -y

nano /etc/default/isc-dhcp-server
INTERFACESv4="eth0"
```
Konfigurasi utama
```
nano /etc/dhcp/dhcpd.conf
authoritative;

default-lease-time 600;
max-lease-time 7200;
```
Subnet Manusia
```
subnet 10.67.1.0 netmask 255.255.255.0 {
  option routers 10.67.1.1;
  option broadcast-address 10.67.1.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  range 10.67.1.6 10.67.1.34;
  range 10.67.1.68 10.67.1.94;
}
```
Subnet Peri
```
subnet 10.67.2.0 netmask 255.255.255.0 {
  option routers 10.67.2.1;
  option broadcast-address 10.67.2.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
  range 10.67.2.35 10.67.2.67;
  range 10.67.2.96 10.67.2.121;
}
```

Subnet Erendis–Amdir–Khamul
```
subnet 10.67.3.0 netmask 255.255.255.0 {
  option routers 10.67.3.1;
  option broadcast-address 10.67.3.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}
```
Reservasi alamat tetap Khamul
```
host khamul {
  hardware ethernet 02:42:5c:d1:69:00;
  fixed-address 10.67.3.95;
}
```

Subnet Aldarion–Palantir–Narvi
```
subnet 10.67.4.0 netmask 255.255.255.0 {
  option routers 10.67.4.1;
  option broadcast-address 10.67.4.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}
```
Subnet Minastir
```
subnet 10.67.5.0 netmask 255.255.255.0 {
  option routers 10.67.5.1;
  option broadcast-address 10.67.5.255;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 10.67.5.2, 10.67.3.10;
}
```
Aktifkan DHCP server
```
systemctl restart isc-dhcp-server
systemctl enable isc-dhcp-server
systemctl status isc-dhcp-server
```

Konfigurasi Client (Dinamis) Contoh: Gilgalad / Amandil
```
apt install ifupdown -y

nano /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
```
service networking restart
Cek IP:
```
ip a
```

Konfigurasi Khamul (Fixed Address)
```
nano /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static

# Restart DHCP client
apt install isc-dhcp-client ifupdown -y
dhclient -v
```
ip a
Harus muncul 10.67.3.95

Uji Koneksi Dari klien (misal Gilgalad/Khamul/Amandil):
```
ping 10.67.1.1     # Router Durin
ping 10.67.4.2     # DHCP Server Aldarion
ping 8.8.8.8       # Internet via NAT
ping google.com    # DNS test
```
<img width="1069" height="886" alt="Screenshot 2025-10-31 234442" src="https://github.com/user-attachments/assets/1a4bef22-12e4-44ff-8a82-15964419f4e6" />

<img width="952" height="883" alt="Screenshot 2025-10-31 234702" src="https://github.com/user-attachments/assets/6aea6195-855e-4707-87cc-1fa041136134" />


## Soal 3
Untuk mengontrol arus informasi ke dunia luar (Valinor/Internet), sebuah menara pengawas, Minastir didirikan. Minastir mengatur agar semua node (kecuali Durin) hanya dapat mengirim pesan ke luar Arda setelah melewati pemeriksaan di Minastir.

di durin
```
# NAT & forwarding (kalau belum)
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -C POSTROUTING -o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Bersihkan FORWARD agar prediktif (opsional)
iptables -F FORWARD

# Izinkan LALU LINTAS INTERNAL 10.67.0.0/16 (antar-subnet bebas)
iptables -A FORWARD -s 10.67.0.0/16 -d 10.67.0.0/16 -j ACCEPT

# Izinkan trafik balik yang sudah established
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# HANYA Minastir (10.67.5.2) boleh keluar ke Internet via eth0
iptables -A FORWARD -s 10.67.5.2 -o eth0 -j ACCEPT

# BLOK semua host lain yang coba keluar ke Internet
iptables -A FORWARD -o eth0 -j REJECT

# (opsional) blok DNS langsung ke luar kecuali dari Minastir
iptables -A FORWARD -o eth0 -p udp --dport 53 ! -s 10.67.5.2 -j REJECT
iptables -A FORWARD -o eth0 -p tcp --dport 53 ! -s 10.67.5.2 -j REJECT
```

di minastir
```
apt-get update -y
apt-get install -y squid

cp /etc/squid/squid.conf /etc/squid/squid.conf.bak.$(date +%F_%T) 2>/dev/null || true
cat >/etc/squid/squid.conf <<'EOF'
visible_hostname minastir
http_port 3128

# izinkan seluruh jaringan 10.67.0.0/16
acl localnet src 10.67.0.0/16
http_access allow localnet
http_access deny all

# resolver upstream lab (sesuai aturan awal)
dns_nameservers 192.168.122.1

# optimasi ringan
cache_mem 64 MB
maximum_object_size 16 MB
cache_dir ufs /var/spool/squid 100 16 256
EOF

# reload/start (image ini biasanya tanpa systemd → pakai service atau reconfigure)
service squid restart || squid -k reconfigure

# Cek status
squid -k parse
ps aux | grep [s]quid
ss -lntp | grep ':3128' || true

# DNS forwarder dnsmasq (→ 192.168.122.1)
apt update
apt install bind9 -y

cat > /etc/bind/named.conf.options << EOF
options {
    directory "/var/cache/bind";
    forwarders {
        192.168.122.1;
    };
    forward only;
    allow-query { any; };
    dnssec-validation no;
    auth-nxdomain no;
    listen-on-v6 { any; };
};
EOF

service named restart

# verifikasi listen di :53
ss -lunp | grep ':53' || true
```

di client
```
cat >/etc/resolv.conf <<'EOF'
nameserver 10.67.5.2
options timeout:2 attempts:2
EOF

# Cara pakai proxy dari klien (curl/lynx/apt)
# DNS test (harus resolve lewat Minastir)
getent hosts example.com || dig +short example.com @10.67.5.2

# HTTP/HTTPS via proxy (satu baris)
http_proxy=http://10.67.5.2:3128 https_proxy=http://10.67.5.2:3128 curl -I https://example.com

# lynx (set env dulu)
export http_proxy=http://10.67.5.2:3128
export https_proxy=http://10.67.5.2:3128
lynx https://example.com

#tertolak
ping google.com


# penting untuk semua host (kalau mau buka internet harus pasang ini di setiap host)
echo -e "nameserver 10.67.5.2\noptions timeout:2 attempts:2" > /etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```

<img width="803" height="434" alt="Screenshot 2025-10-31 125428" src="https://github.com/user-attachments/assets/4d0348b0-5425-4e04-9902-f2cbfbe6f026" />




## Soal 4
Ratu Erendis, sang pembuat peta, menetapkan nama resmi untuk wilayah utama (<xxxx>.com). Ia menunjuk dirinya (ns1.<xxxx>.com) dan muridnya Amdir (ns2.<xxxx>.com) sebagai penjaga peta resmi. Setiap lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher) diberikan nama domain unik yang menunjuk ke lokasi fisik tanah mereka. Pastikan Amdir selalu menyalin peta (master-slave) dari Erendis dengan setia.

di erendis
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update # atau apt update -o Acquire::ForceIPv4=true -y
apt install bind9 bind9utils bind9-doc -y
mkdir -p /etc/bind/zones /var/log/named

cat >/etc/bind/named.conf.options <<'EOF'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };

    recursion no; # Erendis adalah master, bukan forwarder
    dnssec-validation no;
    auth-nxdomain no;
};
EOF

cat >/etc/bind/named.conf.local <<'EOF'
zone "K07.com" {
    type master;
    file "/etc/bind/zones/db.K07.com";
    allow-transfer { 10.67.3.11; };
    also-notify   { 10.67.3.11; };
};
EOF

# /etc/bind/zones/db.K07.com
cat >/etc/bind/zones/db.K07.com <<'EOF'
$TTL    604800
@       IN      SOA     ns1.K07.com. admin.K07.com. (
                        2025110101  ; Serial
                        604800      ; Refresh
                        86400       ; Retry
                        2419200     ; Expire
                        604800 )    ; Negative TTL

; ===== Nameservers =====
@       IN      NS      ns1.K07.com.
@       IN      NS      ns2.K07.com.

; ===== A Records =====
ns1     IN      A       10.67.3.10
ns2     IN      A       10.67.3.11

palantir   IN A 10.67.4.3
elros      IN A 10.67.1.61
pharazon   IN A 10.67.2.21
elendil    IN A 10.67.1.10
isildur    IN A 10.67.1.11
anarion    IN A 10.67.1.12
galadriel  IN A 10.67.2.10
celeborn   IN A 10.67.2.11
oropher    IN A 10.67.2.12
EOF

# Berikan kepemilikan ke user 'bind'
chown -R bind:bind /etc/bind/zones /var/log/named
chmod 644 /etc/bind/zones/db.K07.com

# Validasi & Jalankan BIND9 (manual mode)
named-checkconf
named-checkzone K07.com /etc/bind/zones/db.K07.com
service named restart
service named status

ss -lunp | grep :53
```

di amdir
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update # atau apt update -o Acquire::ForceIPv4=true -y
apt install bind9 bind9utils -y
mkdir -p /var/lib/bind /var/log/named

cat > /etc/bind/named.conf.options <<'EOF'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };
    recursion no;
};
EOF

cat > /etc/bind/named.conf.local <<'EOF'
zone "K07.com" {
    type slave;
    masters { 10.67.3.10; }; # IP Erendis
    file "/var/lib/bind/db.K07.com";
};
EOF

# Atur Izin Folder (agar bisa menulis salinan zona)
chown -R bind:bind /var/lib/bind /var/cache/bind /var/log/named

# Jalankan DNS Slave
named-checkconf
service named restart
service named status
ss -lunp | grep :53
```

uji di client
```
echo "nameserver 10.67.3.11" >/etc/resolv.conf

# uji doamin
dig +short ns1.K07.com
dig +short ns2.K07.com
dig +short elros.K07.com
dig +short pharazon.K07.com
dig +short galadriel.K07.com

```

<img width="795" height="120" alt="Screenshot 2025-10-31 155945" src="https://github.com/user-attachments/assets/97f7db72-ebdc-4555-9dd2-c092d574c352" />


## Soal 5
Untuk memudahkan, nama alias www.<xxxx>.com dibuat untuk peta utama <xxxx>.com. Reverse PTR juga dibuat agar lokasi Erendis dan Amdir dapat dilacak dari alamat fisik tanahnya. Erendis juga menambahkan pesan rahasia (TXT record) pada petanya: "Cincin Sauron" yang menunjuk ke lokasi Elros, dan "Aliansi Terakhir" yang menunjuk ke lokasi Pharazon. Pastikan Amdir juga mengetahui pesan rahasia ini.

di durin
```
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
# Simpan jika pakai iptables-persistent
command -v netfilter-persistent >/dev/null 2>&1 && netfilter-persistent save || true
```

di minastir
```
nano /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    listen-on { 10.67.5.2; 127.0.0.1; };
    allow-query { 10.67.0.0/16; 127.0.0.1; };

    recursion yes;
    forwarders {
        192.168.122.1;
    };
    
    #forward only; # hapus baris enih yah
    dnssec-validation no;
    auth-nxdomain no;
};

nano /etc/bind/named.conf.local
zone "K07.com" {
    type forward;
    forwarders { 10.67.3.10; 10.67.3.11; }; # IP Erendis & Amdir
};
zone "3.67.10.in-addr.arpa" {
    type forward;
    forwarders { 10.67.3.10; 10.67.3.11; }; # IP Erendis & Amdir
};

# restart service
service named restart

# Verifikasi
ss -lunp | grep ':53' || true
dig @10.67.5.2 +short K07.com || true

# tes dari klaien
echo "nameserver 10.67.5.2" > /etc/resolv.conf
# Tes query interna
dig +short elendil.k07.com
# Tes query internet (diteruskan ke 192.168.122.1)
dig +short google.com
```

di erendis
```
# Akses internet via Minastir (proxy & DNS)
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update -o Acquire::ForceIPv4=true -y
apt install -y bind9 bind9utils bind9-doc

mkdir -p /etc/bind/zones /var/log/named
chown -R bind:bind /etc/bind/zones /var/log/named

# Opsi global: authoritative-only
cat >/etc/bind/named.conf.options <<'EOF'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };

    recursion no;
    dnssec-validation no;
    auth-nxdomain no;
};
EOF

# Deklarasi zona (forward & reverse 10.67.3.0/24)
cat >/etc/bind/named.conf.local <<'EOF'
zone "K07.com" {
    type master;
    file "/etc/bind/zones/db.K07.com";
    allow-transfer { 10.67.3.11; };
    also-notify   { 10.67.3.11; };
    notify yes;
};

zone "3.67.10.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.10.67.3";
    allow-transfer { 10.67.3.11; };
    also-notify   { 10.67.3.11; };
    notify yes;
};
EOF

# File zona forward (+ apex, www, TXT)
SERIAL=$(date +%Y%m%d%H)
cat >/etc/bind/zones/db.K07.com <<EOF
\$TTL 604800
@   IN  SOA   ns1.K07.com. admin.K07.com. (
        ${SERIAL} ; Serial
        604800    ; Refresh
        86400     ; Retry
        2419200   ; Expire
        604800 )  ; Negative TTL

; NS
@       IN  NS  ns1.K07.com.
@       IN  NS  ns2.K07.com.

; Glue
ns1     IN  A   10.67.3.10
ns2     IN  A   10.67.3.11

; Host penting
palantir   IN A 10.67.4.3
elros      IN A 10.67.1.61
pharazon   IN A 10.67.2.21
elendil    IN A 10.67.1.10
isildur    IN A 10.67.1.11
anarion    IN A 10.67.1.12
galadriel  IN A 10.67.2.10
celeborn   IN A 10.67.2.11
oropher    IN A 10.67.2.12

; Apex & alias
@       IN  A       10.67.1.61
www     IN  CNAME   @

; TXT rahasia
elros      IN TXT "Cincin Sauron"
pharazon   IN TXT "Aliansi Terakhir"
EOF

# File zona reverse (PTR untuk ns1 & ns2)
cat >/etc/bind/zones/db.10.67.3 <<EOF
\$TTL 604800
@   IN  SOA   ns1.K07.com. admin.K07.com. (
        ${SERIAL}
        604800
        86400
        2419200
        604800 )

@       IN  NS      ns1.K07.com.
@       IN  NS      ns2.K07.com.

10      IN  PTR     ns1.K07.com.
11      IN  PTR     ns2.K07.com.
EOF

# Izin file zona
chown -R bind:bind /etc/bind/zones
chmod 644 /etc/bind/zones/db.K07.com /etc/bind/zones/db.10.67.3

# Validasi & start (systemd atau manual)
named-checkconf
named-checkzone K07.com /etc/bind/zones/db.K07.com
named-checkzone 3.67.10.in-addr.arpa /etc/bind/zones/db.10.67.3
systemctl restart bind9 2>/dev/null || {
  pkill named 2>/dev/null || true
  nohup named -4 -u bind -c /etc/bind/named.conf >/var/log/named/named.log 2>&1 &
}
sleep 2
ss -lunp | grep ':53' || true

# Tes langsung ke master
dig @10.67.3.10 +short K07.com
dig @10.67.3.10 +short www.K07.com
dig @10.67.3.10 +short elros.K07.com TXT
dig @10.67.3.10 +short pharazon.K07.com TXT

# AMDIR – DNS SLAVE (BIND) – 10.67.3.11
# Akses internet via Minastir (proxy & DNS)
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update -o Acquire::ForceIPv4=true -y
apt install -y bind9 bind9utils
mkdir -p /var/lib/bind /var/cache/bind /var/log/named
chown -R bind:bind /var/lib/bind /var/cache/bind /var/log/named

# Opsi global: authoritative-only
cat >/etc/bind/named.conf.options <<'EOF'
options {
    directory "/var/cache/bind";
    listen-on { any; };
    allow-query { any; };

    recursion no;
    dnssec-validation no;
    auth-nxdomain no;
};
EOF

# Zona slave (forward & reverse)
cat >/etc/bind/named.conf.local <<'EOF'
zone "K07.com" {
    type slave;
    masters { 10.67.3.10; };
    file "/var/lib/bind/db.K07.com";
};

zone "3.67.10.in-addr.arpa" {
    type slave;
    masters { 10.67.3.10; };
    file "/var/lib/bind/db.10.67.3";
};
EOF

# Start (systemd atau manual)
systemctl restart bind9 2>/dev/null || {
  pkill named 2>/dev/null || true
  nohup named -4 -u bind -c /etc/bind/named.conf >/var/log/named/named.log 2>&1 &
}
sleep 3

# Pastikan file zona tersalin
ls -l /var/lib/bind/ || true
dig @10.67.3.11 K07.com SOA +noall +answer || true
dig @10.67.3.11 +short K07.com || true
dig @10.67.3.11 +short www.K07.com || true

# UPDATE ZONA (MASTER) – Bump Serial & Notify (satu perintah)
# Jalankan di Erendis setiap habis edit file zona forward
SERIAL=$(date +%Y%m%d%H)
sed -i "0,/SOA/s/[0-9]\{10,\}/${SERIAL}/" /etc/bind/zones/db.K07.com
named-checkzone K07.com /etc/bind/zones/db.K07.com
rndc reload K07.com || (systemctl restart bind9 || true)
rndc notify K07.com || true

# (Reverse, kalau diubah)
SERIAL=$(date +%Y%m%d%H)
sed -i "0,/SOA/s/[0-9]\{10,\}/${SERIAL}/" /etc/bind/zones/db.10.67.3
named-checkzone 3.67.10.in-addr.arpa /etc/bind/zones/db.10.67.3
rndc reload 3.67.10.in-addr.arpa || true
rndc notify 3.67.10.in-addr.arpa || true
```

uji di minastir
```
dig @10.67.5.2 +short K07.com
dig @10.67.5.2 +short www.K07.com
dig @10.67.5.2 +short elros.K07.com TXT
dig @10.67.5.2 +short pharazon.K07.com TXT
```

uji di client
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
dig +short ns1.K07.com
dig +short ns2.K07.com
dig +short K07.com
dig +short www.K07.com
dig +short elros.K07.com TXT
dig +short pharazon.K07.com TXT
dig -x 10.67.3.10 +short
dig -x 10.67.3.11 +short
```

<img width="794" height="231" alt="Screenshot 2025-10-31 161233" src="https://github.com/user-attachments/assets/297c78a8-fef3-42ef-821c-ddbe6e44fb74" />

## Soal 6
Aldarion menetapkan aturan waktu peminjaman tanah. Ia mengatur:
- Client Dinamis Keluarga Manusia dapat meminjam tanah selama setengah jam.
- Client Dinamis Keluarga Peri hanya seperenam jam.
- Batas waktu maksimal peminjaman untuk semua adalah satu jam.


### di Aldarion
- Persiapan dasar
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF

apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-server
```
- Atur interface (tadi sudahh)
```
nano /etc/default/isc-dhcp-server

INTERFACESv4="eth0"
INTERFACESv6=""
```
- Update konfigurasi dhcpd.conf dengan waktu sewa yang baru
```
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
```
- jalankan ulang DHCP
```
service isc-dhcp-server restart
service isc-dhcp-server status --no-pager || true
```

### Di Durin
- Pastikan relay sudah aktif dan interface sudah benar, kemudian restart DHCP.
```
nano /etc/default/isc-dhcp-relay
SERVERS="10.67.4.2"
INTERFACES="eth1 eth2 eth3 eth4 eth5"
OPTIONS=""

service isc-dhcp-relay restart
service isc-dhcp-server status --no-pager || true
```

### Uji dari klien manusia dan peri
#### Di Klien Manusia (amandil dkk)
- Tambahkan resolver awal (memastikan)
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```
- Memastikan DHCP client sudah terinstall
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-client
```
- Dapatkan IP
```
dhclient -r -v && dhclient -v
```

#### Di Klien Peri (gilgalad dkk)
- Tambahkan resolver awal (memastikan)
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```
- Memastikan DHCP client sudah terinstall
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y isc-dhcp-client
```
- Dapatkan IP
```
dhclient -r -v && dhclient -v
```

<img width="319" height="492" alt="image" src="https://github.com/user-attachments/assets/f874e40b-b159-446d-b468-aba3d2581ef6" />
<img width="305" height="493" alt="image" src="https://github.com/user-attachments/assets/d0a9cedc-d123-4eb2-b102-aad849a21cbc" />



## Soal 7
Para Ksatria Númenor (Elendil, Isildur, Anarion) mulai membangun benteng pertahanan digital mereka menggunakan teknologi Laravel. Instal semua tools yang dibutuhkan (php8.4, composer, nginx) dan dapatkan cetak biru benteng dari Resource-laravel di setiap node worker Laravel. Cek dengan lynx di client.
### Di Elendil, Isildur, dan Anarion
- Atur DNS dan proxy agar bisa konek inet
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" > /etc/resolv.conf
export http_proxy=http://10.67.5.2:3128
export https_proxy=http://10.67.5.2:3128
export COMPOSER_ALLOW_SUPERUSER=1
```
- Install dependensi dasar
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y curl git unzip ca-certificates lsb-release gnupg apt-transport-https
```
- Tambahkan repo PHP 8.4
```
curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/sury.gpg >/dev/null
echo "deb https://packages.sury.org/php $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury.list
apt update -o Acquire::ForceIPv4=true -y
```
- Install PHP dan ngix
```
apt install -y \
  php8.4-fpm php8.4-cli php8.4-common php8.4-curl php8.4-mbstring php8.4-xml \
  php8.4-zip php8.4-gd php8.4-intl php8.4-bcmath php8.4-mysql php8.4-sqlite3 \
  nginx
```
- Install composer
```
curl -o composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -f composer-setup.php
composer --version
```
- Nuat direktori web dan hapus resources laravel yg lama (klo ada)
```
mkdir -p /var/www
cd /var/www
rm -rf resource-laravel
```
- clone resources, masuk ke folder kemudian update composer
```
git clone https://github.com/elshiraphine/laravel-simple-rest-api resource-laravel
cd resource-laravel
composer update --no-dev
```
- Salin file .env
```
cp .env.example .env
```
- Generate kunci aplikasi
```
php artisan key:generate
```
- Atur izin folder
```
chown -R www-data:www-data /var/www/resource-laravel
chmod -R 775 /var/www/resource-laravel/storage
chmod -R 775 /var/www/resource-laravel/bootstrap/cache
```
### Konfig nginx di setiap worker
#### Di Elendil
- buat domain
```
DOMAIN="elendil.k07.com"
```
- hapus vhost default
```
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
```
- Buat vhost baru
```
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
```
- Aktifkan vhost dan restart service
```
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart
```
#### Di Isildur
- buat domain
```
DOMAIN="isildur.k07.com"
```
- hapus vhost default
```
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
```
- Buat vhost baru
```
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
```
- Aktifkan vhost dan restart service
```
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart
```
#### Di Anarion
- buat domain
```
DOMAIN="anarion.k07.com"
```
- hapus vhost default
```
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
```
- Buat vhost baru
```
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
```
- Aktifkan vhost dan restart service
```
ln -sf /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/laravel.conf
nginx -t && service nginx restart && service php8.4-fpm restart
```
### Verifikasi di klien
- Atur dns dan proxy (kalo belum)
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```
` Install lynx
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx
```
- Tes ketiga worker
```
lynx -dump http://elendil.k07.com
lynx -dump http://isildur.k07.com
lynx -dump http://anarion.k07.com
```

<img width="607" height="422" alt="image" src="https://github.com/user-attachments/assets/380507cc-7fcd-4990-be74-99652dcb7296" />


## Soal 8
Setiap benteng Númenor harus terhubung ke sumber pengetahuan, Palantir. Konfigurasikan koneksi database di file .env masing-masing worker. Setiap benteng juga harus memiliki gerbang masuk yang unik; atur nginx agar Elendil mendengarkan di port 8001, Isildur di 8002, dan Anarion di 8003. Jangan lupa jalankan migrasi dan seeding awal dari Elendil. Buat agar akses web hanya bisa melalui domain nama, tidak bisa melalui ip.

### Palantir
- Setup akses inet via ministar (egein if nid)
```
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" > /etc/resolv.conf
cat > /etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```
- Install MariaDB
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y mariadb-server
```
- Buka akses jaringan, restart MariaDB
```
sed -i 's/^\(bind-address\s*=\s*\).*/\10.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb restart
```
- Buat database dan user baru
```
mariadb -u root <<'EOF'
CREATE DATABASE IF NOT EXISTS laravel_db;
DROP USER IF EXISTS 'laravel_user'@'%';
CREATE USER 'zeinganteng'@'%' IDENTIFIED BY 'nandakocak';
GRANT ALL PRIVILEGES ON laravel_db.* TO 'zeinganteng'@'%';
FLUSH PRIVILEGES;
EOF
```
### Di Elendil, Isildur, dan Anarion
- Masuk ke direktori web
```
cd /var/www/resource-laravel
```
- Masukkan database
```
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
```
- Konfigurasi .env sesuai user dan database yang dibuat tadi.
```
sed -i "s/DB_HOST=127.0.0.1/DB_HOST=10.67.4.3/" .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=laravel_db/" .env
sed -i "s/^DB_USERNAME=.*/DB_USERNAME=zeinganteng/" .env
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=nandakocak/" .env
```
#### Di Elendil (khusus ada seeding)
- Migrasi dan seeding
```
php artisan migrate:fresh --seed
```
- Konfigurasi Nginx
```
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
```
#### Di Isildur
- Konfigurasi Nginx
```
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
```
#### Di Anarion
- Konfig Nginx
```
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
```
### Uji di klien, misal Pharazon
- Install lynx
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx
```
- Tes blokir akses via IP
```
lynx -dump http://10.67.1.10:8001
lynx -dump http://10.67.1.11:8002
lynx -dump http://10.67.1.12:8003
```
- Tes koneksi database
```
lynx -dump http://elendil.k07.com:8001/api/airing
lynx -dump http://isildur.k07.com:8002/api/airing
lynx -dump http://anarion.k07.com:8003/api/airing
```

<img width="390" height="152" alt="image" src="https://github.com/user-attachments/assets/2a9ff895-dd49-4c9e-ab35-24be6fc1a76f" />
<img width="424" height="205" alt="image" src="https://github.com/user-attachments/assets/40579fa4-8682-4737-a145-a2126b752fa8" />


## Soal 9
Pastikan setiap benteng berfungsi secara mandiri. Dari dalam node client masing-masing, gunakan lynx untuk melihat halaman utama Laravel dan curl /api/airing untuk memastikan mereka bisa mengambil data dari Palantir.

### Di klien, misal Pharazon
- Pastikan dns dan proxy
```
printf "nameserver 10.67.5.2\n" > /etc/resolv.conf

cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF
```
- Instalasi curl dan lynx
```
apt update -o Acquire::ForceIPv4=true -y
apt install -y lynx curl
```
- Uji elendil
```
lynx -dump http://elendil.K07.com:8001/api/airing
curl http://elendil.K07.com:8001/api/airing
```
- Uji Isildur
```
lynx -dump http://isildur.K07.com:8002/api/airing
curl http://isildur.K07.com:8002/api/airing
```
- Uji Anarion
```
lynx -dump http://anarion.K07.com:8003/api/airing
curl http://anarion.K07.com:8003/api/airing
```

<img width="421" height="211" alt="image" src="https://github.com/user-attachments/assets/ae4c81a7-de74-472b-8252-6e782a98ef5d" />
