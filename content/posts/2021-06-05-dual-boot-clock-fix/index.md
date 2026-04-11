---
title: "Mengatasi Permasalahan Jam Pada Dual Boot Windows dan Linux"
date: "2021-06-05"
description: "Setiap berpindah dari Linux ke Windows jam jadi kacau? Begini penjelasannya..."
categories:
- "Tutorial"
- "Random"
keywords:
- "dual boot"
- "dual boot windows dan linux"
- "dual boot windows dan linux"
- "windows time"
- "windows time utc"
---

{{< img src="time.png" width="800" alt="Ilustrasi Dual Boot Ubuntu Linux dan Windows" caption="Ilustrasi Dual Boot Ubuntu Linux dan Windows." >}}

Bermain-main dengan Linux memang menyenangkan. Mencoba suatu sistem yang benar-benar baru dari keseharian merupakan keasyikan tersendiri. Namun permasalahan sering muncul, terlebih apabila Linux disandingkan dengan Windows di satu perangkat komputer melalui *dual boot*. Salah satunya permasalahan mengenai jam.

Permasalahan yang sepele memang, namun sangat menjengkelkan apabila diabaikan. Permasalahan ini pertama kali saya amati saat menggunakan Ubuntu Linux sebagai sistem operasi kedua di laptop saya, setelah Windows tentunya. Setiap saya beralih dari Ubuntu ke Windows, jam di sistem saya selalu kacau. Misalnya saat itu pukul 16.00, namun jam di laptop menunjukkan pukul 9.00, dst.

Pada awalnya anomali ini tidak saya saya pahami. Namun setelah saya baca sana dan sini, ternyata ada satu perbedaan mendasar yang menyebabkan kekacauan jam dan waktu tersebut.

## Perbedaan Fundamental antara Windows dan Linux

Di setiap perangkat komputer yang kita gunakan, baik itu PC maupun Latop, baik itu buatan Lenovo atau Apple, sudah pasti memiliki perangkat yang bernama [Real-time clock (RTC)](https://en.wikipedia.org/wiki/Real-time_clock). Fungsi dari perangkat ini adalah menyimpan waktu agar jam di komputer selalu akurat. Perangkat ini biasanya dilengkapi dengan baterai, sehingga apabila tidak ada daya yang disuplai ke komputer, maka waktu masih akan terus tersimpan dengan akurat.

Sistem operasi apapun yang digunakan di perangkat komputer akan membaca waktu yang tersimpan di RTC dan menampilkannya di sistem. Apabila pengguna mengubah jam yang ada di Windows misalnya, maka Windows akan menyimpan nilai waktu itu kembali ke RTC. Namun masing-masing sistem operasi memiliki caranya sendiri-sendiri untuk membaca dan menyimpan waktu ke RTC.

Linux, macOS, BSD, dan sistem operasi lain yang memiliki akar ke Unix, akan menyimpan waktu ke RTC dalam zona waktu [*Coordinated Universal Time*](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) atau UTC. Artinya apabila pengguna menyetel waktu di Ubuntu Linux pukul 19.00 WIB (UTC+7), maka Ubuntu akan menyimpan nilai waktu pukul 13.00 UTC ke perangkat RTC. Saat Ubuntu dinyalakan, ia akan membaca waktu dari RTC dengan zona waktu UTC, lalu dikonversi ke waktu lokal, dalam hal ini WIB / UTC+7. Selain itu kebanyakan distribusi Linux akan mengambil waktu dari Internet setiap saat perangkat komputer dihidupkan.

Di sini permasalahan mulai muncul. Windows — yang memiliki akar ke MS DOS — secara bawaan menyimpan waktu baik itu di sistem maupun ke RTC dalam [zona waktu lokal](https://devblogs.microsoft.com/oldnewthing/20040902-00/?p=37983). Artinya apabila Anda menyetel jam di Windows ke pukul 19.00, maka yang tersimpan di RTC juga pukul 19.00. Sehingga apabila pengguna berpindah dari Linux ke Windows, maka Windows akan membaca RTC yang ditulis oleh Linux dalam zona waktu UTC dan dianggap sebagai *local time*. Inilah yang menyebabkan jam di Windows selalu kacau apabila digunakan untuk dual boot dengan Linux.

Meskipun Windows memiliki fitur sinkronisasi waktu melalui internet, namun sayangnya ini tidak dilakukan langsung setiap Windows dinyalakan. Butuh waktu beberapa saat agar sinkronisasi ini bisa dilakukan, sesuai dengan yang telah dijadwalkan oleh Windows.

## Solusi: Agar Windows Baca Tulis Waktu dalam Zona Waktu UTC

Solusi yang ada sebenarnya bisa diaplikasikan baik itu ke Linux maupun ke Windows. 

Linux bisa diubah agar menyimpan dan membaca waktu dari RTC dalam zona waktu lokal. Sebaliknya, Windows juga bisa diset agar menyimpan dan membaca waktu dari RTC dalam zona waktu UTC. Namun solusi yang sebaiknya diambil adalah solusi yang kedua. RTC dalam zona waktu UTC menurut saya lebih saztbil dan *future proof*.

Caranya mudah. Buka `regedit` lalu tambahkan `DWORD` baru dan beri nilai hexadecimal `1` ke registry berikut ini:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal
```

Anda juga bisa copy perintah berikut ini, lalu paste ke Command Prompt dengan akses Administrator:

```
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f
```

Atau cara lebih mudahnya lagi, Anda bisa unduh berkas `.reg` berikut ini lalu jalanlan dengan cara `double click`. Akses ke akun Administrator mungkin dibutuhkan. [Unduh berkasnya di sini](/assets/downloads/dual-boot/windows_time_utc.reg).

**Catatan:**

Cara yang saya sebutkan di atas mungkin tidak berhasil diaplikasikan ke Windows versi lama, karena *bug* yang ada di versi lama. *Bug* tersebut antara lain:

* Untuk Windows 7 64-bit dan Windows 10 versi lama, ada *bug* yang mengharuskan penggunaan `QWORD` dengan nilai hexadecimal `1`, alih-alih menggunakan `DWORD`. *Bug* ini sudah dibenahi di Windows 10 versi baru.
* Untuk Windows Vista sebelum SP2, ada *bug* yang mengembalikan waktu RTC ke zona waktu lokal sesaat sesudah komputer dinyalakan dari mode *sleep* atau *hibernate*.
* Untuk Windows XP, ada *bug* yang menjadikan [*daylight saving time* (DST)](https://en.wikipedia.org/wiki/Daylight_saving_time) tidak akurat. Namun ini tidak berpengaruh bagi masyarakat Indonesia, karena tidak menggunakan DST.
* Untuk Windows dengan versi yang lebih lawas lagi, artikel berikut ini patut dibaca [https://www.cl.cam.ac.uk/~mgk25/mswish/ut-rtc.html](https://www.cl.cam.ac.uk/~mgk25/mswish/ut-rtc.html).

Stay curious! ✨

