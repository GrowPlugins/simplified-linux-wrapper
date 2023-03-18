#!/bin/sh

echo 'Welcome to the "snippets" menu!';
echo 'All snippets that can be run through this menu can be found in the "snippets"'\
    'folder and run directly. This menu is only provided for convenience.';
echo;

echo 'Which script (snippet) do you want to use?';
echo;

echo '1. dolibarr-deb-download';
echo '2. zerotier-manager';
echo;

read choice;
echo;

case "$choice" in
    "1")
        clear;
        cd dolibarr;
        sh ./dolibarr-deb-download.sh;
        cd ..;
        ;;
    "2")
        clear;
        cd zerotier;
        sh ./zerotier-manager.sh;
        cd ..;
        ;;
    *)
        echo 'That is not an option.';
        ;;
esac

echo;
echo 'Exiting snippets menu.';
exit 0;