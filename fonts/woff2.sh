#!/bin/sh

echo 'We will convert a font file to WOFF2';
echo 'This little scrips uses the woff-tools package in Linux';
echo;

sfnt2woff=$(which sfnt2woff);

if [ ! -f "$sfnt2woff" ]
then

    echo 'sfnt2woff cannot be found. Would you like to install it?';
    echo 'Y = yes; N = no';
    echo;

    read -r choice;
    echo;

    if [ "$choice" = "Y" ] || [ "$choice" = "y" ];
    then

        sudo apt install woff-tools;
    fi
fi

echo 'Enter the location of the font file to convert,';
echo 'and a WOFF2 file will be created in that same directory.';
echo;

read -r file
echo;

sfnt2woff -v 2.0 "$file";
