#!/bin/sh

## Description
# This little script downloads the Debian-Ubuntu installer of Dolibarr from sourceforge.net, and then
# prepares the .deb file for installation. Note that you specify the version of Dolibarr you want to
# download, so this script should continue to work for indefinite future Dolibarr versions as well.
#
# Fixes problems like:
# dpkg-deb: error: archive ‘dolibarr_X.X.X-4_all.deb’ uses unknown compression for member
# dpkg: error processing archive dolibarr_X.X.X-4_all.deb
# Errors were encountered while processing: dolibarr_X.X.X-4_all.deb
#
# Last Tested Dolibarr Version: 17.0.0
#
# The installer fix performed by this script is based on the following forum thread:
# https://www.dolibarr.org/forum/t/unable-to-install-dolibarr-15-0-2-4-all-deb-on-debian-11-bullseye/22355/6
#
# The script installs zstd and binutils if not already installed, which are required to make the
# downloaded .deb file installable on Debian.
##

clear;

echo 'Welcome! We are going to download Dolibarr today in your current working directory.';
echo;

echo 'What Dolibarr version do you want to install? (Must be in format x.x.x, such as 14.0.4)';
echo 'Or press Q if you want to quit.';
echo;

read choice;
echo;

case "$choice" in
    [Q|q])
        exit 0;
        ;;
    *)
        dolibarrVersion="$choice";
        ;;
esac

# Install Required Packages
echo 'We may need to install two more packages on your computer. Checking that now.';
echo;

sudo apt install zstd binutils -y;

# Download Dolibarr
echo;
echo "Downloading Dolibbar version ${dolibarrVersion}."
echo;

wget "https://sourceforge.net/projects/dolibarr/files/Dolibarr%20installer%20for%20Debian-Ubuntu%20%28DoliDeb%29/${dolibarrVersion}/dolibarr_${dolibarrVersion}-4_all.deb/download"
mv 'download' "dolibarr_${dolibarrVersion}-4_all.deb";

# Prepare Dolibarr .deb Package for Installation
echo;
echo 'Fixing the Dolibarr .deb file downloaded so it can be installed on Debian.';
echo;

ar x "dolibarr_${dolibarrVersion}-4_all.deb";
unzstd control.tar.zst;
unzstd data.tar.zst;
xz control.tar;
xz data.tar;
rm "dolibarr_${dolibarrVersion}-4_all.deb";
ar cr "dolibarr_${dolibarrVersion}-4_all.deb" debian-binary control.tar.xz data.tar.xz;
rm debian-binary control.tar.xz control.tar.zst data.tar.xz data.tar.zst;

# Finish
echo;
echo 'Everything is complete!';
echo 'To install Dolibarr, use the following command:';
echo "sudo apt install ./dolibarr_${dolibarrVersion}-4_all.deb"
echo "If you currently have a previous version of Dolibarr installed, don't forget to backup your Dolibarr files and database before running the installation!";
