---
title: "Fixing Clock Issues in Windows and Linux Dual Boot"
date: "2021-06-05"
description: "Does your clock get messed up every time you switch from Linux to Windows? Here's the explanation..."
categories:
- "Tutorial"
- "Random"
keywords:
- "dual boot"
- "windows and linux dual boot"
- "windows time"
- "windows time utc"
---


{{< img src="time.png" width="800" alt="Ubuntu Linux and Windows dual boot illustration" caption="Ubuntu Linux and Windows dual boot illustration." >}}

Playing around with Linux is indeed fun. Trying a system that is completely new to your daily routine is a thrill in itself. However, problems often arise, especially when Linux is paired with Windows on a single computer device via *dual boot*. One of them is the issue regarding the clock.

It's a trivial matter, but very annoying if ignored. I first observed this problem when using Ubuntu Linux as a second operating system on my laptop, after Windows, of course. Every time I switched from Ubuntu to Windows, my system clock was always messed up. For example, if it was 4:00 PM, the laptop clock showed 9:00 AM, and so on.

At first, I didn't understand this anomaly. But after reading here and there, it turns out there is one fundamental difference that causes the mess-up in time.

## Fundamental Difference between Windows and Linux

Every computer device we use, whether it's a PC or Laptop, whether made by Lenovo or Apple, definitely has a device called the [Real-time clock (RTC)](https://en.wikipedia.org/wiki/Real-time_clock). The function of this device is to store the time so that the computer's clock is always accurate. This device is usually equipped with a battery, so if no power is supplied to the computer, the time will still be stored accurately.

Any operating system used on a computer device will read the time stored in the RTC and display it in the system. If a user changes the clock in Windows, for example, Windows will save that time value back to the RTC. However, each operating system has its own way of reading and saving time to the RTC.

Linux, macOS, BSD, and other operating systems rooted in Unix will save the time to the RTC in the [*Coordinated Universal Time*](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) or UTC time zone. This means if a user sets the time in Ubuntu Linux to 7:00 PM WIB (UTC+7), Ubuntu will save a time value of 1:00 PM UTC to the RTC device. When Ubuntu is turned on, it reads the time from the RTC in UTC and converts it to local time, in this case, WIB / UTC+7. Additionally, most Linux distributions will fetch the time from the Internet whenever the computer is turned on.

This is where the problem starts. Windows—which has its roots in MS-DOS—by default saves time both in the system and to the RTC in the [local time zone](https://devblogs.microsoft.com/oldnewthing/20040902-00/?p=37983). This means if you set the clock in Windows to 7:00 PM, what's stored in the RTC is also 7:00 PM. Thus, when a user moves from Linux to Windows, Windows reads the RTC written by Linux in UTC but treats it as *local time*. This is what causes the Windows clock to always be messed up when used for dual boot with Linux.

Although Windows has a time synchronization feature via the internet, unfortunately, it's not done immediately every time Windows starts up. It takes a few moments for this synchronization to occur, as scheduled by Windows.

## Solution: Make Windows Read and Write Time in the UTC Time Zone

The available solutions can actually be applied to either Linux or Windows.

Linux can be modified to save and read time from the RTC in the local time zone. Conversely, Windows can also be set to save and read time from the RTC in the UTC time zone. However, the second solution is the one that should be taken. RTC in the UTC time zone is, in my opinion, more stable and *future-proof*.

It's easy. Open `regedit`, then add a new `DWORD` and give it a hexadecimal value of `1` to the following registry:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal
```

You can also copy the following command and paste it into the Command Prompt with Administrator access:

```
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f
```

Or even easier, you can download the following `.reg` file and run it by `double clicking`. Administrator access may be required. [Download the file here](/assets/downloads/dual-boot/windows_time_utc.reg).

**Notes:**

The method I mentioned above might not work on older versions of Windows due to existing bugs in those versions. These bugs include:

* For 64-bit Windows 7 and older versions of Windows 10, there is a bug that requires the use of `QWORD` with a hexadecimal value of `1` instead of `DWORD`. This bug has been fixed in newer versions of Windows 10.
* For Windows Vista before SP2, there is a bug that reverts the RTC time to the local time zone shortly after the computer wakes up from *sleep* or *hibernate* mode.
* For Windows XP, there is a bug that makes [*daylight saving time* (DST)](https://en.wikipedia.org/wiki/Daylight_saving_time) inaccurate. However, this does not affect Indonesians since they don't use DST.
* For even older versions of Windows, the following article is worth reading: [https://www.cl.cam.ac.uk/~mgk25/mswish/ut-rtc.html](https://www.cl.cam.ac.uk/~mgk25/mswish/ut-rtc.html).

Stay curious! ✨
