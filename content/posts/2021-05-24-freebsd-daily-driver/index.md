---
title: "FreeBSD Sebagai Sistem Operasi Sehari-hari di Tahun 2021"
date: "2021-05-24"
description: "Gimana rasanya bila OS FreeBSD dijadikan sistem operasi sehari-hari? Yuk simak di sini"
featured: true
categories:
- "Random"
- "Tutorial"
keywords:
- "FreeBSD"
- "FreeBSD desktop"
- "sistem operasi freebsd"
- "freebsd sehari-hari"
---

{{< img src="freebsd-desktop.jpg" width="800" alt="FreeBSD as Desktop OS" caption="FreeBSD sebagai OS desktop sehari-hari." >}}

Apabila berbicara sistem operasi (OS) yang biasa digunakan dalam keseharian, saya yakin banyak orang menggunakan dan familiar dengan Windows. Selain itu ada pula yang menggunakan macOS. Sayangnya macOS pada dasarnya hanya bisa digunakan di perangkat besutan Apple saja. Lalu bagi yang antusias terhadap teknologi, pasti sudah tidak asing dengan GNU/Linux. Namun bagaimana dengan FreeBSD?

Secara silsilah, macOS, Linux dan BSD berasal dari satu rumpun yang sama. Perbedaannya, macOS sukses di ranah desktop sementara Linux dan BSD lebih banyak digunakan di server. Meski begitu, tak sedikit orang yang menggunakan Linux dan BSD sebagai sistem operasi desktop sehari-hari.

Di artikel saya kali ini, kita akan membahas kemungkinan digunakannya FreeBSD sebagai sistem operasi desktop sehari-hari. Perlu dicatat bahwa artikel ini bukanlah tutorial *step-by-step*, namun lebih ke *proof of concept*. Sehingga apabila kamu ingin mencobanya juga, Google dan YouTube menyediakan banyak sekali tutorial yang bisa kamu ikuti.

Langsung saja kita masuk ke poin utama. Kita akan menggunakan FreeBSD 13.0. Sistem operasi desktop yang ideal di tahun 2021 harus bisa digunakan untuk hal-hal berikut ini:

* Tampilan GUI dan aksesoris bawaan sistem operasi
* Terhubung ke internet dan membuka situs media sosial
* Konsumsi multimedia (memutar video, YouTube, Netflix, Spotify, dsb.)
* Manipulasi dokumen dan *spreadsheet*
* Editing foto dan atau video secara sederhana
* Online Meeting

Yuk mari kita kupas satu per satu!

## GUI dan Aksesoris Bawaan Sistem Operasi

FreeBSD secara bawaan tidak menawarkan opsi GUI *out of the box*. Pengguna harus mengunduh dan memasangnya sendiri. Pilihannya ada GNOME, KDE, Xfce maupun MATE, sama seperti distro Linux kebanyakan. Namun karena saya suka tampilan yang minimalis dan juga ringan, saya pilih MATE.

