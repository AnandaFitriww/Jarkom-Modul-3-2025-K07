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


## Soal 3
Untuk mengontrol arus informasi ke dunia luar (Valinor/Internet), sebuah menara pengawas, Minastir didirikan. Minastir mengatur agar semua node (kecuali Durin) hanya dapat mengirim pesan ke luar Arda setelah melewati pemeriksaan di Minastir.


## Soal 4
Ratu Erendis, sang pembuat peta, menetapkan nama resmi untuk wilayah utama (<xxxx>.com). Ia menunjuk dirinya (ns1.<xxxx>.com) dan muridnya Amdir (ns2.<xxxx>.com) sebagai penjaga peta resmi. Setiap lokasi penting (Palantir, Elros, Pharazon, Elendil, Isildur, Anarion, Galadriel, Celeborn, Oropher) diberikan nama domain unik yang menunjuk ke lokasi fisik tanah mereka. Pastikan Amdir selalu menyalin peta (master-slave) dari Erendis dengan setia.


## Soal 5
Untuk memudahkan, nama alias www.<xxxx>.com dibuat untuk peta utama <xxxx>.com. Reverse PTR juga dibuat agar lokasi Erendis dan Amdir dapat dilacak dari alamat fisik tanahnya. Erendis juga menambahkan pesan rahasia (TXT record) pada petanya: "Cincin Sauron" yang menunjuk ke lokasi Elros, dan "Aliansi Terakhir" yang menunjuk ke lokasi Pharazon. Pastikan Amdir juga mengetahui pesan rahasia ini.


## Soal 6
Aldarion menetapkan aturan waktu peminjaman tanah. Ia mengatur:
- Client Dinamis Keluarga Manusia dapat meminjam tanah selama setengah jam.
- Client Dinamis Keluarga Peri hanya seperenam jam.
- Batas waktu maksimal peminjaman untuk semua adalah satu jam.


## Soal 7
Para Ksatria Númenor (Elendil, Isildur, Anarion) mulai membangun benteng pertahanan digital mereka menggunakan teknologi Laravel. Instal semua tools yang dibutuhkan (php8.4, composer, nginx) dan dapatkan cetak biru benteng dari Resource-laravel di setiap node worker Laravel. Cek dengan lynx di client.


## Soal 8
Setiap benteng Númenor harus terhubung ke sumber pengetahuan, Palantir. Konfigurasikan koneksi database di file .env masing-masing worker. Setiap benteng juga harus memiliki gerbang masuk yang unik; atur nginx agar Elendil mendengarkan di port 8001, Isildur di 8002, dan Anarion di 8003. Jangan lupa jalankan migrasi dan seeding awal dari Elendil. Buat agar akses web hanya bisa melalui domain nama, tidak bisa melalui ip.


## Soal 9
Pastikan setiap benteng berfungsi secara mandiri. Dari dalam node client masing-masing, gunakan lynx untuk melihat halaman utama Laravel dan curl /api/airing untuk memastikan mereka bisa mengambil data dari Palantir.


## Soal 10
Pemimpin bijak Elros ditugaskan untuk mengkoordinasikan pertahanan Númenor. Konfigurasikan nginx di Elros untuk bertindak sebagai reverse proxy. Buat upstream bernama kesatria_numenor yang berisi alamat ketiga worker (Elendil, Isildur, Anarion). Atur agar semua permintaan yang datang ke domain elros.<xxxx>.com diteruskan secara merata menggunakan algoritma Round Robin ke backend.


