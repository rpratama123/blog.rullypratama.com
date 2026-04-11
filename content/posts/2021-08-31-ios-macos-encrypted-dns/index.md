---
title: "Cara Mengaktifkan Encrypted DNS di Perangkat iOS dan macOS"
date: "2021-08-31"
description: "Amankan traffic internet kamu dari blokir menggunakan encrypted DNS"
categories:
- "Tutorial"
- "Random"
keywords:
- "encrypted dns"
- "secure dns"
- "dns over https"
- "dns over https iphone"
- "doh"
- "doh iphone"
---

{{< img src="secure-dns-thumbnail.png" width="800" alt="Encrypted DNS di iOS iPhone" caption="Encrypted DNS di iOS iPhone." >}}

Sebenarnya sejak **iOS 14 dan macOS Big Sur**, kedua sistem operasi ini sudah mendukung *encrypted DNS* atau DNS-over-HTTPS / TLS. Berbeda dengan Android, pengaturan *encrypted DNS* tidak bisa langsung diakses oleh pengguna. Yuk cari tahu untuk mengaktifkan fitur ini.

## DNS dan Fungsinya

Setiap perangkat yang terhubung ke jaringan internet memiliki identitas yang unik. Salah satu identitas tersebut adalah IP address. Agar satu perangkat bisa berkomunikasi dengan perangkat yang lain, IP address perangkat harus diketahui terlebih dahulu.

IP address berupa kombinasi angka yang tidak dapat diingat dengan mudah oleh manusia. Misalnya 103.102.166.224 atau 142.251.10.139. Nah agar manusia bisa mengakses internet dengan alamat tertentu, misalnya google.com atau wikipedia.org, maka harus ada mesin yang berfungsi untuk menerjemahkan alamat web ke IP address. Untuk itu DNS (Domain Name System) server diciptakan.

{{< img src="secure-dns-illustration.webp" width="800" alt="Ilustrasi DNS Ternkripsi" caption="Ilustrasi DNS Ternkripsi." >}}

Sayangnya, alamat web yang kita tuju bisa dibaca dengan mudah oleh pihak lain, bisa jadi penyedia layanan internet, pengelola WIFI, atau bahkan orang jahat. Sebab alamat web yang kita tanyakan ke DNS server tidak terenkripsi. Untuk menghindari hal ini, sangat disarankan untuk menggunakan *encrypted DNS* di berbagai perangkat yang terhubung dengan internet.

## Solusi 1: Menggunakan Aplikasi Pihak Ketiga

Telah saya sebutkan sebelumnya bahwa pengaturan untuk *encrypted DNS* di iOS dan macOS tidak bisa langsung diakses dengan mudah oleh pengguna. Oleh karenanya, banyak aplikasi dan penyedia jasa yang menawarkan layanannya. Salah satunya adalah [1.1.1.1](https://1.1.1.1/) dari Cloudflare. Aplikasi VPN seperti ProtonVPN atau NordVPN juga mengaktifkan *encrypted DNS* ketika menggunakan layanan mereka.

Meskipun mudah untuk digunakan, saya kurang menyukai solusi ini. Adanya tambahan aplikasi di ponsel bisa mengurangi media penyimpanan, membuat perangkat lebih berat, dst. Selain itu, beberapa layanan khususnya VPN juga meminta konsumen untuk membayar apabila ingin menggunakan fitur yang lebih lengkap.

## Solusi 2: Menggunakan Fitur Bawaan iOS dan macOS

Untuk bisa menggunakan *encrypted DNS* di iOS / iPhone dan macOS /  MacBook, pengguna harus mengunduh *configuration profile* yang nantinya akan memberitahu sistem operasi DNS mana yang harus digunakan.

### Langkah Pertama

Klik tautan berikut ini untuk mengunduh *configuration profile* dari DNS yang ingin digunakan (apabila bingung bisa menggunakan 1.1.1.1 Cloudflare atau Google DNS):

* [1.1.1.1 / Cloudflare DNS HTTPS](https://github.com/Candygoblen123/encrypted-dns/raw/master/signed/cloudflare-https.mobileconfig)
* [Google DNS HTPPS](https://github.com/Candygoblen123/encrypted-dns/raw/master/signed/google-https.mobileconfig)
* [OpenDNS HTTPS](https://github.com/Candygoblen123/encrypted-dns/raw/master/signed/opendns-https.mobileconfig)
* [Quad9 DNS HTTPS](https://github.com/Candygoblen123/encrypted-dns/raw/master/signed/quad9-https.mobileconfig)

### Langkah Kedua

Setelah mengunduh salah satu profile di atas, akan muncul pemberitahuan yang menyatakan bahwa website ini meminta izin untuk memasang profile di perangkat. Klik **Allow / Izinkan**. Setelah itu pergi ke **Setting / Pengaturan** -> **Profile Downloaded**. Terakhir klik install, lalu masukkan passcode perangkat.

Selamat, perangkatmu sudah menggunakan *encrypted DNS* sehingga website yang kamu kunjungi lebih sukar dipantau atau diblokir oleh penyedia layanan internet! Sekarang seharusnya perangkatmu bisa membuka situs yang diblokir oleh ISP, misalnya [reddit.com](https://reddit.com).

## Namun Perlu Diingat...

Meski penggunaan *encrypted DNS* bisa menghindarkan pengguna dari pelacakan situs yang dikunjungi oleh pihak ketiga, namun tidak menutup kemungkinan DNS server yang kita gunakan justru menyimpan riwayat perjalanan internet kita. Oleh karena itu, silakan pilih penyedia DNS server yang kalian paling percaya.

## Sumber

* [Paul Miller blog](https://paulmillr.com/posts/encrypted-dns/)
* [Paul Miller Github](https://github.com/paulmillr/encrypted-dns)
* [Andrew Glaze Github](https://github.com/Candygoblen123/encrypted-dns/)

