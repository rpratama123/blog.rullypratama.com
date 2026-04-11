---
title: "Tool: GOPupd"
date: "2023-04-29"
description: "Flash firmware video card lama yang tidak support UEFI menggunakan tool ini"
categories:
- "Tutorial"
- "Tool"
keywords:
- "gopupd"
- "amd"
- "nvidia"
- "gpu support uefi"
- "gpu uefi mode"
---

{{< img src="gopupd-before-after.png" width="800" alt="Tampilan GPU-Z sebelum dan sesudah" caption="Tampilan GPU-Z sebelum dan sesudah tweak menggunakan tool ini." >}}

Beberapa waktu yang lalu, saya membeli GPU AMD Radeon HD 7750 dari Facebook seharga 350 ribu rupiah. Saya sengaja membeli GPU lawas ini untuk keperluan Hackintosh. GPU dari AMD terkenal memiliki kompatibilitas yang sangat baik dengan macOS dibanding Nvidia. Saat saya pasangkan GPU ini ke platform Intel 12th Gen, tampilan hanya muncul di layar monitor ketika proses booting sudah sampai di halaman login Windows. Awalnya saya pikir GPU yang saya beli memiliki *defect*, namun ternyata saya salah.

Setelah saya telusuri di berbagai forum di internet, penyebab mengapa muncul layar hitam di saat proses booting adalah GPU yang saya pasang terlalu tua umurnya untuk mendukung booting dengan mode UEFI only (non-CMS). GPU lawas biasanya tidak memiliki firmware UEFI di dalam *Video BIOS*-nya. Apakah sebuah GPU memiliki firmware UEFI atau tidak, ini bisa dilihat dengan tool GPU-Z.

{{< img src="gopupd-no-uefi.png" width="800" alt="GPU tanpa firmware UEFI" caption="GPU tanpa firmware UEFI, terlihat di GPU-Z checkbox UEFI tidak tercentang." >}}

Tool GOPupd memiliki fungsi untuk menyisipkan informasi GOP ke *Video BIOS*, sehingga GPU lawas menjadi kompatibel dengan UEFI. Tak hanya GPU dari AMD saja, tool ini juga bisa digunakan di GPU Nvidia. Namun tidak semua GPU lawas bisa 'diakali'. Berikut ini daftar GPU yang kompatibel:
- **AMD**: Seri HD 6xxx, 7xxx, atau yang lebih baru.
- **Nvidia**: Seri dengan chip GT21x, GF10x, GF119, GK1xx/GK2xx, GM1xx, GM2xx, atau yang lebih baru.

Langkah-langkah yang harus dilakukan adalah:
1. Ekstrak *Video BIOS* (VBIOS) asli dari GPU yang kamu gunakan (paling mudah menggunakan GPU-Z, lalu klik tombol share di bawah logo manufaktur).
2. Jalankan tool GOPupd lalu drop file VBIOS asli yang kita dapatkan dari langkah nomor 1.
3. Flash ulang VBIOS ke GPU (Untuk AMD menggunakan ATIFlash, sedangkan Nvidia menggunakan NVFlash).

Perlu diingat bahwa risiko kerusakan yang mungkin terjadi, mohon ditanggung sendiri ya ✌️

Berikut tautan yang mungkin berguna (termasuk tautan untuk mengunduh):
- [Tool: GOPupd](https://firmwaresecurity.com/2016/02/23/tool-gopupd/#:~:text=GOPupd%20is%20a%20tool%20that%20updates%20a%20GOP,older%20GPU%20compatible%20to%20pure%20UEFI%20%28non-CSM%29%20mode.)
- [AMD and Nvidia GOP update](https://web.archive.org/web/20230321142121/https://winraid.level1techs.com/t/amd-and-nvidia-gop-update-no-requests-diy/30917)
- [GOPupd download](/assets/downloads/gopupd/GOPUpd_v1.9.6.5.rar)