Agar proses lebih mudah dan simpel, saya gunakan *installation script* buatan Felix Caffier yang bisa kalian akses di link [Github ini](https://github.com/broozar/installDesktopFreeBSD).

{{< img src="general-utilities.jpg" width="800" alt="Aksesoris di Desktop MATE" caption="Aksesoris di Desktop Environment (DE) MATE." >}}

MATE desktop menawarkan fitur yang cukup lengkap sebagai *daily driver*, seperti file manager, kalender, text editor, penampil gambar, kalkulator, dst. Bagi saya fitur di atas sudah sangat cukup. Fitur yang belum ada seperti pemutar video bisa di-install dengan mudah melalui perintah `pkg` di terminal, yang akan saya bahas di bagian berikutnya.

## Konektivitas ke Internet

FreeBSD memiliki support yang cukup baik dalam hal konektivitas ke internet. Aplikasi perambah internet yang sering dipakai seperti Firefox dan Chromium selalu ter-update dengan versi yang terbaru, sama seperti versi di Windows, macOS, maupun di Linux. Dengan begitu sudah hampir bisa dipastikan semua website bisa dibuka dengan baik.

{{< img src="internet-connectivity.jpg" width="800" alt="Berselancar internet di FreeBSD" caption="Berselancar internet di FreeBSD. Ada banyak pilihan web browser yang bisa dipakai." >}}

Perambah internet Firefox, Chromium dan Epiphany — perambah bawaan GNOME — masing-masing saya coba untuk membuka dan berselancar Facebook, Twitter, dan Instagram. Saya gunakan juga untuk mengirimkan postingan di Facebook dan membuat twit baru. Semua berjalan lancar, sama halnya seperti menggukakan sistem operasi lain.

Yang menarik adalah ketika saya mencoba untuk masuk ke Instagram menggunakan perambah Epiphany. Instagram secara otomatis mengirimkan notifikasi ke alamat email saya mengenai percobaan masuk ke akun. Sistem operasi yang saya gunakan terdeteksi dengan benar, yaitu FreeBSD. Namun notifikasi menyatakan bahwa saya menggunakan perambah Safari!

{{< img src="instagram-login.png" width="800" alt="Instagram login from FreeBSD" caption="Uniknya browser Epiphany dianggap sebagai Safari oleh Instagram." >}}

Hal ini bisa dijelaskan karena perambah Epiphany menggunakan WebKit sebagai *engine*-nya, sebagaimana pula di Safari dan beberapa perambah yang lain.

## Konsumsi Multimedia dan Hiburan

Sistem operasi sehari-hari tidak terlepas dari hiburan. Musik dan video acapkali dipakai sebagai selingan pekerjaan. Lalu bagaimana FreeBSD memenuhi kebutuhan hiburan si pengguna?

Repository FreeBSD menyediakan pilihan pemutar musik dan video yang tak kalah dengan distribusi Linux. Saya dengan mudah meng-install Rhythmbox sebagai pemutar musik, VLC dan mpv sebagai pemutar video, melalui perintah `pkg`. Dengan dua aplikasi ini, memutar berkas media lokal tidak menjadi masalah.

Konsumsi media berupa YouTube juga bisa dibilang lancar. Ini berkat dukungan terhadap perambah internet yang selalu *up-to-date*. Dalam percobaan yang saya lakukan, video di YouTube bisa diputar hingga resolusi 1080p tanpa banyak terjadi *frame drop* menggunakan Firefox dan Chromium. Tentu saja hal ini kembali lagi ke spesifikasi komputer yang digunakan.

{{< img src="spotify-error.png" width="800" alt="Spotify tidak bisa dibuka di FreeBSD" caption="Spotify tidak bisa dibuka dikarenakan tidak adanya mekanisme DRM di FreeBSD." >}}

Masalah mulai muncul ketika FreeBSD digunakan untuk memutar media yang terproteksi oleh DRM seperti Netflix dan Spotifty. Pertama, tidak ada *native application* dari kedua platform tersebut di FreeBSD. Itu berarti tidak ada dukungan secara resmi dari penyedia media. Di sistem operasi lain, tanpa aplikasi khusus, Netflix dan Spotify masih tetap bisa diakses meskipun melalui perambah internet saja. Namun sayangnya tidak di FreeBSD.

Hal ini berujung ke masalah kedua, yaitu ketiadaan *DRM module* pada perambah internet yang tersedia di FreeBSD. Sehingga situs seperti Spotify dan Netflix menolak untuk bisa digunakan. Akan ada pesan kesalahan yang muncul seperti gambar di atas.

Hingga saat ini tidak ada solusi untuk Netflix. Spotify masih bisa digunakan menggunakan aplikasi berbasis *command line* melalu terminal. Ini tentu bukan solusi yang elegan. Namun bagi orang yang tidak takut dibilang *freak*, maka solusi ini asyik juga untuk dicoba.

{{< img src="freebsd-spotify-cli.jpg" width="800" alt="Command Line Spotify di FreeBSD" caption="Sebagai gantinya Spotify bisa diakses melalui tampilan CLI." >}}

Ada dua aplikasi yang membuat hal ini terjadi, yaitu `spotify-tui` dan `spotifyd`. Keduanya tersedia di berbagai macam sistem operasi. Tata cara instalasi di FreeBSD bisa dibaca [di sini](https://dev.ms/2020/03/spotify-on-freebsd/) dan [di sini](https://wiki.freebsd.org/Ports/audio/spotify-tui).

## Manipulasi Dokumen dan *Spreadsheet*

Bicara mengenai dokumen dan *spreadsheet*, aplikasi *de facto* yang banyak digunakan oleh orang adalah Microsoft Office. Tanpa mempedulikan cara mendapatkan aplikasinya, baik itu legal maupun ilegal. Sama seperti di distribusi Linux, tidak ada aplikasi *native* dari Microsoft Office yang bisa di-install di FreeBSD. Sehingga menyisakan dua alternatif saja.

### Office Suite Native di FreeBSD

Ada beberapa office suite *open source* alternatif yang bisa digunakan di sini. Antara lain LibreOffice dan Apache OpenOffice. Keduanya memiliki fitur yang sangat mirip, karena pada dasarnya mereka [berasal dari akar yang sama](https://www.techrepublic.com/article/whats-the-difference-between-libreoffice-and-openoffice/). Meski begitu, secara tampilan dan kompatibilitas dengan berkas MS Office, LibreOffice lebih baik.

{{< img src="freebsd-office-suite.jpg" width="800" alt="LibreOffice di FreeBSD" caption="LibreOffice di FreeBSD." >}}

Ada beberapa alternatif lain yang lebih ringan apabila fitur yang lengkap dan kompatibilitas dengan berkas MS Office tidak terlalu dibutuhkan, antara lain Abiword untuk aplikasi pengolah kata dan Gnumeric untuk *spreadsheet*.

### Office Suite Berbasis Web

Bekerja secara daring sudah menjadi norma akhir-akhir ini. Kerjasama dalam satu *platform* yang sama untuk membuat sebuah dokumen kolaboratif, kini semakin mudah dilakukan. Salah satu caranya adalah menggunakan solusi *office suite* berbasis web seperti Google Docs dan Microsoft Office Online.

Kelebihan dari solusi yang satu ini adalah tidak perlu adanya proses instalasi. Hanya perlu berbekal perambah internet yang memadai saja. Dan untungnya seperti yang sudah saya bahas sebelumnya, pilihan perambah internet di FreeBSD beragam dan selalu ter-update.

{{< img src="online-office-suite.jpg" width="800" alt="Office Suite berbasis web di FreeBSD" caption="Office Suite berbasis web di FreeBSD." >}}

Meski begitu perlu diingat bahwa mayoritas penyedia *platform* Office Suite berbasis web mengharuskan penggunanya untuk menyimpan berkas yang akan dibuka di penyimpanan daring mereka. Namun saya pikir ini tidak jadi masalah, karena hampir semua orang saat ini memiliki akun Google atau Outlook.

## Editing Sederhana Foto dan Video

FreeBSD tidak pernah dikenal luas sebagai sistem operasi desktop, lebih-lebih sebagai *workstation* editing foto dan video. Gelar tersebut biasanya dipegang oleh macOS dan Windows, karena di kedua OS tersebut akses ke *hardware acceleration* terbuka luas. Belum lagi aplikasi editing komersial mayoritas hanya tersedia di macOS dan Windows.

{{< video src="darktable-freebsd" width="800" alt="Darktable di FreeBSD" caption="Darktable sebagai alternatif Adobe Lightroom. Cukup lengkap secara fitur dan memiliki performa yang baik." >}}

Berikut ini beberapa aplikasi editing gratis atau *open source* yang tersedia di FreeBSD dan bisa langsung di-install menggunakan perintah `pkg`:

* GIMP — Alternatif untuk Adobe Photoshop
* Inkscape — Alternatif untuk Adobe Ilustrator dan CorelDRAW
* Scribus — Alternatif untuk Adobe InDesign
* Darktable dan RawTherapee — Alternatif untuk Adobe Lightroom dan Affinity Photo
* Kdenlive — Alternatif untuk Adobe Premiere Pro, Final Cut Pro, dan DaVinci Resolve

## Online Meeting

Dikarenakan situasi pandemi saat ini, banyak pekerjaan saat ini yang dilakukan secara daring, termasuk rapat/meeting. Tentunya sebagai sistem operasi yang akan dipakai untuk keseharian, tak afdal rasanya bila tak bisa digunakan untuk *online meeting*.

Di bagian ini, FreeBSD makin jelas tampak sebagai 'anak tiri' bila dibangkan dengan Linux. Pasalnya, beberapa *platform online meeting* yang tersedia aplikasinya di Linux — seperti Zoom, Microsoft Teams, Slack, dan bahkan Discord — tidak tersedia di FreeBSD. Oleh karena itu, pengguna FreeBSD harus berpuas hati ber-*meeting* menggunakan perambah internet / *web browser*.

Baru-baru ini tersedia [*package*](https://www.freshports.org/net-im/zoom/) `zoom-video-conferencing-client` yang bisa di-install melalui perintah `pkg`. Aplikasi Zoom ini menggunakan Linux *compatibility layer*. Sehingga ada beberapa limitasi, antara lain: suara tidak berfungsi, dan pengguna harus selalu *login* di setiap membuka aplikasi meski sebelumnya sudah pernah.

Oleh karena itu, bisa disimpulkan bahwa pengalaman *online meeting* di FreeBSD kurang menyenangkan. Baca juga tulisan David Schlachter dengan topik yang sama [di sini](https://www.davidschlachter.com/misc/freebsd-videoconferencing).

## Akhir Kata...

Sebuah pengalaman yang menyenangkan bisa menggunakan FreeBSD sebagai desktop selama beberapa minggu terakhir.

FreeBSD merupakan sistem operasi yang tangguh, aman dan stabil. Beberapa layanan besar seperti [Yahoo!](https://zer0.org/daemons/yahoobsd.html), [WhatsApp](https://freebsdfoundation.org/testimonial/whatsapp/), dan [Netflix](https://freebsdfoundation.org/testimonial/netflix/), menggunakan atau setidaknya pernah mempercayakan FreeBSD sebagai *backend server* mereka. Tapi kalau FreeBSD sebagai desktop OS? Sepertinya jarang didengar.

Dari percobaan yang saya lakukan, saya menyimpulkan bahwa FreeBSD **bisa** digunakan untuk keseharian. Namun bukan berarti saya menyarankan. Sekali lagi, artikel ini bukan tutorial, namun lebih sebagai *proof of concept*, sehingga silakan menggunakan sistem operasi apa saja yang menurut kalian terbaik.

Stay curious! ✨

