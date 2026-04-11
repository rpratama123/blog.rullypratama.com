---
title: "Install Windows 11 di PC dan Laptop Tanpa TPM dan Secure Boot"
date: "2021-10-24"
description: "Penasaran sih sama Windows 11, tapi kok PC harus support TPM dan Secure Boot. Begini cara bypass-nya..."
categories:
- "Tutorial"
- "Random"
keywords:
- "windows 11"
- "install windows 11"
- "windows 11 tanpa tpm"
- "windows 11 tanpa secure boot"
---

{{< img src="win-11-cover.png" width="800" alt="Ilustrasi Windows 11" caption="Ilustrasi Windows 11." >}}

Banyak orang ingin mencoba menggunakan Windows 11 yang baru saja dirilis di bulan Oktober tahun ini. Namun sayangnya banyak yang harus kecewa karena Microsoft mengharuskan Windows 11 di-install di perangkat yang memiliki TPM dan Secure Boot. Saya akan bagikan dua cara untuk fresh install Windows 11 tanpa TPM dan Secure Boot.


Di sini saya asumsikan pembaca sudah memiliki pengalaman untuk instalasi Windows di laptop atau PC.

Bagi yang sering install Windows maupun sistem operasi di perangkat PC, pasti familiar dengan *tool* yang satu ini. Nah, sesaat setelah Windows 11 dirilis, Rufus mendukung pembuatan USB installer Windows 11 yang dapat digunakan di perangkat yang tidak memiliki TPM maupun Secure Boot.

Berikut ini yang dibutuhkan:

* Windows 11 ISO file yang dapat diunduh dari [situs resminya](https://www.microsoft.com/en-us/software-download/windows11)
* Rufus terbaru yang dapat diunduh [di sini](https://rufus.ie/en/)
* USB flash disk dengan kapasitas minimal 8 GB

{{< img src="win-11-rufus.png" width="800" alt="Rufus Windows 11" caption="Rufus Windows 11." >}}

Berikut ini langkah-langkahnya:

1. Pastikan USB flask disk terpasang di PC.
2. Buka Rufus, pilih flash disk yang akan digunakan, lalu pilih file ISO Windows 11.
3. Lalu di bagian **Image Option** pilih `Extended Windows 11 Installation (no TPM/no Secure Boot/8GB- RAM)`.
4. Klik **Start** dan tunggu hingga proses selesai.
5. Install Windows 11 di perangkat PC atau laptop seperti biasanya.

