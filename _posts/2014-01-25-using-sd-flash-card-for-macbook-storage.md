---
title: Using an SD flash card for extra storage in a MacBook Pro
description: A tip for a simple way to add disk space on some laptops
toc: false
layout: post
categories: [general]
keywords: [life-hacks, hardware, mac]
---

One never seems to have enough disk space on laptops, and that's especially true on Mac OS X systems.  It's surprising how quickly you can use up the space on even a 500 GB SSD drive once you add such things as multiple virtual machines (for software development on Windows and Linux), iTunes (for synchronizing my iPhone and iPad), bibliography management programs with gigabytes and gigabytes of PDFs, years of archives of meetings and workshops, etc.  Plus, the operating system's virtual memory files and sleep image take up a chunk of space.  On top of that, you have to leave at least 10% of the disk space free for good file system performance, so you never really get to use the full 500 GB anyway.

I found myself running out of space on a MacBook Pro Retina, and an upgrade to a 1 TB internal disk was just too expensive to justify.  An intriguing idea presented itself, however: the rMBP's have an SD memory card slot, one which I almost never actually use.  Couldn't I just keep an SD flash card plugged in and use it for extra storage?

Well, the problem with regular SD memory cards is that they stick out of the slot.  You simply can't leave a card plugged in all the time, because you're sure to damage it while moving your laptop around, especially in and out of bags.  On the other hand, if you had to keep mounting and dismounting the card and pulling it out and back in, it would just be too much of a hassle and too prone to accidents.  If only those SD cards were shorter ...  Hmm ...

<figure class="float-right width-33">
  <img src="/blog/images/macbook-pro-side.jpg"/>
</figure>

So I looked around for shorter SD cards.   Turns out short SD cards do not seem to exist, but something else *does*: an adapter for _micro_ SD cards that fits flush with the exterior of the laptop!  I found one product in particular, the [MiniDrive](https://www.theminidrive.com), works well enough and suits my needs.  I bought it, along with the highest-capacity micro SDXC card available (which is currently 64 GB, though 128 GB are supposed to come in the near future), mounted it, formatted it, and moved various not-so-essential files to it. And it works!

In case any readers are interested in doing the same, here are some noteworthy points:

1. The first micro SDXC flash card I bought didn't work properly.  This fact was not immediately obvious: I copied files to it seemingly without error, and the files had the correct sizes and properties, and the first few files I verified seemed okay.  But files soon ended up containing only zeros inside—something I didn't realize until the next day when I tried to look at a file.  The card was the fastest SanDisk-branded 64 GB micro SDXC I could find.  I returned it and bought a Samsung Electronics [64GB Pro microSDXC Extreme Speed Memory Card](http://www.samsung.com/uk/consumer/memory-cards-hdd-odd/memory-cards-accessories/micro-sdhc-pro/MB-MGCGB/EU) (MB-MGCGB/AM).  It was more expensive than the SanDisk card, but it has been working flawlessly. I have no idea whether the particular SanDisk card I got was a dud (although it turns out reviewers on Amazon *do* complain about that card being unreliable), but based on this experience I would recommend the Samsung card. Whatever you get, after writing *a lot* of data to it make sure to test it carefully.
2. Make sure to format the card to use the Mac OS X Extended Journaled file system format.  Do not use the default format, which (IIRC) is exFAT and highly suboptimal for use on Mac OS X. 
3. Be aware that the card's read/write speeds are much slower than your main disk's. So, use the card for storing such things as infrequently-used applications, files you want around but don't access daily, and backups.
4. Add the volume to your Time Machine backups, so that whatever you put on it will be backed up.

One of the things I moved to the card is my `~/Library/Application Support/MobileSync/Backup` directory. I left a symbolic link in its place; this moves the backups from my iPad and iPhone off the main disk, yet still allows iTunes and mobile sync to work normally.  It does slow down syncs, but not enough to get in my way.  (YMMV of course, so it's worth experimenting.)

This whole scheme has been working without trouble for me for months now, and has saved 50 GB of space.  I still have room for a little bit more on the card.
