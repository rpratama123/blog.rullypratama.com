---
title: "Tool: GOPupd"
date: "2023-04-29"
description: "Flash old video card firmware that doesn't support UEFI using this tool"
categories:
- "Tutorial"
- "Tool"
keywords:
- "gopupd"
- "amd"
- "nvidia"
- "gpu support uefi"
- "gpu uefi mode"
---

{{< img src="gopupd-before-after.png" width="800" alt="GPU-Z view before and after" caption="GPU-Z view before and after tweak using this tool." >}}

A while ago, I bought an AMD Radeon HD 7750 GPU from Facebook for 350,000 rupiah. I deliberately bought this old GPU for Hackintosh purposes. AMD GPUs are known for having excellent compatibility with macOS compared to Nvidia. When I paired this GPU with an Intel 12th Gen platform, the display only appeared on the monitor once the booting process reached the Windows login screen. Initially, I thought the GPU I bought had a defect, but I was wrong.

After I researched various internet forums, the reason why a black screen appeared during the booting process was that the GPU I installed was too old to support booting in UEFI-only mode (non-CSM). Older GPUs usually do not have UEFI firmware in their *Video BIOS*. Whether a GPU has UEFI firmware or not can be seen with the GPU-Z tool.

{{< img src="gopupd-no-uefi.png" width="800" alt="GPU without UEFI firmware" caption="GPU without UEFI firmware, as seen on GPU-Z the UEFI checkbox isn't checked." >}}

The GOPupd tool functions to insert GOP information into the *Video BIOS*, making older GPUs UEFI-compatible. Not just AMD GPUs, this tool can also be used for Nvidia GPUs. However, not all older GPUs can be 'tricked'. Here is a list of compatible GPUs:
- **AMD**: HD 6xxx, 7xxx series, or newer.
- **Nvidia**: Series with GT21x, GF10x, GF119, GK1xx/GK2xx, GM1xx, GM2xx chips, or newer.

The steps to be taken are:
1. Extract the original *Video BIOS* (VBIOS) from the GPU you're using (easiest way is using GPU-Z, then click the share button under the manufacturer logo).
2. Run the GOPupd tool then drop the original VBIOS file we obtained from step 1.
3. Re-flash the VBIOS to the GPU (For AMD use ATIFlash, for Nvidia use NVFlash).

Keep in mind that any risk of damage is your own responsibility ✌️

Here are some useful links (including download links):
- [Tool: GOPupd](https://firmwaresecurity.com/2016/02/23/tool-gopupd/#:~:text=GOPupd%20is%20a%20tool%20that%20updates%20a%20GOP,older%20GPU%20compatible%20to%20pure%20UEFI%20%28non-CSM%29%20mode.)
- [AMD and Nvidia GOP update](https://web.archive.org/web/20230321142121/https://winraid.level1techs.com/t/amd-and-nvidia-gop-update-no-requests-diy/30917)
- [GOPupd download](/assets/downloads/gopupd/GOPUpd_v1.9.6.5.rar)
