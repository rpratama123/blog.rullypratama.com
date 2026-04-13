---
title: "Install MikroTik RouterOS di Mini PC Headless via Serial Console"
date: "2026-03-30"
description: "Beralih dari pfSense ke RouterOS di perangkat yang tidak memiliki port display butuh sedikit trik. Begini cara instalasinya melalui serial console."
categories:
- "Tutorial"
keywords:
- "mikrotik"
- "routeros"
- "pfsense"
- "intel atom c2358"
- "headless router"
- "serial console"
- "syslinux"
---

Beberapa bulan yang lalu, saya memutuskan untuk beralih dari pfSense ke MikroTik RouterOS. Perangkat yang saya gunakan adalah *small network appliance* berbasis Intel Atom CAF 1020 C2358 yang saya tebus di Tokopedia seharga 900 ribuan.

{{< img src="intel-atom-router.jpg" width="800" alt="Intel Atom CAF 1020 C2358 Router" caption="Penampakan mini PC Intel Atom CAF 1020 C2358." >}}

Alasan saya meninggalkan pfSense cukup sederhana: saya sangat menyukai sifat RouterOS yang jauh lebih ringan (*lightweight*), *boot time* yang sangat cepat, serta kustomisasi yang lebih granular yang ditawarkan oleh WinBox. 

Perangkat ini sangat irit daya, hanya memakan sekitar 10 watt saja bahkan saat dalam kondisi *load*. Sistem pendinginannya pasif (*passively cooled*), sehingga bodi perangkat akan terasa sedikit hangat saat disentuh. Sampai tulisan ini dibuat, *router* mungil ini sudah berjalan selama hampir setahun tanpa ada kendala sama sekali.

## Kendala Instalasi Tanpa Layar

Meski secara *hardware* sangat memuaskan, *appliance* ini tidak memiliki *port video output* (VGA/HDMI) sama sekali alias *headless*. Saat menginstal pfSense dulu, prosesnya berjalan sangat mulus karena *installer* pfSense secara *native* mendukung *booting* melalui *serial session*.

Sayangnya, instalasi MikroTik RouterOS tidak semudah itu. *Installer* bawaannya tidak akan memunculkan apa-apa di *serial console* secara otomatis. Jadi kita butuh sedikit modifikasi agar tampilan instalasi bisa dialihkan ke *serial port*.

## Solusi: Modifikasi syslinux.cfg

*Workaround*-nya sebenarnya cukup sederhana. Kita hanya perlu mengedit *file* konfigurasi `syslinux.cfg` yang ada di dalam media instalasi (seperti USB *flash disk*). 

Buka media instalasi dari PC lain, lalu cari dan edit *file* tersebut. Tambahkan perintah `SERIAL` dan `CONSOLE` di bagian paling atas, lalu sisipkan parameter `console=ttyS0,115200n8` pada baris `APPEND`.

Kurang lebih, hasil modifikasi `syslinux.cfg` akan terlihat seperti ini:

```text
$ cat /mnt/syslinux.cfg
SERIAL 0 115200
CONSOLE 0

default system

LABEL system
 KERNEL linux
 APPEND console=ttyS0,115200n8 load_ramdisk=1 -install -hdd
```

Setelah *file* disimpan, *boot* kembali *mini PC* tersebut menggunakan media instalasi yang sudah dimodifikasi. Sekarang, tampilan menu instalasi MikroTik RouterOS akan muncul dengan sempurna di aplikasi *serial console* (seperti PuTTY atau Tera Term) yang terhubung ke PC.

Selamat mencoba! ✨