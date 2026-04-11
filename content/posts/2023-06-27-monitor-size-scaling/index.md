---
title: "Selain Resolusi, Perhatikan Juga Ukuran Diagonal Saat Membeli Monitor"
date: "2023-06-27"
description: "Perhatikan beberapa hal ini agar tidak salah pilih ketika akan membeli monitor"
featured: true
math: true
categories:
- "Tutorial"
- "Random"
keywords:
- "tips memilih monitor"
- "tips membeli monitor"
- "resolusi monitor"
- "ukuran monitor"
- "display scaling"
---


Beberapa waktu yang lalu, saya membeli monitor Lenovo ThinkVision P24q-10 – monitor beresolusi 1440p dengan ukuran diagonal 24-inch – untuk menggantikan monitor 1080p saya yang rusak. Berbagai macam hal sudah saya riset terlebih dahulu, mulai dari tipe, resolusi dan dimensi panel, hingga review yang bertebaran di jagad internet. Namun ketika monitor yang saya pesan tiba, saya kecewa karena *display space* yang saya dapat tidak seperti seharusnya monitor 1440p. Mengapa bisa demikian?

Pilihan saya jatuhkan ke monitor 1440p karena saya ingin upgrade dari 1080p yang saya gunakan sebelumnya. Dengan resolusi yang lebih tinggi, saya berharap mendapatkan *display space* yang lebih luas daripada 1080p. Ukuran diagonal sebesar 24-inch saya pilih karena pada saat itu saya pikir saya akan menyukai tampilan dengan *pixels per inch* (PPI) yang tinggi, dengan harapan gambar yang dihasilkan akan tajam.

{{< img src="Windows-Display-Setting-Scaling.webp" width="800" alt="Windows Display Setting - Scale" caption="Windows Display Setting - Scale." >}}

Harapan saya pupus seketika ketika Windows secara otomatis memilih **Scale** sebesar 125% untuk monitor saya. Mari kita cari terlebih dahulu PPI monitor 1440p 24-inch dengan rumus berikut:

$$PPI = \frac{diagonal~in~pixels}{diagonal~in~inches}$$

$$PPI = \frac{\sqrt{width^{2}+height^{2}}}{diagonal~in~inches}$$

$$PPI = \frac{\sqrt{2560^{2}+1440^{2}}}{24}$$

$$PPI = \frac{\sqrt{8627200}}{24}$$

$$PPI = \frac{2937.2}{24}$$

$$PPI = 122.4$$

Dengan *scaling* sebesar 125%, maka PPI yang dirasakan akan menjadi sebesar:

$$Perceived~PPI = PPI + \left ( PPI \times \left ( 1-1.25 \right ) \right )$$

$$Perceived~PPI = 122.4 + \left ( 122.4 \times \left ( 1-1.25 \right ) \right )$$

$$Perceived~PPI = 91.8$$

PPI sebesar 91.8 adalah PPI untuk monitor resolusi 1080p dengan diagonal 24-inch. Ya, Windows membuat monitor 1440p saya menjadi serasa seperti monitor 1080p! Parahnya dengan adanya *scaling* ini, toolbar icon, gambar yang tampil di perambah (*browser*), dan bahkan beberapa teks terlihat *blur*. Ini terjadi karena *scaling* yang dilakukan bukanlah *integer scaling*.

## Kenapa Tidak Dikembalikan ke *Scaling* 100% Saja?

Berdasarkan pengamatan saya, pixels per inch (PPI) yang ideal untuk Windows adalah sebesar 96 untuk low-DPI dan 192 untuk high-DPI, sedangkan untuk macOS adalah sebesar 110 untuk non retina dan 220 untuk retina. Tidak perlu selalu tepat di angka tersebut, monitor dengan PPI yang mendekati nilai-nilai di atas masih nyaman digunakan. Namun ingat, **semakin kecil nilai PPI, semakin besar tampilan yang muncul di layar, dan sebaliknya, semakin besar PPI maka semakin kecil tampilan yang muncul di layar**.

Kembali lagi ke monitor 1440p 24-inch saya yang memiliki PPI sebesar 122.4, Windows merasa tampilan yang tampil di layar akan sangat kecil apabila menggunakan *scaling* 100%, maka secara otomatis mengubahnya menjadi 125% atau PPI sebesar 91.8 yang mana lebih nyaman di mata. Berikut ini perbandingan *scaling* 100% vs. 125%.

{{< img src="Different-Scaling-Comparison.webp" width="800" alt="Perbandingan display scaling di Windows 11" caption="Perbandingan display scaling di Windows 11." >}}

Bisa dilihat di perbandingan di atas, saya disuguhkan pada pilihan yang sama-sama tidak menyenangkan. Sehingga saya menyimpulkan bahwa kombinasi resolusi 1440p dan diagonal 24-inch adalah untuk dihindari.

## Lalu Bagaimana Cara Memilih Monitor Berdasarkan Resolusi dan Diagonalnya?

Selain kasus monitor yang saya beli, ada beberapa kombinasi resolusi dan ukuran diagonal lain yang wajib untuk dihindari. Kombinasi antara keduanya akan saya rangkum dalam PPI yang mana sudah saya jelaskan cara perhitungannya di atas. Pada bagan di bawah ini, ada tiga kategori monitor sesuai dengan PPI-nya, antara lain:
- **Low DPI Good Zone**: Tampilan bagus pada scale 100% pada Windows atau mode non-retina pada macOS. 1 pixel pada OS direpresentasikan dengan 1 pixel di panel monitor (1:1)
- **Bad Zone**: Kombinasi yang wajib untuk dihindari!
- **High DPI Good Zone**: Tampilan bagus pada scale 200% pada Windows (*integer scaling*), atau mode retina pada macOS. 1 pixel pada OS direpresentasikan oleh 4 pixels di panel monitor (2:1)

{{< img src="Monitor-Size-Chart.webp" width="800" alt="Kombinasi ukuran monitor yang harus diperhatikan" caption="Kombinasi ukuran monitor yang harus diperhatikan." >}}

## Kesimpulan

Pemilihan kombinasi resolusi & ukuran diagonal monitor sebenarnya kembali lagi ke tujuan penggunaan. Apabila digunakan untuk *gaming*, maka kombinasi manapun cocok karena kebanyakan *game* bisa meng-*handle* banyak pilihan resolusi. Scaling dan PPI menjadi kurang relevan karena *game* dibangun dari *shaders* dan *textures* yang di-*render* secara *real-time*.

Berbeda halnya apabila penggunaannya sebagai *content creation* maupun pekerjaan kantoran yang lebih sering saya geluti. PPI yang tidak sesuai bisa menyebabkan teks sangat kecil sehingga sulit dilihat, namun bisa juga menjadikan tampilan menjadi besar, memakan tempat, dan beberapa elemen menjadi *blur* dan tidak nyaman dipandang.

Sepertinya saya harus berburu monitor lagi, *nih* 😖

