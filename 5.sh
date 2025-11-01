#  DURIN (opsional, hanya jika perlu pastikan DNS antar-subnet lancar)
# (Opsional) pastikan port 53 antar-subnet diizinkan
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
# Simpan jika pakai iptables-persistent
command -v netfilter-persistent >/dev/null 2>&1 && netfilter-persistent save || true

# MINASTIR – DNS Forwarder (dnsmasq) – 10.67.5.2
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

# ERENDIS – DNS MASTER (BIND) – 10.67.3.10
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

# UJI DARI MINASTIR
dig @10.67.5.2 +short K07.com
dig @10.67.5.2 +short www.K07.com
dig @10.67.5.2 +short elros.K07.com TXT
dig @10.67.5.2 +short pharazon.K07.com TXT

# Di klien (mis. Pharazon):
printf "nameserver 10.67.5.2\noptions timeout:2 attempts:2\n" >/etc/resolv.conf
dig +short ns1.K07.com
dig +short ns2.K07.com
dig +short K07.com
dig +short www.K07.com
dig +short elros.K07.com TXT
dig +short pharazon.K07.com TXT
dig -x 10.67.3.10 +short
dig -x 10.67.3.11 +short
