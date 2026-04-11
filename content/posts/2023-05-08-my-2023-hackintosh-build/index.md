---
title: "Intel Core i5-12500 Hackintosh dengan Gigabyte B660M DS3H DDR4"
date: "2023-05-08"
description: "Saya sukses membuat Hackintosh di platform Intel 12th Gen, alias Alder Lake. Hampir semuanya berfungsi dengan baik."
categories:
- "Tutorial"
keywords:
- "hackintosh"
- "macos"
- "monterey"
- "intel 12th gen"
---

{{< img src="hackintosh-intel-core-i5-12500.webp" width="800" alt="Hackintosh dengan Intel Core i5-12500" caption="Hackintosh dengan Intel Core i5-12500." >}}

Karena bosan dengan rutinitas yang itu-itu saja, dan karena saya sudah jarang bermain game juga, saya akhirnya menjadikan *daily driver* PC saya menjadi Hackintosh PC. Prosesor yang saya gunakan adalah Intel Core i5-12500, dipasangkan dengan motherboard Gigabyte B660M DS3H DDR4.

Dikarenakan Intel 10th Gen adalah generasi terakhir yang iGPU-nya bisa bekerja di macOS, maka saya mau tidak mau harus memasang *discrete* GPU. Untuk sementara saya menggunakan AMD Radeon HD 7750, dan berencana untuk upgrade ke RX Vega 56 atau RX 6600. GPU yang saya gunakan awalnya terlalu 'tua' untuk dipasangkan dengan motherboard yang saya punya. [Namun dengan tool ini]({{< ref "/posts/2023-04-29-gopupd-tool/index.md" >}}), hal tersebut sudah tidak jadi masalah.

## Hardware Yang Digunakan

|   Kategori   |   Item                                                                  |
|--------------|-------------------------------------------------------------------------|
| Processor    | Intel 12th Gen Core i5-12500                                            |
| Motherboard  | Gigabyte B660M DS3H DDR4                                                |
| GPU          | AMD HD 7750 2GB                                                         |
| RAM 1        | 2 X 8GB Kingston Fury Beast 3200MHz DDR4                                |
| RAM 2        | 2 X 8GB Kllisre 2400MHz DDR4                                            |
| Boot Drive   | Kingston NV2 500GB NVME Gen4                                            |
| Audio        | Realtek ALC897 (ALC Layout ID 12)                                       |
| Ethernet     | Realtek RTL 8125 2.5GbE Controller                                      |
| Bios Version | F22                                                                     |

## Apa Saja Yang Bekerja

|   Fitur                           |   Status      |
|-----------------------------------|---------------|
| CPU Power Management              | 🟢 Working     |
| Sleep / Wake                      | 🟡 Partial     |
| GPU Acceleration (OpenCL & Metal) | 🟢 Working     |
| Ethernet                          | 🟢 Working     |
| Audio                             | 🟢 Working     |
| Headset and Mic                   | 🟢 Working     |
| Ethernet                          | 🟢 Working     |
| iMessage/Facetime and App Store   | 🟢 Working     |
| AirDrop/Handoff                   | 🔴 Not Working |

## Pengaturan BIOS

> Pastikan untuk mengembalikan pengaturan BIOS ke pengaturan awal terlebih dahulu.

### Tweaker
* Advanced CPU Settings
  - Hyper-Threading Technology → **Enabled**

### Settings
* Platform Power
  - Platform Power Management → **Disabled**
  - Power Loading → **Disabled**
* IO Ports
  - Initial Display Output → **PCIe 1 Slot**
  - Internal Graphic → **Disabled**
  - Above 4G Decoding → **Enabled**
  - Above 4GB MMIO BIOS assigment → **Enabled**
  - Re-Size BAR Support → **Disabled**
  - IOAPIC 24-119 Entries → **Enabled**
  - Super IO Configuration
    + Serial Port → **Disabled**
    + Parallel Port → **Disabled**
  - USB Configuration
    + Port 60/64 Emulation → **Disabled**

