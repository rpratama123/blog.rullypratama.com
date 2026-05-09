---
title: "Factory Reset UNV IPC322SR3-VSPF28-C"
date: "2026-04-16"
description: "Cara melakukan factory reset pada IP Camera UNV IPC322SR3-VSPF28-C bekas yang lupa password dengan menghubungkan pin jumper di dalam perangkat."
categories:
  - "Tutorial"
keywords:
  - "unv ip camera"
  - "ipc322sr3-vspf28-c"
  - "factory reset"
  - "hard reset"
  - "lupa password cctv unv"
  - "reset ip camera unv"
featured: false
---

Saya suka mencoba-coba, termasuk urusan CCTV di rumah. Kebetulan karena di NVR yang saya pakai masih tersisa satu slot lagi untuk IP Camera. Maka ketika saya menemukan ada yang menjual IP Camera UNV [bekas pakai]({{< relref "/posts/2023-12-01-old-router-managed-switch-openwrt/index.md" >}}) di Tokopedia dengan harga di bawah 200 ribu rupiah, saya pun langsung tergiur untuk membelinya.

{{< img src="unv-ipcamera.jpg" width="800" alt="IP Camera UNV IPC322SR3-VSPF28-C" caption="IP Camera UNV IPC322SR3-VSPF28-C." >}}

Setelah saya cermati, iklan menyebutkan bahwa IPC tersebut tidak diketahui *username* dan *password*-nya. Hmmm, pasti barang bekas kantor pikir saya. Masalahnya setelah saya cari di web, tidak ada tutorial yang spesifik untuk *hard reset* kamera dengan nomor seri IPC322SR3-VSPF28-C ini. 

Sebelumnya saya sudah pernah membeli IP Camera bekas sebelumnya (EZ-IP IPC-T1B40), dan di web tidak ada tutorial spesifik juga mengenai cara untuk *hard reset*, maka saya pikir pasti saya akan menemukan jumper yang diperlukan untuk proses ini ketika saya bongkar perangkat tersebut. Saya pikir mengatur ulang kamera UNV ini akan semudah EZ-IP, tetapi ternyata saya salah.


{{< img src="IPC322SR3-VSPF28-C.jpg" width="800" alt="IPC322SR3-VSPF28-C hard reset jumper location" caption="Lokasi pin jumper hard reset IPC322SR3-VSPF28-C." >}}

Setelah saya bongkar, ternyata saya tidak menemukan titik kentara yang berfungsi sebagai hard reset. Akhirnya saya coba untuk menyambungkan pin-pin di point 1 dan point 2, dan akhirnya berhasil. IP Camera ini kembali ke setelan pabrik dengan *DHCP client* yang aktif atau bisa diakses di `192.168.1.13` apabila tidak menemukan *DHCP server*.

> **Perhatian!**
>
> Di tulisan ini saya hanya berbagi pengalaman. Kerusakan yang mungkin timbul karena mengikuti langkah yang ada di blog ini adalah tanggung jawab masing-masing.

Namun kembali lagi, karena saya tidak yakin pin mana yang sebenarnya digunakan untuk keperluan reset ini, dan percobaan *random* saya berhasil, maka risiko mohon ditanggung sendiri ya.

Semoga berhasil 🚀