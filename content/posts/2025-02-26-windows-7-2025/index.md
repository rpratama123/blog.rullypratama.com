---
title: "Windows 7: Pengalaman Instalasi dan Penggunaan di Tahun 2025"
date: "2025-02-26"
draft: true
categories:
- "Tutorial"
---


Windows 7 merupakan versi Windows yang bisa dibilang paling berhasil. Bagaimana tidak, versi yang satu ini diadopsi oleh sangat banyak pengguna dalam waktu yang sangat singkat, memiliki kompatibilitas dengan banyak aplikasi, serta dibalut dengan tampilan yang sangat cantik. Itulah mengapa Windows 7 terasa *nostalgic* (mungkin XP juga).

Sayangnya, Windows 7 sudah tidak di-support sejak tahun 2015. Itu berarti Microsoft telah berhenti merilis *security update*. Hampir semua *software* yang dirilis 5 tahunan terakhir sudah tidak mendukung Windows 7 lagi. Lantas bukan berarti Windows 7 sudah tidak bisa digunakan lagi.

Di tulisan saya kali ini, kita akan mencoba pengalaman menggunakan Windows 7 di tahun 2025. Mulai dari instalasi, konfigurasi *driver*, serta penggunaan aplikasi-aplikasi yang biasa dibutuhkan sehari-hari.

## Konfigurasi hardware yang digunakan

Awalnya saya berniat menggunakan PC utama saya sebagai percobaan. Sayangnya PC dengan spesifikasi Intel i7-13700H, RAM 32GB, dan NVIDIA RTX 3060 ini tidak kompatibel dengan Windows 7 dengan alasan motherboard saya hanya mendukung UEFI tanpa BIOS/CSM. Sehingga pilihan jatuh pada PC kedua yang paling modern yang saya punya.

Kombo ASRock H110M-DSG dan Intel Core i3-7100 keluar di tahun yang sama atau bahkan 2 tahun setelah Windows 7 diberhentikan. Kabar baiknya, produsen masih resmi mendukung Windows 7. Driver untuk versi Windows yang satu ini masih bisa didapat di website resminya.

| **Hardware** | **Spesifikasi**          |
|--------------|--------------------------|
| CPU          | Intel Core i3-7100       |
| Motherboard  | ASRock H110M-DGS         |
| RAM 1        | 1 x 8 GB DDR4            |
| RAM 2        | 1 x 4 GB DDR4            |
| GPU          | NVIDIA GT 1030 2 GB GDD5 |
| SSD		   | 2 X ADATA SP610 128 GB   |

Dengan hardware yang sudah terpasang semua, yuk lanjut ke instalasi

## Instalasi yang tidak mudah, namun berhasil

Sudah saya singgung sebelumnya bahwa **[Kendala #1:]()** Windows 7 tidak sepenuhnya mendukung UEFI. Maka dari itu, konfigurasi hardware yang lebih lawas yang pada akhirnya saya gunakan.

Windows 7 termasuk versi Windows yang cukup modern. Media instalasi bisa menggunakan DVD maupun USB stick. Saya pilih USB stick sebagai media instalasi, sebagaimana orang 'waras' lainnnya di tahun 2025. Namun muncul **[Kendala #2:]()** Windows 7 belum mendukung USB 3.0 (xHCI) secara native. Pada motherboard mulai dari chipset Intel 100 & 200, juga pada AMD AM4, setiap USB port yang ada adalah jelmaan USB 3.0, meskipun tampilan portnya USB 2.0.

Untungnya, ASRock menyediakan utility dan instruksi yang mudah dimengerti untuk mengatasi kendala ini. Selengkapnya bisa dibaca [di sini](https://www.asrock.com/microsite/Win7Install/index.html). Utility tersebut akan meng-inject driver USB 3.0 ke Windows 7 ISO agar instalasi berjalan dengan mulus.

Lanjut...

