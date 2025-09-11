# com.citrix.ICAClient
Build and/or install the Citrix Workspace app (ICAClient) as a Flatpak application for Linux.

## Disclaimer
This project and I are not affiliated with Citrix. This repository does not contain any Citrix software. When the user builds the Flatpak application using this template, the required packages are obtained from [Citrix's website](https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html), where Citrix has made the installers available for download. By downloading Citrix software, you agree to and accept the [Citrix End-User License Agreement](https://www.cloud.com/content/dam/cloud/documents/legal/end-user-agreement.pdf).

I use this flatpak on Fedora 42 and Linux Mint 22. Previous version (where this was forked from) was also tested on Bluefin, a variant of Fedora Silverblue. It is completely untested on any other distribution.

This repository will be supported and updated for as long as I require this for my work. As I am a consultant and change projects fairly frequently, this will not be for that long.

## Local build from sources
You can build your own flatpak using the following steps.

### Requirements
flatpak, flatpak-builder

You should be able to install these through your distro's package manager.

### Instructions
Perform the [flatpak setup](https://flatpak.org/setup/).

Add the flathub remote, and install the Gnome SDK and runtime:

    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user flathub org.gnome.Platform//42 org.gnome.Sdk//42

Clone/download this repo. Open a terminal in the folder where you downloaded this repo, and run the following:

    flatpak-builder --user --install --force-clean icaclient com.citrix.ICAClient.yml

(If your distro uses musl libc rather than the typical GNU libc, you may have to add the flag "--disable-rofiles-fuse" due to [this bug](https://github.com/flatpak/flatpak-builder/issues/329))

Once it is finished, it should be automatially added to your application launcher (may need to log out and back in for it to show up), if not you can launch it via:

    ~/.local/share/flatpak/exports/share/applications/com.citrix.ICAClient.desktop

Or launch it via command line:

    flatpak run com.citrix.ICAClient

You can also run it by opening .ica file (e.g. by double-clicking) or run any Citrix binary via command line:

    flatpak run com.citrix.ICAClient binary more-arguments

### Updating
When you build the app, it will automatically download the most recent version of Workspace. Therefore, if Citrix has published new verions you can update your flatpak app by simply re-running the `flatpak-builder` command listed above. However, you may need to empty the .flatpack-builder folder (located in the folder where you previously built the app), as Flatpak may see the build manifest hasn't changed and therefore use the cached files from the previous build, rather than re-downloading and grabbing the latest installers.

## Flatpak repository
This repository also hosts Github pages with Flatpak repository so the integration is much more streamlined, taking advantage of the [Flatter project](https://github.com/andyholmes/flatter).

You can take a look here: https://gaeldrin.github.io/com.citrix.ICAClient/
