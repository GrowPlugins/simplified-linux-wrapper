#!/bin/sh

. ../includes/classic_sh/platform_processes.sh;

main() {

    echo 'This is a Debian/Ubuntu PHP module installer for WordPress servers.';
    echo 'Use this script to help insure you never forget an important WordPress requirement.';
    echo;

    echo 'Which version of PHP do you want to install WordPress requirements for? (Q to quit.)';
    echo;

    read choice;
    echo;

    case "$choice" in
        [Qq])
            echo 'Exit';
            exit 0;
            ;;
        *)
            phpVersion="$choice";
            ;;
    esac

    echo 'And what do you want to do today?';
    echo;

    echo '1. Install Any Missing PHP Modules for WordPress.';
    echo '2. View List of PHP Modules for WordPress.';

    read choice;
    echo;

    case "$choice" in
        '1')
            ;;
        '2')
            printPHPModules core;
            ;;
        [Qq])
            echo 'Exit';
            exit 0;
            ;;
        *)
            phpVersion="$choice";
            ;;
    esac
}

printPHPModules() {

    case "$1" in
        'core')
            getWPImperativePHPModulesList;
            ;;
        *)
            phpVersion="$choice";
            ;;
    esac

    for i in $phpModuleList
    do
        echo "php${phpVersion}-${i}";
        #apt search "php${phpVersion}-${i}";
    done
}

getWPImperativePHPModulesList() {

    phpModuleList='common curl dom exif imagick cgi mysql xml mbstring';
}

getWPImportantPHPModulesList() {

    phpModuleList='bcmath intl';
}

main;

#superuser 'zerotier-cli listnetworks'; apt install php8.2-mbstring php8.2-soap




#gd

#intl



#zip