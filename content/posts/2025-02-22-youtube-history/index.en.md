---
title: "YouTube Not Saving History? Why?"
date: "2025-02-22"
categories:
- "Tutorial"
---


A while ago, I was following an Age of Empires II tournament on YouTube. Since the tournament lasted for hours, I obviously didn't watch it all in one sitting. Instead, I would usually continue in my next spare moment.

YouTube usually saves our watch history. This includes when a video isn't watched until the end; YouTube will start playing from the exact same duration where we stopped in the previous session.

Then something strange happened. YouTube didn't mark the session! When I tried to rewatch, the video played from the beginning. Even the history playlist on YouTube didn't record the videos I had watched until the end!

Initially, I thought it was because the YouTube app on my phone was not up-to-date. But this anomaly also occurred on the PC I usually use.

After I searched on Google, it turns out the cause waaaaas...

## DNS aka Domain Name Server

Yes, at that time I had just installed [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) on our home local network. There was one domain that is actually important for YouTube but got blocked:

```
s.youtube.com
```

The solution is easy: whitelist or allow the domain `s.youtube.com` in AdGuard Home, Pi-hole, or NextDNS so that YouTube history works again.
