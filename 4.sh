# ERENDIS (DNS MASTER)
echo "nameserver 192.168.122.1" > /etc/resolv.conf
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

# AMDIR (DNS SLAVE)
echo "nameserver 192.168.122.1" > /etc/resolv.conf
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

# Pengujian dari Klien (contoh: Pharazon)
echo "nameserver 10.67.3.11" >/etc/resolv.conf

# uji doamin
dig +short ns1.K07.com
dig +short ns2.K07.com
dig +short elros.K07.com
dig +short pharazon.K07.com
dig +short galadriel.K07.com
