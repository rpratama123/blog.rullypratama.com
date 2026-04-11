---
title: "CPU Undervolt: Makin Adem dan Irit Daya"
date: "2023-06-24"
description: "Cara mudah dan gratis untuk membuat CPU makin adem dan irit daya yaitu dengan undervolting"
categories:
- "Tutorial"
- "Random"
image: "/2023/06/cpu-undervolt-makin-adem-dan-irit-daya/CPU-Undervolt_Cover.jpg"
keywords:
- "cpu undervolt"
- "intel"
- "amd"
- "ryzen"
- "intel 12th gen"
- "intel alder lake"
---


Apple baru-baru ini merilis CPU seri M1 dan M2 berbasis ARM yang konon katanya lebih *power efficient* daripada CPU dari Intel dan AMD. CPU x86 besutan Intel dan AMD memang dari awal didesain lebih ke arah performa ketimbang efisiensi. Tapi ada satu cara untuk membuat CPU x86 lebih adem dan irit daya, salah satunya dengan *undervolting*. Kali ini saya akan mencoba menemukan resep *undervolt* yang pas untuk CPU Intel Core i5-12500 yang saya gunakan sebagai *daily driver*.

## Yang Perlu Diperhatikan

CPU x86 dari Intel dan AMD dikenal *overvolt* sejak keluar dari pabrik. Hal ini dilakukan untuk membuat CPU mereka stabil. Karena lebih banyak daya yang disuplai ke CPU, maka semakin stabil pula kinerjanya. Selain itu potensi *undervolt* satu chip dengan chip yang lain berbeda, meskipun dari pabrikan dan seri yang sama. Jadikan eksperimen saya ini sebagai referensi ya, jangan patokan.

Mohon diperhatikan bahwa kerusakan *software* maupun *hardware* yang muncul mungkin bisa menghanguskan garansi. Saya tidak  menanggung kerusakan yang mungkin akan terjadi. Jadi berhati-hati ya.

## Metodologi

Sebelum melakukan *undervolting* pada CPU, ada baiknya untuk mencatat terlebih dahulu metrik yang ingin diukur sebelum prosedur dilakukan. Metrik yang diukur antara lain voltase Vcore maksimum, temperatur maksimum, pemakaian daya CPU package maksimum, dan skor performa awal.

Voltase Vcore maksimum bisa diambil menggunakan *tool* [CPU-Z](https://www.cpuid.com/softwares/cpu-z.html) ketika CPU sedang 100% digunakan. Temperatur dan pemakaian daya pada CPU package maksimum bisa dilihat menggunakan [Libre Hardware Monitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor). Sementara untuk bisa mengetahui skor performa awal, saya menggunakan [Cinebench R23](https://www.maxon.net/en/downloads/cinebench-r23-downloads).

### Ubah mode Vcore menjadi *adaptive* dan set *offset voltage*

*Undervolt* bisa dilakukan pada CPU Intel seri non-K dengan cara mengubah mode Vcore menjadi *adaptive with offset* dan mengeset voltase *offset* ke nilai negatif sedikit demi sedikit hingga menemukan *sweet spot*-nya. CPU Ryzen dari AMD seharusnya lebih mudah, karena semua CPU AMD Ryzen sudah *unlocked* dari pabrikan. Untuk pengaturan mana yang harus diubah silakan cek *manual* motherboard masing-masing, karena setiap produsen memiliki nama yang berbeda-beda.

Setiap motherboard dan CPU pada dasarnya menerapkan voltase *adaptive*, yaitu voltase yang diberikan ke CPU akan tinggi ketika frekuensi CPU sedang tinggi, dan sebaliknya ketika frekuensi CPU sedang rendah. Dengan mengaktifkan *adaptive with offset*, maka kita bisa menurunkan nilai Vcore maksimal dan minimal sesuai dengan *offset* negatif yang kita atur.

Voltase *offset* Vcore saya turunkan sebanyak -0.010 V (10 mV) lalu *reboot*.

### Cek metrik pengukuran, lalu turunkan kembali *offset voltage* sesuai kebutuhan

Setelah menurunkan voltase *offset* sebesar -10 mV, saya diamkan PC selama 10 menit agar temperatur CPU stabil. Setelah itu saya jalankan *benchmark* Cinebench R23 selama 10 menit, sambil mengukur temperatur dan pemakaian daya CPU package maksimal. Setelah *benchmark* selesai, saya catat metrik-metrik yang ingin saya ukur.

Ulangi untuk menurunkan voltase *offset* sebesar -10 mV hingga dirasa PC sudah tidak stabil ketika *benchmark*, atau ketika hasil skor *benchmark* terjun bebas ke bawah.

## Hasil Pengukuran

{{< img src="Undervolt-Chart.webp" width="800" alt="Hasil undervolt CPU Intel Core i5-12500" >}}

| Max Vcore | Offset Voltage | Cinebench R23 Score | Max Temp | Max Power |
|-----------|----------------|---------------------|----------|-----------|
| 1.116     | 0.000          | 11,925              | 83.00    | 89.00     |
| 1.106     | -0.010         | 11,803              | 83.00    | 87.80     |
| 1.096     | -0.020         | 11,736              | 82.00    | 86.80     |
| 1.086     | -0.030         | 11,719              | 80.00    | 86.00     |
| 1.076     | -0.040         | 11,486              | 79.00    | 83.60     |
| 1.066     | -0.050         | 10,026              | 75.00    | 79.10     |
| 1.056     | -0.060         | 8,374               | 71.00    | 73.80     |

Hal yang menarik yang saya dapatkan adalah, meskipun voltase *offset* yang saya turunkan sangat kecil, yaitu hanya sebesar -10 mV dalam sekali waktu, namun hal ini berdampak langsung pada turunnya temperatur dan pemakaian daya maksimal di CPU package saya. Meski begitu, performa CPU juga ikut turun. Hal ini dikonfirmasi dari hasil pengetesan menggunakan Cinebench R23.

*Sweet spot* yang saya dapatkan ketika voltase *offset* ada pada nilai -0.40 V (40 mV). Pada nilai tersebut, temperatur CPU saya turun sebesar 4.82% (dari 83 °C ke 79 °C), pemakaian daya CPU turun sebesar 6.07% (dari 89 W ke 83.6 W), namun penurunan performa CPU hanya sebesar 3.68% saja!

Mengatur voltase *offset* lebih kecil daripada -0.40 V menyebabkan penurunan performa CPU yang sangat drastis, yang efeknya terasa ketika PC sedang digunakan. Untuk itu di CPU yang saya gunakan, *offset* lebih rendah tidak disarankan.

## Kesimpulan

Meskipun tidak dapat menandingi efesiensi penggunaan daya CPU dengan arsitektur ARM, masih ada celah untuk CPU x86 dari Intel dan AMD untuk bisa lebih adem dan irit lagi.

Dengan asumsi apabila PC digunakan untuk kerja dan menyala 9 jam sehari, maka potensi pengiritan biaya listrik dalam sebulan kurang lebih sebesar Rp2.675, sedangkan dalam setahun bisa irit sebesar Rp32.100. Memang bukan jumlah yang besar *sih*, tapi pengiritan yang bisa didapat dari hal yang gratis, tetap harus disyukuri, *kan*?

