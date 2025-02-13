#!/bin/sh

#. ../includes/classic_sh/users_and_authentication.sh;
#. ../includes/classic_sh/system_info.sh;
. ../includes/classic_sh/init_required.sh;

main() {

    # install_rkhunter;

    clear;

    echo 'This little script will scan your system for viruses and rootkits.';
    echo 'Press Enter to continue, or Q and then Enter to quit.';
    echo;

    read -r choice;

    if [ "$choice" = 'q' ] || [ "$choice" = 'Q' ]
    then
        exit;
    fi

    clear;

    echo '====================';
    echo 'Scanning your whole computer for viruses. This might take a while.';
    echo;
    echo 'Nothing will appear until the scan is complete.';
    echo '====================';
    echo;

    clamscan --detect-pua=yes -ir /;

    echo '====================';
    echo 'Virus scan complete.';
    echo;
    echo 'Checking your computer for rootkits. This might take a while.';
    echo;
    echo 'Nothing will appear until the scan is complete.';
    echo '====================';
    echo;

    rkhunter --check --pkgmgr DPKG --skip-keypress;

    echo 'Virus and rootkit scans complete. If you are done looking over the results, you can close this window.';
}

install_rkhunter () {

    ##
    # Definitions
    ##
    local rkhunter_installed;

    sanitize_input 'ip addr; ip address' 'no programs';

    rkhunter_installed=$(is_package_installed 'rkhunter');

    #if [ "$rkhunter_installed" != '1' ]
    #then
        
    #    superuser
    #fi

    #grep 'DPKG' /etc/rkhunter.conf.local
    #superuser "echo 'PKGMGR=DPKG' >> /etc/rkhunter.conf.local";
}

install_rkhunter;