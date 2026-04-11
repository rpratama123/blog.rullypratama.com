---
title: "GPU Bekas Mining Tanpa Display Output, Emang Bisa Buat Nge-Game?"
date: "2023-06-09"
description: "Jadikan Nvidia P106-100, GPU bekas mining, sebagai GPU gaming murah meriah"
featured: true
categories:
- "Tutorial"
- "Random"
image: "/2023/06/gpu-bekas-mining-tanpa-display-output-emang-bisa-buat-nge-game/NVIDIA-P106-100-cover.jpg"
keywords:
- "gpu"
- "nvidia"
- "mining gpu"
- "nvidia P106"
- "nvidia P106-100"
---

{{< img src="NVIDIA-P106-100.webp" width="800" alt="GPU EVGA NVIDIA P106-100" caption="GPU EVGA NVIDIA P106-100, GPU khusus mining tanpa port untuk output display." >}}

Saat *mining* sedang nge-trend, NVIDIA bersama beberapa partner *hardware* merilis GPU yang dikhususkan untuk mining. Berbeda dengan GPU pada umumnya, GPU ini tidak memiliki konektor untuk *output display*. *Hype* mining telah berlalu, kini menyisakan tumpukan GPU khusus mining bekas yang tak jelas fungsinya. Saya mendapatkan NVIDIA P106-100 dari salah satu *marketplace* yang dibanderol hanya sebesar Rp400.000-an saja, padahal secara spesifikasi dia mirip dengan Geforce GTX 1060 6GB yang jelas tidak bisa didapat dengan harga serendah itu meskipun dalam keadaan bekas.

Untungnya, ada trick yang bisa digunakan untuk mengembalikan fungsionalitas GPU mining menjadi GPU gaming.

