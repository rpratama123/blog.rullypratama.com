---
title: "Apakah Lumix GX7 ISO Invariant?"
date: "2025-06-06"
categories:
- "Fotografi"
---


{{< img src="panasonic_lumix_gx7.jpg" width="800" alt="Panasonic Lumix GX7 camera being held on hand" caption="Kamera Panasonic Lumix GX7 kesayangan milik saya.">}}

Sepanjang tahun 2012 hingga 2015-an, adalah awal mula saya menggeluti fotografi. Gear yang saya gunakan adalah Canon EOS 20D. Sejak saat itu preferensi terhadap brand kamera selalu condong ke Canon. 

Di periode waktu yang sama pula pembahasan mengenai ISO invariant pada sensor kamera mulai bermunculan di jagad internet. Saya kecewa karena pada waktu itu hasil pengujian menunjukkan bahwa kamera dengan sensor buatan Sony (seperti Nikon dan Sony itu sendiri) memiliki kemampuan ISO invariant — ditandai dengan *shadow recovery* yang sangat bagus — sementara Canon dengan sensor *in-house*-nya tidak.

Pembelaan para Canon user pada waktu itu adalah bahwa Canon banyak digunakan untuk keperluan *portrait* sehingga *color science* dan *skin tone* lebih utama ketimbang *dynamic range*. Denial *sih* kalau dipikir-pikir, tapi apa boleh buat, namanya juga *fansboy*.

Loncat ke tahun 2025, pada akhirnya saya memutuskan *hijrah* dari Canon EOD 50D ke Panasonic Lumix GX7, walaupun lawas namun ini kamera impian saya sejak dulu. Karena pada kamera ini [Panasonic menyematkan sensor buatan mereka sendiri](https://www.imaging-resource.com/PRODS/panasonic-gx7/panasonic-gx7DAT.HTM), saya jadi penasaran apakah sensor kamera ini ISO invariant seperti buatan Sony, ataukah tidak seperti sensor dari Canon?

Untuk menjawab pertanyaan ini, saya membuat experiment saya sendiri.

> **TL;DR:** Kamera ini memiliki sensor dengan ISO invariant.
>
> Bisa diasumsikan semua kamera yang menggunakan sensor dari Panasonic memiliki perilaku yang sama, meski ini masih harus dibuktikan dengan pengujian.

## Apa beda kamera dengan ISO variant dan invariant?

Sebelum masuk ke pengujian, ada baiknya kita tilik sekilas mengenai ISO dan perbedaan antara keduanya.

ISO pada film mengacu pada tingkat sensitifitas material terhadap cahaya. Semakin tinggi nilai ISO, maka semakin sensitif pula film tersebut untuk menangkap cahaya. Namun ISO tinggi memiliki kekurangan yaitu *gainy*. Grain berasal dari partikel sensitif cahaya. Semakin besar, maka semakin sensitif, namun semakin terlihat *grainy* pula.

Sementara pada sensor digital, ISO mengacu pada tingkat amplifikasi sinyal cahaya yang ditangkap oleh sensor, yang nantinya disimpan sebagai file digital. Sama seperti pada film, ISO tinggi pada sensor digital juga memiliki kekurangan. Tingkat aplifikasi yang tinggi tidak hanya menguatkan sinyal cahaya dari gambar yang kita inginkan saja, namun juga dengan noise.

Nah berikut ini jalur yang ditempuh oleh cahaya hingga menjadi file digital:

| Tahapan                | ISO Variant                                    | ISO Invariant                                  |
|----------------------------|----------------------------------------------------|----------------------------------------------------|
| Sensor                     | Cahaya ditangkap dan menghasilkan tegangan listrik | Cahaya ditangkap dan menghasilkan tegangan listrik |
| Amplifikasi Analog          | **Besarannya sesuai dengan ISO yang dipakai**      | Tidak terpengaruh dengan ISO yang dipilih          |
| Konversi Analog ke Digital | Tegangan listrik dikonversi menjadi data           | Tegangan listrik dikonversi menjadi data           |
| Amplifikasi Digital        | Minimal                                            | **Besarannya sesuai dengan ISO yang dipakai**      |
| Output                     | Berupa file digital                                | Berupa file digital                                |

Dari perbandingan tahapan di atas, perbedaan menonjol dari keduanya adalah pada sensor dengan ISO variant, amplifikasi dilakukan ketika pada tahap analog (tegangan listrik). Maka dari itu ketika sudah dikonversi menjadi data digital, *shadow recovery* yang dilakukan akan menghasilkan gambar yang sangat *noisy*.

Sedangkan pada sensor ISO invariant, amplifikasi terjadi pada tahap digital, sehingga sama saja ketika aplifikasi tersebut dilakukan *in-camera* ataupun pada tahap *post-processing* menggunakan Adobe Lightroom misalnya, karena toh yang diproses sama-sama data digital.

## Metodologi pengujian

Dua gambar akan diambil dalam format RAW, satu dengan eksposure yang sesuai, menggunakan ISO yang tinggi yaitu 3200. Sedangkan satu gambar yang lain akan diambil dengan base ISO, dalam hal ini 200. Gambar yang diambil dengan base ISO akan underexposed, sehingga perlu dinaikkan tingkat eksposure-nya menggunakan *software*, lalu akan kita amati tingkat noise pada keduanya.

Dari hasil tersebut, apabila pada akhirnya kedua gambar memiliki tingkat noise yang identik — foto yang satu tidak lebih *noisy* daripada yang lain — maka bisa disimpulkan bahwa sensor pada kamera ini ISO Invariant.

{{< img src="side-by-side.png" width="800" alt="Side-by-side result with different exposure setting" caption="Perbandingan antara gambar pengujian dan gambar referensi beserta pengaturan eksposurenya." >}}

## Hasil pengujian

Setelah gambar pengujian diterangkan sekitar + 4.20 EV menggunakan Adobe Lightroom, ternyata struktur noise tetap sama dengan gambar referensi. Secara subjektif gambar pengujian terlihat sedikit lebih *noisy*, namun tidak signifikan.

Dari pengamatan tersebut, bisa disimpulkan bahwa sensor pada kamera Panasonic Lumix GX7 adalah ISO invariant.

{{< img src="side-by-side-2.png" width="800" alt="side-by-side result after the first image being adjusted to match the exposure of second image" caption="Hasil gambar pengujian setelah diterangkan hingga menyamai tingkat kecerahan gambar referensi. Bisa dilihat bahwa struktur grain hampir tanpa beda, menandakan bahwa Lumix GX7 adalah ISO invariant." >}}

Setelah mengetahui bahwa kamera ini ISO invariant, tentunya pengguna tidak perlu lagi takut jepretan yang diambil tidak *perfect* secara exposure, selagi menggunakan format RAW. Exposure masih bisa di-*adjust* secara *post-processing* menggunakan *software*.

Stay curious! ✨