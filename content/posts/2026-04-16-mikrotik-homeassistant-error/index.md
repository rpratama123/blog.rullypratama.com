---
title: "Mengatasi Mikrotik Router Custom Integration Error di Home Assistant 2026.4.2"
date: "2026-04-16"
description: "Cara memperbaiki koneksi integrasi Mikrotik Router yang terputus setelah update Home Assistant ke versi 2026.4.2."
categories:
  - "Tutorial"
  - "Tool"
keywords:
  - "home assistant"
  - "mikrotik"
  - "mikrotik router"
  - "custom integration"
  - "home lab"
  - "error"
featured: false
---

Baru-baru ini saya melakukan *update* Home Assistant di *server* Unraid saya (berjalan di atas Docker) ke versi 2026.4.2. Proses *update* berjalan lancar seperti biasa, sampai saya sadar ada satu hal yang janggal.

Integrasi Mikrotik Router tiba-tiba terputus dan tidak bisa terhubung sama sekali ke *router* Mikrotik saya.

{{< img src="mikrotik-homeassistant.png" alt="Mikrotik Router Custom Integration di Home Assistant" caption="Custom integration Mikrotik Router via HACS yang mendadak error" >}}

## Apa Penyebabnya?

Untuk mencari tahu masalahnya, saya langsung mengecek *file* `home-assistant.log`. Di sana, saya menemukan *error* yang cukup jelas:

```text
ERROR (SyncWorker_5) [custom_components.mikrotik_router.mikrotikapi] Mikrotik 10.20.30.40 error while connecting: connect() got an unexpected keyword argument 'login_methods'. Did you mean 'login_method'?
```

Dari log tersebut, terlihat bahwa ada perubahan parameter dari `login_methods` menjadi `login_method` pada *library* bawaan yang digunakan. Sayangnya, *maintainer* dari *custom integration* ini ([tomaae/homeassistant-mikrotik_router](https://github.com/tomaae/homeassistant-mikrotik_router)) sepertinya belum merilis *update* untuk memperbaiki *bug* ini.

Bagaimana tidak kesal? Tapi untungnya, kita bisa memperbaiki masalah ini sendiri dengan sedikit modifikasi *file* secara manual.

## Cara Memperbaiki

Kita perlu mengedit *file* `mikrotikapi.py` yang ada di dalam *folder* instalasi *custom integration* tersebut.

### Langkah 1: Edit File

Buka *file* `/custom_components/mikrotik_router/mikrotikapi.py` menggunakan *text editor* andalan kalian.

### Langkah 2: Tambahkan Import

Di bagian atas *file*, tambahkan deklarasi *import* baru berikut ini:

```python
from librouteros.login import plain, token
```

### Langkah 3: Ganti Fungsi Connect

Cari fungsi `connect(self) -> bool:` di dalam *file* tersebut, lalu timpa seluruh fungsi tersebut dengan *code* di bawah ini:

```python
    # ---------------------------
    #   connect
    # ---------------------------
    def connect(self) -> bool:
        """Connect to Mikrotik device."""
        self.error = ""
        self._connected = False
        self._connection_epoch = time()

        login_method = self._login_method
        if login_method == "plain":
            login_method = plain
        elif login_method == "token":
            login_method = token

        kwargs = {
            "encoding": self._encoding,
            "login_method": login_method,
            "port": self._port,
        }

        self.lock.acquire()
        try:
            if self._use_ssl:
                ssl_context = ssl.create_default_context()
                ssl_context.check_hostname = False

                if self._ssl_verify:
                    ssl_context.verify_mode = ssl.CERT_REQUIRED
                    ssl_context.verify_flags &= ~ssl.VERIFY_X509_STRICT
                    from functools import partial
                    ssl_wrapper = partial(
                        ssl_context.wrap_socket,
                        server_hostname=self._host,
                    )
                else:
                    ssl_context.verify_mode = ssl.CERT_NONE
                    ssl_context.set_ciphers("ADH:@SECLEVEL=0")
                    ssl_wrapper = ssl_context.wrap_socket

                kwargs["ssl_wrapper"] = ssl_wrapper
            self._connection = librouteros.connect(
                self._host, self._username, self._password, **kwargs
            )
        except Exception as e:
            if not self.connection_error_reported:
                _LOGGER.error("Mikrotik %s error while connecting: %s", self._host, e)
                self.connection_error_reported = True

            self.error_to_strings(f"{e}")
            self._connection = None
            self.lock.release()
            return False
        else:
            if self.connection_error_reported:
                _LOGGER.warning("Mikrotik Reconnected to %s", self._host)
                self.connection_error_reported = False
            else:
                _LOGGER.debug("Mikrotik Connected to %s", self._host)

            self._connected = True
            self._reconnected = True
            self.lock.release()

        return self._connected
```

Simpan *file* tersebut, lalu *restart* Home Assistant.

Setelah proses *restart* selesai, integrasi Mikrotik Router seharusnya sudah kembali terhubung dengan normal tanpa ada *error* di log. Setidaknya *fix* sementara ini bisa kita gunakan sampai *maintainer* resminya merilis pembaruan.

Stay curious! ✨