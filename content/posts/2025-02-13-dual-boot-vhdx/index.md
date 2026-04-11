---
title: "Dual Boot Windows dengan VHDX"
date: "2025-02-13"
categories:
- "Tutorial"
---

{{< img src="windows-dualboot.webp" width="800" alt="Windows boot menu screen" caption="Windows boot menu, menampilkan pilihan boot dari media VHDX." >}}

Bermain-main dengan instalasi dual boot di Windows memang seru. Yang tidak seru adalah ketika harus berurusan dengan partisi. Bukan hanya susah, tapi juga berisiko menyebabkan hilangnya data apabila tidak dilakukan dengan benar.

Untungnya, Windows bisa di-install di dalam file VHDX. File VHDX adalah format *virtual disk* yang bisa digunakan untuk menyimpan file, baik itu file dokumen, media, bahkan installasi Windows sekalipun. Dengan begitu, dual boot Windows bisa dilakukan tanpa harus partisi ulang HDD/SSD.

Dengan asumsi laptop atau PC sudah ter-install Windows dan ingin menambah instalasi Windows yang lain, berikut ini langkah-langkahnya.

## Langkah 1: Siapkan file `.vhdx`

1. Buka **Disk Management** (Win + X → "Disk Management").
2. Klik **Action → Create VHD**.
3. Simpan di lokasi yang diinginkan, misalnya `C:\vhdx\win11.vhdx`.
    * Pilih format **VHDX** apabila ingin meng-install Windows 8 dan yang lebih baru, pilih **VHD** untuk Windows 7.
    * Atur ukuran disk, pastikan mencukupi untuk instalasi Windows yang diinginkan.
    * Pilih **Fixed size** untuk performa yang lebih baik.
4. Klik kanan pada disk `.vhdx` yang baru saja dibuat, klik **Initialize Disk** lalu pilih **GPT** apabila menggunakan UEFI, sementara pilih **MBR** apabila menggunakan BIOS.
5. Klik kanan pada disk yang sudah diinisiasi tadi, lalu buat **New Simple Volume**. Format sebagai **NTFS**, lalu assign drive letter yang diinginkan, misalnya `V:`.

## Langkah 2: *Mount* ISO Instalasi Windows yang diinginkan

Klik kanan file ISO dari sistem operasi Windows yang akan di-install (bisa jadi versi Windows yang sama dengan yang sudah ter-install, atau beda). Lalu pilih **Mount**. Ingat-ingat drive letter yang didapat, misalnya `E:`.

## Langkah 3: Proses Instalasi

Proses instalasi dilakukan ketika Windows yang pertama sedang berjalan. Ini bisa dilakukan berkat bantuan tool `DISM`. Berikut langkah-langkahnya:

1. Buka **Command Prompt** sebagai administrator.
2. Cek edisi Windows yang ingin di-install dari file `.iso` dengan cara:
```
dism /Get-ImageInfo /ImageFile:E:\sources\install.wim
```
3. Install Windows ke file `.vhdx` yang tadi telah dibuat:
```
dism /Apply-Image /ImageFile:E:\sources\install.wim /Index:1 /ApplyDir:V:\
```
* Ganti drive `E:` dengan drive letter ISO yang telah di-mount tadi.
* Ganti drive `V:` dengan drive letter yang diberikan ke file VHDX.

## Langkah 4: Tambahkan ke Boot Entry

1. Buat boot entry yang mengarah ke file `.vhdx` menggunakan `bcdedit`:
```
bcdedit /copy {current} /d "Windows 11 VHDX"
```
* Catat GUID (misalnya `{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}` yang muncul setelah menjalankan perintah di atas.

2. Pilih device dan path yang akan ditambahkan ke boot entry:

```
bcdedit /set {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx} device vhd=[C:]\vhdx\win11.vhdx
bcdedit /set {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx} osdevice vhd=[C:]\vhdx\win11.vhdx
bcdedit /set {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx} detecthal on
```

## Langkah 5: Test Bootloader

1. Nyalakan ulang atau reboot sistem.
2. Pada tampilan boot menu, pilih **Windows 11 VHDX** (atau nama yang dipilih pada langkah 4 tadi), untuk booting ke instalasi Windows yang baru.

Selamat, sekarang sistem mu sudah memiliki 2 Windows ter-install di dalamnya. Dual boot menggunakan VHDX sangat cocok untuk:
* Yang suka bermain-main dengan versi Windows tanpa khawatir soal partisi, tapi ingin menjalankannya di bare metal
* Membedakan instalasi Windows untuk dua atau lebih keperluan, misal satu untuk personal dan yang lain untuk pekerjaan
* Bernostalgia dengan Windows versi lama, misal Windows 7 maupun Windows 8

Selamat mencoba ~ ✨