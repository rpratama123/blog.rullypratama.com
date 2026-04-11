---
title: "YouTube Tidak Menyimpan History? Mengapa?"
date: "2025-02-22"
categories:
- "Tutorial"
---


Beberapa waktu yang lalu, saya sedang mengikuti turnamen Age of Empire II di YouTube. Turnamen yang berdurasi berjam-jam itu tentunya tidak saya habiskan sekali tonton. Melainkan biasa saya lanjutkan di waktu senggang berikutnya.

YouTube biasanya akan menyimpan riwayat menonton kita. Termasuk apabila satu video tidak ditonton langsung habis. YouTube akan menayangkan tepat di durasi yang sama seperti saat kita berhenti menonton di sesi sebelumnya.

Lalu hal yang aneh terjadi. YouTube tidak menandai sesi tersebut! Ketika saya coba tonton ulang, video diputar dari awal. Bahkan playlist history di YouTube pun tidak merekam video-video yang telah saya tonton sampai habis!

Awalnya saya pikir ini karena aplikasi YouTube di ponsel saya tidak up-to-date. Namun kejanggalan ini juga terjadi di PC yang biasa saya gunakan.

Setelah saya cari di Google, ternyata penyebabnya adalaaaaah...

## DNS alias Domain Name Server

Ya waktu itu saya baru saja memasang [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) di jaringan lokal internet rumah kami. Ada satu domain yang sebenarnya penting bagi YouTube tapi ikut terblokir:

```
s.youtube.com
```

Solusinya mudah, whitelist atau izinkan domain `s.youtube.com` di AgGuard Home, Pi-hole maupun NextDNS agar history di YouTube kembali berfungsi.