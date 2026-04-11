---
title: "Fan Mod on HBA Card LSI SAS 9210-8i, Making the Chip Much Cooler"
date: "2023-10-09"
description: "This server-grade HBA card can sometimes get excessively hot during use. Adding a fan can be the solution."
categories:
- "Tutorial"
- "Random"
keywords:
- "fan mod hba card"
- "fan mod lsi sas 9210"
- "hba card lsi sas 9210 hot"
- "hba card lsi sas 9210 overheat"
- "DIY NAS"
---


Recently, I moved my *Network Storage System* (NAS) components from a mini ITX case to a refurbished HP 8300 Small Form Factor (SFF) PC. I'm quite happy with this migration because the HP 8300 has more room, allowing me to add more *storage drives* in the future. Additionally, the airflow in this PC is better, so components like the CPU and HDD are much cooler.

To accommodate more *drive bays*, I added an LSI 9210-8i HBA Card, which serves to 'multiply' storage ports. This HBA card is designed for *enterprise* use, where servers are kept in very cold rooms with excellent airflow. Consequently, this HBA card is not equipped with a fan, only a passive heatsink.

{{< img src="HBA-LSI-9210-8i-fan-mod.webp" width="800" alt="HBA LSI 9210-8i card, sebelum dan sesudah modifikasi fan" caption="**1** - HBA card, before modification; **2** - after modification, fan power is connected to SATA." >}}

When working, this card tends to get hot. A simple way to check: touch the heatsink with your finger; if it feels too hot to hold, then it likely needs active cooling.

This modification might also be applicable to other series of HBA cards. These are the materials and tools I used to perform this modification:
1. Small 4 cm 12V fan, two wires - [Tokopedia link](https://www.tokopedia.com/search?st=&q=fan%204cm&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Female SATA power extension cable - [Tokopedia link](https://www.tokopedia.com/search?st=&q=sata%20female%20power%20extension&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. 4 sets of M3 X 30mm or M3 X 40mm screws - [Tokopedia link](https://www.tokopedia.com/search?st=&q=sekrup%20m3%20x%2040&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Heat shrink tube, sized according to the fan cable - [Tokopedia link](https://www.tokopedia.com/search?st=&q=heat%20shrink%20tube&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=)
1. Soldering iron, solder, scissors, and electrical tape

{{< img src="4cm-fan-and-sata-power-cable-extension.webp" width="800" alt="4 cm fan 12 V dan kabel SATA power extension" caption="**1** - 4 cm fan 12V; **2** - SATA power extension cable." >}}

Fortunately, the holes on this card's heatsink are perfectly spaced for a 4 cm fan. So, installing the fan is very easy:
1. Remove the plastic clips holding the heatsink. Press the clip from the top, then cut the retainer at the bottom with scissors. This part will not be used again, so it's safe to discard.
1. Cut 2 strips of electrical tape, make a hole the size of the screw shank, then stick it over the clip holes on the bottom of the card. This serves to keep the screw from touching the card components, thus avoiding short circuits.
1. Position the fan so its holes align with the clip holes you just cleared. Then tighten by installing 2 screws and nuts.
1. Solder the fan wires to the female SATA power connector. Ensure the fan's red wire meets the yellow wire, and the black wire meets the black wire. Don't get them reversed!

Those are the steps for the modification. With the addition of the fan, the chip on this HBA card can be cooler, and hopefully, it will last longer.

Stay tuned! 🚀
