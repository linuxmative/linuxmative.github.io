---
layout: post
title: "Two Ways to Start with Linux Mative"
date: 2025-06-24
tags: [getting-started, iso, customization, linuxmative, umini, ustandard, usuite]
---

When it comes to starting your journey with **Linux Mative**, you have the freedom to choose the path that fits your workflow best. Whether you’re a DIY enthusiast or someone who wants a fast, functional base system out of the box — **we've got you covered**.

## 🔧 Path 1: Build It Yourself with the Official Script

Want to understand every part of your system and craft it exactly how you like?  
Linux Mative provides a full-featured **build script** that lets you generate your own minimal Ubuntu-based ISO image.

With the script, you can:

- Start from a clean base system (using official Ubuntu repositories)
- Control exactly which packages and tools get included
- Customize configuration, networking, filesystem, and init settings
- Generate a hybrid BIOS/UEFI bootable ISO
- Use it as a base for your own distribution or personal toolkit

📂 Repositories:

- [uMini (minimal ISO builder)](https://github.com/linuxmative/uMini)
- [uStandard (extended graphical ISO)](https://github.com/linuxmative/uStandard)
- [uSuite (advanced system builder — in development)](https://github.com/linuxmative/uSuite)

This path is ideal for developers, advanced users, or anyone looking to remaster Ubuntu for a specific purpose — from lightweight workstations to rescue environments or educational setups.

## 📦 Path 2: Use a Prebuilt ISO

If you want to **get started right away** without dealing with scripts, dependencies, and build tools — you can simply **download a ready-made ISO**, built using the same scripts.

Each variant is designed for different needs:

- 🔹 [**uMini**](https://github.com/linuxmative/uMini/releases): A minimal system with terminal interface, autologin, networking, and essential drivers. Ideal as a clean base or recovery system.
- 🔹 [**uStandard**](https://github.com/linuxmative/uStandard/releases): Includes graphical stack (X11), multimedia codecs, Wi-Fi support, and freedom to install any desktop environment.
- 🔹 [**uSuite**](https://github.com/linuxmative/uSuite/releases): *(Coming soon)* A powerful toolkit for advanced Linux system building, maintenance, and automation.

All images are available under the **Releases** section of each project.

## 🧭 Which Path Is Right for You?

| I want to...                             | Recommended option        |
|------------------------------------------|---------------------------|
| Learn by building and customizing myself | 🔧 Use the build script   |
| Get a working minimal system right now   | 📦 Use the prebuilt ISO   |
| Customize the system later from the base | 📦 Start with uMini       |
| Have multimedia and graphical support    | 📦 Use uStandard          |

---

**Linux Mative** was designed for flexibility — and both of these paths lead to the same goal:  
A clean, powerful, minimal system that puts **you** in control.

Which path will you take?

> 💡 Tip: If you start with a prebuilt ISO and like what you see, dive into the script and make it your own!

—
Created by [Maksym Titenko](https://github.com/titenko)
