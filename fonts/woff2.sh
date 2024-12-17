#!/bin/sh

echo 'We will convert a font file to WOFF2';
echo 'This little scrips uses the woff-tools package in Linux';
echo 'If you do not have woff-tools installed, it will not work.';
echo '';

echo 'Enter the location of the font file to convert,';
echo 'and a WOFF2 file will be created in that same directory.';
echo'';

read -r file

sfnt2woff "$file";
