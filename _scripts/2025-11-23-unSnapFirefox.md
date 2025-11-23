---
layout: post
title: How to Replace Snap Firefox with the Native Mozilla Build on Ubuntu
date: 2025-06-24
tags:
  - unsnap
  - firefox
  - unsnapfirefox  
  - ubuntu
  - linuxmative
---

# How to Replace Snap Firefox with the Native Mozilla Build on Ubuntu (Automated Script)

If you are an Ubuntu user, you might have noticed that Firefox comes installed as a Snap package by default. while functional, the Snap version can sometimes suffer from slow startup times and integration issues with system themes or extensions.

Many users prefer the classic, native `.deb` version directly from Mozilla. However, switching isn't as simple as `apt install firefox` because Ubuntu creates a wrapper that redirects you back to Snap.

Below is a bash script that automates the entire process. It adds the official Mozilla repository, sets up APT pinning to prioritize the native version, and explicitly blocks Snap to prevent it from reinstalling itself.

### The Script

Save the following code into a file named `install_native_firefox.sh`:
    
    #!/bin/bash
    
    # 1. Create the directory for storing keyrings safely
    sudo install -d -m 0755 /etc/apt/keyrings
    
    # 2. Download and save the Mozilla repository signing key
    wget -q [https://packages.mozilla.org/apt/repo-signing-key.gpg](https://packages.mozilla.org/apt/repo-signing-key.gpg) -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
    
    # 3. Verify the key fingerprint for security
    gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
    
    # 4. Add the Mozilla repository to your sources list
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] [https://packages.mozilla.org/apt](https://packages.mozilla.org/apt) mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
    
    # 5. Prioritize packages from the Mozilla repository (APT Pinning)
    echo '
    Package: *
    Pin: origin packages.mozilla.org
    Pin-Priority: 1000
    ' | sudo tee /etc/apt/preferences.d/mozilla
    
    # 6. Block the Ubuntu Snap version of Firefox
    echo 'Package: firefox*
    Pin: release o=Ubuntu*
    Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/firefox-no-snap
    
    # 7. Block snapd entirely (Optional but included in script)
    echo 'Package: snapd
    Pin: release a=*
    Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/nosnap.pref
    
    # 8. Update and install the native Firefox
    sudo apt-get update && sudo apt-get install -y firefox
