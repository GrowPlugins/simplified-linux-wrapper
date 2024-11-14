# What is the Simplified Linux Wrapper?
This Linux shell script includes wrappers for various Linux CLI applications. The goal of this project is to make running various applications via CLI easier, without forcing you to remember ten arguments and commands for each application. This shell program is not meant to replace GUI's, so it focuses primarily on programs that must be (or perhaps are better to) run in a terminal.

![Screenshot_20241113_185916](https://github.com/user-attachments/assets/09312672-4b3c-4527-bd73-cd1ec21f801d)

# What Linux Applications Have a Wrapper So Far?
- [ZeroTier](https://www.zerotier.com/)
  - zerotier-manager.sh -- Allows starting and stopping the ZeroTier service, as well as adding and removing ZeroTier networks. -- Requires: [ZeroTierOne](https://www.zerotier.com/download/) be installed, and uses `zerotier-cli`.
- [DDEV](https://ddev.com/)
  - ddev-wordpress-manager.sh -- Allows you to create a new WordPress website locally on your desktop or server. Other features include starting/stopping the WordPress website, duplicating an existing website (for example to duplicate a website for further testing, without harming the original), snapshot creation/deletion, and deletion of a website. -- Requires: Nothing. If you don't have DDEV installed, running the script will allow you to install it automatically.
- [Dolibarr](https://www.dolibarr.org/)
  - dolibarr-installer-deb.sh -- Quickly and painlessly downloads a version of Dolibarr and install it using their "DoliDeb" installer. You can use it to download Dolibarr for the first time, or to upgrade to the latest version. Essentially just simplifies the process, so what could take you 15+ minutes only takes you 5 minutes, plus install time. -- Requires: Nothing.

# Can You Add a Wrapper for Me?
Maybe. This is a hobby project for me. I would prefer it if you could create one yourself and then create a pull request for it. However, if you can't make a wrapper yourself, I would at least need to have the documentation for the CLI application you want me to make a wrapper for, along with information on your use case.
