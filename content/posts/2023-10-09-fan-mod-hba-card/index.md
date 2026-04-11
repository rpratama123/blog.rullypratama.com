---
title: "Fan Mod di HBA Card LSI SAS 9210-8i, Chip Jadi Lebih Adem"
date: "2023-10-09"
description: "Server grade HBA card ini kadang kelewat panas saat digunakan. Menambahkan fan bisa jadi solusinya."
categories:
- "Tutorial"
- "Random"
keywords:
- "fan mod hba card"
- "fan mod lsi sas 9210"
- "hba card lsi sas 9210 panas"
- "hba card lsi sas 9210 overheat"
- "bikin nas sendiri"
---


Baru-baru ini saya pindahkan komponen *Network Storage System* (NAS) yang awalnya di case mini ITX ke PC *build up* HP 8300 Small Form Factor (SFF). Saya cukup senang dengan migrasi ini, karena HP 8300 memiliki ruang yang lebih lega, sehingga memungkinkan saya menambah *storage drive* di kemudian hari. Selain itu air flow di PC ini juga lebih baik sehingga komponen seperti CPU dan HDD jauh lebih dingin.

Untuk mengakomodasi *drive bay* yang lebih banyak, saya tambahkan HBA Card LSI 9210-8i yang berfungsi untuk 'menggandakan' port penyimpanan. HBA card ini dibuat untuk keperluan *enterprise* yang mana server-servernya berada di ruang yang sangat dingin dengan airflow yangs sangat bagus. Sehingga HBA card ini tidak dilengkapi dengan fan, hanya heatsink pasif saja.

{{< img src="HBA-LSI-9210-8i-fan-mod.webp" width="800" alt="HBA LSI 9210-8i card, sebelum dan sesudah modifikasi fan" caption="**1** - HBA card sebelum modifikasi; **2** - setelah modifikasi, fan terkoneksi ke kabel power SATA." >}}

Saat berkerja, card ini cenderung jadi panas. Cara simpel untuk cek: pegang heatsink dengan dari, apabila terasa tidak tahan, maka kemungkinan sudah memerlukan pendinginan aktif.

Modifikasi ini mungkin juga bisa dilakukan pada HBA card seri lain. Ini bahan dan alat yang saya gunakan untuk melakukan modifikasi ini:
1. Fan kecil ukuran 4 cm 12V, dua kabel - [link Tokopedia](https://www.tokopedia.com/search?st=&q=fan%204cm&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Kabel extension SATA power female - [link Tokopedia](https://www.tokopedia.com/search?st=&q=sata%20female%20power%20extension&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. 4 set sekrup M3 X 30mm atau M3 X 40mm - [link Tokopedia](https://www.tokopedia.com/search?st=&q=sekrup%20m3%20x%2040&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Heat shrink tube, dengan ukuran sesuai dengan ukuran kabel fan - [link Tokopedia](https://www.tokopedia.com/search?st=&q=heat%20shrink%20tube&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Solder, timah, gunting dan lakban kabel

{{< img src="4cm-fan-and-sata-power-cable-extension.webp" width="800" alt="4 cm fan 12 V dan kabel SATA power extension" caption="**1** - 4 cm fan 12V; **2** - kabel SATA power extension." >}}

Untungnya lubang yang ada pada heatsink card ini ukurannya sangat cocok dengan jarak lubang pada fan 4 cm. Sehingga untuk memasang fan pun sangat mudah:
1. Lepas klik plastik penahan heatsink. Caranya pencet klik dari atas, lalu potong penahan di bagian bawah dengan gunting. Part ini tidak akan digunakan lagi, maka aman untuk dibuang.
1. Potong 2 strip lakban kabel, buat lubang sebesar batang sekrup, lalu tempel di lubang bekas klik di bagian bawah card. Fungsinya agar menjaga sekrup agar tidak menempel ke komponen card sehingga terhindar dari konsleting.
1. Posisikan fan sehingga kedua lubangnya tepat di lubang bekas klip yang sudah dilepas. Kemudian kencangkan dengan memasang 2 sekrup dan baut.
1. Solder kabel fan dengan konektor power SATA female. Pastikan kabel merah fan bertemu dengan kabel kuning, dan kabel hitam dengan hitam. Jangan sampai terbalik!

Seperti itu langkah-langkah modifikasinya. Dengan ditambahkannya fan, chip yang ada pada HBA card ini bisa lebih dingin, dan harapannya bisa lebih awet lagi.

Stay tuned! 🚀

