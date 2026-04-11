---
title: "Shutdown Otomatis Komputer Tanpa Aplikasi Tambahan"
date: "2019-12-15"
description: "Mau tahu cara timer shutdown pada komputer tanpa aplikasi tambahan? Simak berikut ini..."
categories:
- "Tutorial"
- "Random"
keywords:
- "shutdown otomatis"
- "shutdown windows"
- "tutorial shutdown otomatis"
- "shutdown cmd"
---

{{< img src="shutdown-0.png" width="800" alt="Ilustrasi Laptop" caption="Ilustrasi Laptop." >}}

Terkadang kamu dihadapkan dengan situasi seperti ini: komputer yang kamu gunakan sedang memproses sesuatu. Bisa jadi sedang render video nikahan mantan, atau sedang download film bajakan. Prosesnya memakan waktu yang tidak sebentar, tapi kamu sedang buru-buru janjian dengan gebetan.

Di sisi lain, kamu juga tidak ingin laptop atau PC mu hidup selama berjam-jam tak digunakan hingga malam. Apa yang harus kamu lakukan? Di artikel ini, kita akan belajar bagaimana agar komputer shutdown secara otomatis.

Di setiap sistem operasi yang ter-install di komputer kita, baik itu Windows, macOS atau Linux, memiliki fitur yang bisa mematikan komputer secara otomatis dalam jangka waktu tertentu. Tak banyak orang tahu tentang fitur ini. Karena fitur ini ada dalam bentuk command line atau baris perintah.

Jangan khawatir, meski dalam bentuk *command line*, fitur ini sangat mudah digunakan dan tidak perlu menggunakan aplikasi tambahan. Langsung saja, berikut ini caranya:

## Windows

{{< img src="shutdown-1.png" width="800" alt="Windows Run command" caption="Windows Run command." >}}

Jalankan **Command Prompt** dengan cara klik Start, lalu ketikkan Command Prompt. Lebih mudah lagi kalian bisa mengaksesnya melalui menu Run, yaitu tekan **Win+R**, ketik **cmd**, lalu tekan Enter.

Lalu ketikkan baris perintah berikut ini dan tekan Enter:

```
shutdown -s -t 3600
```

Berikut penjelasan untuk opsi yang dapat digunakan:

|   Perintah   |   Penjelasan 
| -----------  | -------------
| shutdown | perintah untuk mematikan komputer
| -s       | perintah untuk shutdown. Bisa juga diganti dengan **-l** untuk logout, **-r** untuk restart dan **-h** untuk hibernate
| -f       | tambahkan opsi ini untuk menutup paksa program bandel yang mungkin bisa mencegah shutdown
| -a       | opsi ini dapat digunakan untuk membatalkan perintah shutdown yang sebelumnya telah dilakukan
| -t       | opsi timer untuk shutdown. Apabila tidak diisi, komputer akan mati dalam 20 detik. Bila diisi **0**, maka perintah akan dieksekusi saat itu juga. Bisa juga diisi dengan angka dalam hitungan detik (misal 60 detik x 60 menit = 3600 detik untuk 1 jam)

{{< img src="shutdown-2-1.png" width="800" alt="Perintah shutdown di Windows" caption="Perintah shutdown di Windows." >}}

Apabila sering digunakan, perintah tersebut juga bisa dibuat menjadi shortcut, lho! Shortcut ini nantinya dapat ditaruh di desktop dan dapat diakses dengan mudah.

1. Klik kanan pada area kosong di desktop. Pilih **New > Shortcut**.
2. Akan muncul **"Type the location of the item:"**. Isi dengan baris perintah yang sama dengan contoh di atas. Bisa juga disesuaikan waktunya sesuai dengan keinginan. Lalu klik Next.
3. Setelah itu, isikan nama untuk shortcut yang baru saja di buat. Agar mudah diingat, akan saya beri nama **Turn off 1 hour**. Klik Finish.

{{< img src="shutdown-3.png" width="800" alt="Shortcut shutdown otomatis dalam waktu 1 jam" caption="Shortcut shutdown otomatis dalam waktu 1 jam." >}}

Sampai tahap ini, *shortcut* sudah berhasil di buat. Namun belum memiliki icon. Untuk mengubah icon-nya mudah. Klik kanan *shortcut* tersebut, lalu pilih **Properties**.

Pada tab Shortcut, klik tombol **Change Icon…** Pilih icon yang diinginkan, lalu klik OK. Seharusnya shortcut yang baru saja kalian buat sudah berubah icon-nya.

## macOS / Linux

Di macOS dan Linux juga ada perintah shutdown yang dapat diakses melalui terminal. Tapi karena kedua OS ini anak turun dari UNIX, maka penggunaan fungsi ini sedikit berbeda dibanding di Windows.

Di macOS, untuk mengakses Terminal tekan tomobol **Command + Space** di keyboard untuk memunculkan Spotlight Search. Ketik “terminal” tanpa tanda petik, lalu tekan Enter.

Sementara di Linux, untuk mengakses terminal berbeda dari satu distro ke distro yang lain. Namun pada umumnya, terminal ada pada bagian **Utilities** di daftar aplikasi.

{{< img src="shutdown-5.png" width="800" alt="Jalankan Terminal di macOS" caption="Jalankan Terminal di macOS." >}}

Apabila aplikasi Terminal sudah terbuka, masukkan perintah berikut ini:

```
sudo shutdown -h -t 3600
```

Di macOS dan Linux, hanya user root yang bisa memanggil perintah shutdown. Oleh karena itu, kita menggunakan sudo. Lebih lanjut lagi, berikut ini opsi yang bisa digunakan:

|   Perintah       |   Penjelasan
| ------------     | ----------
| sudo             | perintah untuk menjalankan fungsi dengan user root
| shutdown         | perintah untuk mematikan komputer
| -h               | perintah untuk mematikan (halt) komputer. Bisa juga menggunakan **-P** yang juga akan mematikan komputer. Untuk restart bisa dengan **-r**
| -a               | opsi ini dapat digunakan untuk membatalkan perintah shutdown yang sebelumnya telah dilakukan
| -t               | opsi timer untuk shutdown. Apabila tidak diisi, komputer akan mati dalam 20 detik. Bila diisi **0**, maka perintah akan dieksekusi saat itu juga. Bisa juga diisi dengan angka dalam hitungan detik (misal 60 detik x 60 menit = 3600 detik untuk 1 jam)
| time             | selain dalam hitungan detik, waktu absolut juga dapat dimasukkan di sini dalam format hh:mm misalnya 23:30

{{< img src="shutdown-6.png" width="800" alt="Perintah shutdown di macOS" caption="Perintah shutdown di macOS." >}}

Setelah perintah dimasukkan, tekan Enter, maka kamu akan dimintai untuk memasukkan password akun root. Tekan Enter sekali lagi setelah memasukkan password, maka komputer akan mati sesuai dengan waktu yang telah ditentukan.

Nah, seperti itu cara mudah untuk shutdown otomatis komputer tanpa aplikasi tambahan. Semoga bermanfaat! ✨