### Boot
* Fast Boot → **Disabled**
* Windows 10 Features → **Other OS**
* CSM Support → **Disabled**
* Secure Boot → **Disabled**

## USB Mapping

Sejak OS X 10.11 El Capitan, Apple menerapkan batasan bahwa sistem operasi hanya dapat menggunakan 15 port USB saja, dan ini berlaku hingga versi macOS terbaru. Dulu hal ini bisa diatasi dengan kext `USBInjectAll`, namun sayangnya sudah tidak bisa digunakan pada beberapa versi terakhir macOS.

Solusinya adalah kita membuat mapping port USB mana-mana saja yang akan digunakan dan menyimpannya sebagai kext. Menggunakan [USBToolBox](https://github.com/USBToolBox/tool), proses mapping ini bisa dilakukan melalui Windows maupun Linux.

## Hasil Pengujian Menggunakan Geekbench 6

{{< img src="geekbench-6-score.png" width="800" alt="Geekbench 6 Score Comparison" caption="Geekbench 6 Score Comparison." >}}

Menggunakan pengujian Geekbench 6, bisa dilihat bahwa performa CPU Hackintosh yang saya gunakan kurang lebih setara dengan perangkat Apple yang menggunakan chip M1. Performa single core pada prosesor x86 akan terlihat rendah, [penjelasannya ada di sini](https://wccftech.com/why-apple-m1-single-core-comparisons-are-fundamentally-flawed-with-benchmarks/).

Untuk performa GPU compute, Hackintosh saya terpaut jauh lebih rendah daripada perangkat dengan chip M1. Namun ingat bahwa yang saya gunakan adalah GPU keluaran tahun 2012! Bila kita masukkan GPU AMD RX 6600 XT ke dalam komparasi, maka chip M1 akan dengan mudah tertinggal di belakang.

Namun perlu diingat bahwa meskipun Hackintosh memiliki potensi performa mentah yang lebih besar dibanding perangkat dari Apple, namun perangkat asli Apple akan lebih efisien dan lebih irit daya, berkat adanya *accelerator* khusus seperti T2 chip, neural engine, media engine, dsb.

## Contoh EFI Folder

{{< img src="EFI-OC-File-List.png" width="800" alt="OpenCore EFI File List" caption="OpenCore EFI File List." >}}

Menggunakan folder EFI milik orang lain biasanya tidak direkomendasikan meskipun keduanya memiliki konfigurasi hardware yang identik. Namun mencontoh folder EFI dari sumber yang mirip akan mempermudah proses instalasi Hackintosh. Beberapa file dapat langsung dicopas begitu saja (misal driver, SSDT, kext), namun pengaturan seperti `config.plist` mau tidak mau harus diatur sesuai dengan koonfigurasi *hardware* dan kebutuhan masing-masing.

Berikut ini beberapa tautan yang berguna:
- [OpenCore EFI folder untuk Gigabyte B660M DS3H DD4](/assets/downloads/hackintosh/Gigabyte-B660M-DS3H-DDR4-OC-EFI.zip)
- [Panduan Instalasi Hackintosh Dortania](https://dortania.github.io/OpenCore-Install-Guide/)
- [OpenCore](https://github.com/acidanthera/OpenCorePkg)
- [ProperTree (untuk menyunting file `config.plist`)](https://github.com/corpnewt/ProperTree)

> **Update 2023/05/13:**
>
> Saya menemukan tool [OpenCore Auxiliary Tool](https://github.com/ic005k/OCAuxiliaryTools) yang memiliki fungsi yang sama dengan ProperTree (yaitu menyunting file `config.plist`) namun dengan GUI yang sangat mudah digunakan. Selain itu tool ini juga bisa digunakan di Windows, Linux, dan macOS.


Selamat mencoba! ✨

