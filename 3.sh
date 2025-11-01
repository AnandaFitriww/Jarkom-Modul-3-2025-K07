# Durin
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

# Minastir
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

# Erendil dan di semuanya
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
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
cat >/etc/apt/apt.conf.d/00proxy <<'EOF'
Acquire::http::Proxy  "http://10.67.5.2:3128";
Acquire::https::Proxy "http://10.67.5.2:3128";
EOF


