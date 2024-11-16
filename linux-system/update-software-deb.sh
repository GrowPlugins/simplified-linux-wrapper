#!/bin/bash

. ../includes/classic_sh/platform_processes.sh;

main() {

    clear;

    echo 'This program will update your Debian/Ubuntu system and programs with the latest software.';
    echo;

    getUpdates;
    getUpgrades;

    endProgramWithKeyPress;
}

getUpdates() {

    echo "--Checking the software repository for changes since last update.";
    echo;

    echo "Please enter your password. If you don't have administrative privileges, ";
    echo "you won't be able to update your system.";
    echo;

    superuser 'apt-get update -q';
    echo;
}

getUpgrades() {

    echo "--Updating software as needed.";
    echo;

    superuser 'apt-get upgrade -yq';
    echo;

    if [ -f $(which flatpak) ]
    then

        flatpak update -y;
        echo;
    fi

    if [ -f $(which snap) ]
    then

        superuser 'snap refresh';
        echo;
    fi

    echo '=========================';
    echo 'Your software is now up to date.';
    echo '=========================';
}

endProgramWithKeyPress() {

    echo 'Press Enter key to quit.';
    echo;

    read enter;

    clear;
}

main
