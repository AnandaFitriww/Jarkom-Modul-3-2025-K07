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
apt-get install -y dnsmasq

# naikan limit biar tidak error "Too many open files"
grep -q '^ULIMIT=' /etc/default/dnsmasq && \
  sed -i 's/^ULIMIT=.*/ULIMIT=4096/' /etc/default/dnsmasq || \
  echo 'ULIMIT=4096' >> /etc/default/dnsmasq
sysctl -w fs.inotify.max_user_instances=1024
sysctl -w fs.inotify.max_user_watches=1048576

cat >/etc/dnsmasq.d/k07.conf <<'EOF'
listen-address=10.67.5.2
bind-interfaces
server=192.168.122.1
cache-size=1000
EOF

# start (tanpa systemd pun jalan)
service dnsmasq restart || {
  pkill dnsmasq 2>/dev/null || true
  nohup dnsmasq --listen-address=10.67.5.2 --bind-interfaces --server=192.168.122.1 \
        --cache-size=1000 --log-facility=/var/log/dnsmasq.log >/dev/null 2>&1 &
}
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