> **Update 2023/06**: Beberapa orang gagal melakukan instalasi driver yang telah di-*patch*. Alternatifnya bisa langsung unduh driver berikut dan install sesuai dengan instruksi yang menyertai. [Driver bisa diunduh di sini](https://1drv.ms/u/s!AnvxRvPnXov8gcBDtwlIQuuhKSlqpw?e=wbQ0uf).

> **Update 2023/07:** Langkah-langkah *patching* driver diperbarui sesuai dengan instruksi dari patch yang dibuat oleh [dartraiden](https://github.com/dartraiden/NVIDIA-patcher).

> **Update 2024/01:** Langkah *patching* dan instalasi driver kini semakin mudah. Silakan lihat tata cara di bawah.

## Penampakan Produk

Unit P106-100 yang saya dapatkan dibuat oleh pabrikan EVGA. Cukup lega rasanya karena menurut saya EVGA termasuk salah satu produsen yang memproduksi GPU NVIDIA dengan kualitas yang baik. Saya dapatkan produk ini dengan harga Rp480.000 saja. Sebenarnya *seller* juga menjual GPU serupa namun dengan seri P104-100 yang mana setara dengan GTX 1070, hanya selisih beberapa ratus ribu saja. Tergiur pada awalnya, namun syukurnya saya mendapatkan info bahwa seri P104-100 hanya memiliki koneksi PCI-E Gen 1.1 x4 saja!

{{< img src="NVIDIA-P106-100-detail.webp" width="800" alt="Kondisi GPU NVIDIA P106-100 bekas mining yang saya beli" caption="Kondisi GPU NVIDIA P106-100 bekas mining yang saya beli." >}}

Unit P106-100 yang saya dapatkan cukup mengenaskan: semua klip plastik penahan *cover fan* patah, sebagian sekrup berkarat, dan yang sudah pasti PCB-nya dilapisi debu hitam khas GPU bekas mining. Agak susah dibersikan memang, khususnya pada bagian *heatsink*. Namun dengan air dan sabun, semua debu hilang seketika. Selain itu *thermal paste* yang tersisa sudah kering dan harus segera diganti.

Semua minus ini sebenarnya sudah disebukan oleh ulasan orang-orang yang ada pada lapak barang ini, namun dengan harga yang cukup rendah, rasanya *money worth spend* lah.

## Spesifikasi

Spesifikasi P106-100 sangat mirip dengan [EVGA GeForce GTX 1060 SC GAMING](https://www.evga.com/products/specs/gpu.aspx?pn=5fa28d37-0fb1-42be-8b9b-04223cb59d85), dengan penegcualian:

* Tanpa *display output*, diperlukan CPU + Mobo dengan iGPU atau APU
* Bus PCI-E yang digunakan versi 1.1 x16 (PCI-E 3.0 x16 pada versi gaming)
* *Video acceleration* tidak terdeteksi dengan driver biasa

## Pra-Syarat

* CPU dan motherboard dengan support Intel iGPU atau AMD APU. Disarankan Intel Gen 4th atau yang lebih baru atau AMD pltform AM4 seri G
* Motherboard harus memiliki slot PCI-E x16. Versi PCI-E tidak penting, karena GPU hanya support veri 1.1, dan PCI-E 1.1 x16 memiliki *bandwith* yang setara dengan PCI-E 3.0 x4. Apabila slot yang digunakan hanya x8 atay x4, maka performa akan berkurang secara drastis.
* Fitur iGPU / APU harus diaktifkan melalui BIOS / UEFI
* Sistem operasi menggunakan Windows 10 atau yang lebih baru.

## Instalasi

Windows 10 sejak versi 1803 menerapkan fungsionalitas yang mirip dengan NVIDIA Optimus yang biasa digunakan di laptop. Proses render akan diambil-alih oleh *discrete GPU* sedangkan *integrated GPU* bertugas untuk melakukan render 2D dan menampilkan *output* ke layar. dGPU dan iGPU saling berkomunikasi melalui bus PCI-E. Untuk itu pastikan driver iGPU terinstall dengan baik, sesuai dengan CPU yang digunakan.

> Pastikan untuk mematikan koneksi internet sebelum memulai langkah di bawah

### Matikan instalasi driver melalui Windows Update

Langkah ini penting karena apabila tidak dimatikan maka *patched* NVIDIA driver yang kita gunakan suatu saat bisa jadi ditimpah oleh Windows Update. Simpan script berikut sebagai berkas `.reg`, lalu jalankan.

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ExcludeWUDriversInQualityUpdate"=dword:00000001
```

### Unduh dan patch NVIDIA Driver

Unduh dan ekstrak [NVIDIA driver versi 551.23 (harus versi ini)](https://www.nvidia.com/download/driverResults.aspx/218113/) (menggunakan 7-Zip atau WinRAR). Kemudian unduh berkas [yang sudah di-*patch*](https://github.com/dartraiden/NVIDIA-patcher/releases/download/551.23/551.23-desktop-win10-win11-64bit-international-dch-whql.zip) lalu ekstrak semua berkas dan folder dalam satu folder di mana berkas `setup.exe` berada.

Sebelum melakukan instalasi driver, pastikan di PC belum pernah ada driver NVIDIA lain yang terpasang. Apabila PC masih bersih, maka bisa lanjut ke langkah selanjutnya. Jika tidak, kalian perlu menghapus sepenuhnya driver NVIDIA yang terpasang menggunakan *tool* [DDU (Display Driver Uninstaller)](https://www.guru3d.com/files-details/display-driver-uninstaller-download.html).

Instalasi driver bisa dilakukan dengan cara klik kanan berkas `install.bat`, lalu pilih *Run as administrator*. Jendela instalasi akan muncul lalu ikuti proses hingga selesai.

### Sunting registry untuk aktivasi mode *hybrid*

Buka `regedit.exe` lalu pergi ke alamat `HKEY_LOCAL_MACHINE \ SYSTEM \ CurrentControlSet \ Control \ Class \ {4d36e968-e325-11ce-bfc1-08002be10318}`. Di sana akan ada *subkeys* dengan nama `0000, 0001, dst.`. Buka satu per satu dan cari yang berkaitan dengan GPU NVIDIA yang baru saja dipasang. Di *subkey* tersebut set key `EnableMsHybrid` ke nilai `1` (apabila key tidak ada, maka bisa dibuat dengan tipe DWORD type 32-bit).

Nyalakan ulang PC lalu koneksikan kembali ke internet.

{{< img src="NVIDIA-P106-100-GPUZ.webp" width="800" alt="NVIDIA P106-100 terinstal dengan driver GeForce GTX 1060 6GB" caption="NVIDIA P106-100 terinstal dengan driver GeForce GTX 1060 6GB." >}}

## Performa

Unit GPU yang saya dapatkan berjalan dengan dingin dan senyap. Pemakaian daya saat *idle* hanya sebesar 5 watt saja. Temperatur saat *idle* rata-rata ada di 33 °C, sedangkan ketika *under load* temperatur stabil di 70 °C dan tidak pernah lebih. Saat dipakai untuk gaming suara fan hampir tidak terdengar.

Sayangnya saya tidak memiliki GPU Geforce GTX 1060 6GB untuk bisa membandingkan secara langsung dengan GPU P106-100 ini. Namun kabar baiknya, [Linus Tech Tips](https://www.youtube.com/watch?v=TY4s35uULg4) sudah pernah melakukan komparasi performa menggunakan perangkat sebagai berikut:

- OS: Windows 10
- Game: Shadow of the Tomb Raider
- CPU: Intel Core i9-9900K
- RAM: 16GB
- GPU 1: NVIDIA Geforce GTX 1060 6GB
- GPU 2: NVIDIA P106-100

Hasilnya sangat menjanjikan, P106-100 mendapatkan *frame rate* rata-rata di angka 64 FPS, sedangkan GTX 1060 di angka 68 FPS. Dengan gap yang hanya 4 FPS saja, tentu hasil ini sangat bagus, mengingat harga P106-100 yang sangat mudah di pasaran sana.

Namun perlu diperhatikan bahwa hasil yang didapat akan berbeda-beda sesuai dengan game yang dijalankan, serta kombinasi CPU & motherboard yang digunakan. Angka di atas hanyalah patokan.

## Kesimpulan

Dengan harga yang murah, pantaskah NVIDIA P106-100 ini dibeli? Jawabannya tergantung.

Apabila kalian sudah memiliki combo CPU dan motherboard yang sudah mendukung iGPU / APU dan ingin *upgrade* GPU namun dengan *budget* yang pas-pasan, maka bolehlah GPU ini dicoba. Dengan GPU seharga 400 ribu-an saja sudah bisa merasakan performa GPU dengan harga 1 s.d. 2 juta-an.

