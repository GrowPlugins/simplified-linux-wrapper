#!/bin/sh

echo 'Welcome to the "snippets" menu!';
echo 'All snippets that can be run through this menu can be found in the "snippets"'\
    'folder and run directly. This menu is only provided for convenience.';
echo;

echo 'Which script snippet do you want to use?';
echo;

echo '1. dolibarr-deb-download';
echo '2. zerotier-manager';
echo;

read choice;
echo;

case "$choice" in
    "1")
        clear;
        sh ./dolibarr/dolibarr-deb-download.sh;
        ;;
    "2")
        clear;
        sh ./zerotier/zerotier-manager.sh;
        ;;
    *)
        echo 'That is not an option.';
        echo;
        ;;
esac

echo 'Exiting menu.';
exit 0;