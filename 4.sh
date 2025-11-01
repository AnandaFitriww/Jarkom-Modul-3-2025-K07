# ERENDIS (DNS MASTER)
printf "nameserver 192.168.122.1\n" >/etc/resolv.conf
apt-get update -o Acquire::ForceIPv4=true -y
apt-get install -y bind9 bind9utils bind9-doc
mkdir -p /etc/bind/zones /var/log/named

nano /etc/bind/named.conf.local
zone "K07.com" {
    type master;
    file "/etc/bind/zones/db.K07.com";
    allow-transfer { 10.67.3.11; };
    also-notify { 10.67.3.11; };
};

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

# Validasi & Jalankan BIND9 (manual mode)
named-checkconf
named-checkzone K07.com /etc/bind/zones/db.K07.com
pkill named 2>/dev/null || true
nohup named -4 -u bind -c /etc/bind/named.conf > /var/log/named/named.log 2>&1 &
ss -lunp | grep :53

# AMDIR (DNS SLAVE)
printf "nameserver 192.168.122.1\n" >/etc/resolv.conf
apt-get update -o Acquire::ForceIPv4=true -y
apt-get install -y bind9 bind9utils
mkdir -p /var/lib/bind /var/log/named

nano /etc/bind/named.conf.local
zone "K07.com" {
    type slave;
    masters { 10.67.3.10; };
    file "/var/lib/bind/db.K07.com";
};

# Jalankan DNS Slave
named-checkconf
pkill named 2>/dev/null || true
nohup named -4 -u bind -c /etc/bind/named.conf > /var/log/named/named.log 2>&1 &
ss -lunp | grep :53

# Pengujian dari Klien (contoh: Pharazon)
echo "nameserver 10.67.3.11" >/etc/resolv.conf

# uji doamin
dig +short ns1.K07.com
dig +short ns2.K07.com
dig +short elros.K07.com
dig +short pharazon.K07.com
dig +short galadriel.K07.com
