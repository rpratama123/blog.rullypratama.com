---
title: "Windows 7: Installation and Usage Experience in 2025"
date: "2025-02-26"
draft: true
categories:
- "Tutorial"
---


Windows 7 is arguably the most successful version of Windows. How could it not be? This version was adopted by a vast number of users in a very short time, boasted compatibility with many applications, and was wrapped in a very beautiful interface. That's why Windows 7 feels so *nostalgic* (maybe XP too).

Unfortunately, Windows 7 has not been supported since 2015. That means Microsoft has stopped releasing *security updates*. Almost all software released in the last 5 years no longer supports Windows 7. However, that doesn't mean Windows 7 can't be used anymore.

In this post, we'll dive into the experience of using Windows 7 in 2025. From installation and driver configuration to the usage of everyday applications.

## Hardware Configuration Used

Initially, I intended to use my primary PC for the experiment. Unfortunately, the PC with specs like an Intel i7-13700H, 32GB RAM, and NVIDIA RTX 3060 is not compatible with Windows 7 because my motherboard only supports UEFI without BIOS/CSM. So, the choice fell on the second most modern PC I own.

The ASRock H110M-DSG and Intel Core i3-7100 combo was released in the same year or even 2 years after Windows 7 was discontinued. The good news is that the manufacturer still officially supports Windows 7. Drivers for this Windows version can still be found on their official website.

| **Hardware** | **Specification**        |
|--------------|--------------------------|
| CPU          | Intel Core i3-7100       |
| Motherboard  | ASRock H110M-DGS         |
| RAM 1        | 1 x 8 GB DDR4            |
| RAM 2        | 1 x 4 GB DDR4            |
| GPU          | NVIDIA GT 1030 2 GB GDD5 |
| SSD		   | 2 X ADATA SP610 128 GB   |

With all the hardware installed, let's move on to the installation.

## An Installation That Was Not Easy, but Successful

I previously mentioned that **[Obstacle #1:]()** Windows 7 does not fully support UEFI. That's why I eventually used an older hardware configuration.

Windows 7 is among the fairly modern versions of Windows. Installation media can use a DVD or a USB stick. I chose a USB stick as the installation media, just like any 'sane' person in 2025. However, **[Obstacle #2:]()** appeared: Windows 7 does not natively support USB 3.0 (xHCI). On motherboards from the Intel 100 & 200 chipsets onwards, as well as on AMD AM4, every USB port is essentially a USB 3.0 port, even if it looks like a USB 2.0 port.

Fortunately, ASRock provides a utility and easy-to-understand instructions to overcome this hurdle. You can read more [here](https://www.asrock.com/microsite/Win7Install/index.html). The utility will inject USB 3.0 drivers into the Windows 7 ISO so the installation runs smoothly.

Moving on...
