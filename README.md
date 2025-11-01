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
| Durin    | eth1      | 10.67.1.1   | -         |
|              | eth2      | 10.67.2.1   | -         |
|              | eth3      | 10.67.3.1   | -         |
| Minastir    | eth0      | 10.67.1.2   | 10.67.1.1 |
| Aldarion | eth0      | 10.67.1.3   | 10.67.1.1 |
| Erendis     | eth0      | 10.67.2.2   | 10.67.2.1 |
| Amdir   | eth0      | 10.67.2.3   | 10.67.2.1 |
| Palantir   | eth0      | 10.67.2.4   | 10.67.2.1 |
| Narvi   | eth0      | 10.67.3.2   | 10.67.3.1 |
| Elros   | eth0      | 10.67.3.3   | 10.67.3.1 |
| Pharazon   | eth0      | 10.67.3.4   | 10.67.3.1 |
| Elendil   | eth0      | 10.67.3.5   | 10.67.3.1 |
| Isildur   | eth0      | 10.67.3.6   | 10.67.3.1 |
| Anarion    | eth0      | 10.67.1.2   | 10.67.1.1 |
| Galadriel | eth0      | 10.67.1.3   | 10.67.1.1 |
| Celeborn     | eth0      | 10.67.2.2   | 10.67.2.1 |
| Oropher   | eth0      | 10.67.2.3   | 10.67.2.1 |
| Miriel   | eth0      | 10.67.2.4   | 10.67.2.1 |
| Celebrimbor   | eth0      | 10.67.3.2   | 10.67.3.1 |
| Gilgalad   | eth0      | 10.67.3.3   | 10.67.3.1 |
| Amandil   | eth0      | 10.67.3.4   | 10.67.3.1 |
| Khamul   | eth0      | 10.67.3.5   | 10.67.3.1 |


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
    address 10.67.1.2
    netmask 255.255.255.0
    gateway 10.67.1.1
dns-nameservers 192.168.122.1
```

#### Aldarion Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.3
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Erendis Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.2
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Amdir Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.3
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Palantir Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.4
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Narvi Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.2
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elros Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.3
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Pharazon Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.4
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elendil Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.5
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Isildur Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.6
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Anarion Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.2
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Galadriel Config
```
auto eth0
iface eth0 inet static
    address 10.67.1.3
    netmask 255.255.255.0
    gateway 10.67.1.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Celeborn Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.2
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Oropher Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.3
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Miriel Config
```
auto eth0
iface eth0 inet static
    address 10.67.2.4
    netmask 255.255.255.0
    gateway 10.67.2.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Celebrimbor Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.2
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Gilgalad Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.3
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Amandil Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.4
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Khamul Config
```
auto eth0
iface eth0 inet static
    address 10.67.3.5
    netmask 255.255.255.0
    gateway 10.67.3.1
	up echo nameserver 192.168.122.1 > /etc/resolv.conf
```


