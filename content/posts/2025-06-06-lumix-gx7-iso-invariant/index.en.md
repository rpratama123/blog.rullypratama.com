---
title: "Is the Lumix GX7 ISO Invariant?"
date: "2025-06-06"
categories:
- "Photography"
---


{{< img src="panasonic_lumix_gx7.jpg" width="800" alt="Panasonic Lumix GX7 camera being held on hand" caption="My beloved Panasonic Lumix GX7 camera.">}}

Throughout 2012 to 2015 was when I first started getting into photography. The gear I used was a Canon EOS 20D. Since then, my preference for camera brands has always leaned toward Canon.

During that same period, discussions about ISO invariance in camera sensors began to emerge on the internet. I was disappointed because, at that time, test results showed that cameras with Sony-made sensors (like Nikon and Sony itself) had ISO invariant capabilities—marked by excellent shadow recovery—while Canon with its in-house sensors did not.

The defense from Canon users at the time was that Canon was widely used for portraiture, so color science and skin tones were more important than dynamic range. It was a bit of denial, in hindsight, but what can you do? That's fanboyism for you.

Fast forward to 2025, I finally decided to *migrate* from a Canon EOS 50D to a Panasonic Lumix GX7. Though it's an older model, it's been my dream camera for a long time. Since [Panasonic equipped this camera with their own sensor](https://www.imaging-resource.com/PRODS/panasonic-gx7/panasonic-gx7DAT.HTM), I was curious whether this sensor is ISO invariant like Sony's, or not like Canon's sensors.

To answer this question, I conducted my own experiment.

> **TL;DR:** This camera has an ISO invariant sensor.
> 
> It can be assumed that all cameras using Panasonic sensors behave similarly, though this remains to be proven through further testing.

## What is the difference between ISO variant and invariant cameras?

Before diving into the testing, it's worth briefly looking at ISO and the difference between the two.

ISO in film refers to the sensitivity level of the material to light. The higher the ISO value, the more sensitive the film is to capturing light. However, high ISO has the drawback of being *grainy*. Grain comes from light-sensitive particles. The larger they are, the more sensitive they become, but the grainier they appear.

In digital sensors, ISO refers to the level of amplification of the light signal captured by the sensor, which is later stored as a digital file. Just like in film, high ISO in digital sensors also has drawbacks. A high level of amplification doesn't just strengthen the light signal of the image we want; it also amplifies the noise.

Here is the path light takes to become a digital file:

| Stage                  | ISO Variant                                    | ISO Invariant                                  |
|----------------------------|----------------------------------------------------|----------------------------------------------------|
| Sensor                     | Light is captured and produces electrical voltage  | Light is captured and produces electrical voltage  |
| Analog Amplification       | **Amount matches the ISO used**                    | Unaffected by the chosen ISO                       |
| Analog to Digital Conv.    | Electrical voltage is converted into data          | Electrical voltage is converted into data          |
| Digital Amplification      | Minimal                                            | **Amount matches the ISO used**                    |
| Output                     | A digital file                                     | A digital file                                     |

From the comparison above, the striking difference between the two is that in ISO variant sensors, amplification is performed during the analog stage (electrical voltage). Therefore, once converted into digital data, shadow recovery will result in a very noisy image.

In ISO invariant sensors, amplification happens at the digital stage. Thus, it's the same whether the amplification is done in-camera or during post-processing using software like Adobe Lightroom, since both process the same digital data.

## Methodology

Two images were taken in RAW format: one with appropriate exposure using a high ISO of 3200. The other was taken at base ISO, in this case 200. The image taken at base ISO will be underexposed, so its exposure level will need to be raised using software, and then we will observe the noise levels in both.

From these results, if both images eventually have identical noise levels—one photo being no more noisy than the other—then it can be concluded that the sensor in this camera is ISO Invariant.

{{< img src="side-by-side.png" width="800" alt="Side-by-side result with different exposure setting" caption="Comparison of testing image & reference image, and it's respective exposure settings." >}}

## Results

After the test image was brightened by about +4.20 EV using Adobe Lightroom, the noise structure remained the same as the reference image. Subjectively, the test image looks slightly more noisy, but not significantly so.

From these observations, it can be concluded that the sensor in the Panasonic Lumix GX7 is ISO invariant.

{{< img src="side-by-side-2.png" width="800" alt="side-by-side result after the first image being adjusted to match the exposure of second image" caption="The testing image after being adjusted to match the reference image's brightness level. Note that the grain structure remains the same, indicating that Lumix GX7 is ISO invariant." >}}

Knowing that this camera is ISO invariant, users no longer need to fear that their shots aren't perfectly exposed, as long as they use the RAW format. Exposure can still be adjusted during post-processing using software.

Stay curious! ✨
