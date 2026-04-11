---
title: "Install Windows 11 on PC and Laptop Without TPM and Secure Boot"
date: "2021-10-24"
description: "Curious about Windows 11, but your PC doesn't support TPM and Secure Boot? Here's how to bypass it..."
categories:
- "Tutorial"
- "Random"
keywords:
- "windows 11"
- "install windows 11"
- "windows 11 without tpm"
- "windows 11 without secure boot"
---

{{< img src="win-11-cover.png" width="800" alt="Ilustrasi Windows 11" caption="Ilustrasi Windows 11." >}}

Many people want to try Windows 11, which was just released in October this year. Unfortunately, many are disappointed because Microsoft requires Windows 11 to be installed on devices that have TPM and Secure Boot. I will share a way to fresh install Windows 11 without TPM and Secure Boot.

Here I assume the reader already has experience installing Windows on a laptop or PC.

For those who frequently install Windows or other operating systems on PC devices, you're likely familiar with this tool. Shortly after Windows 11 was released, Rufus added support for creating Windows 11 USB installers that can be used on devices without TPM or Secure Boot.

Here is what you'll need:

* Windows 11 ISO file which can be downloaded from the [official website](https://www.microsoft.com/en-us/software-download/windows11)
* Latest Rufus which can be downloaded [here](https://rufus.ie/en/)
* USB flash disk with at least 8 GB capacity

{{< img src="win-11-rufus.png" width="800" alt="Rufus Windows 11" caption="Rufus Windows 11." >}}

Here are the steps:

1. Make sure the USB flash disk is plugged into the PC.
2. Open Rufus, select the flash disk you want to use, then select the Windows 11 ISO file.
3. Then in the **Image Option** section, select `Extended Windows 11 Installation (no TPM/no Secure Boot/8GB- RAM)`.
4. Click **Start** and wait until the process is complete.
5. Install Windows 11 on your PC or laptop as usual.
