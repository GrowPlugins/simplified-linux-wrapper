#!/bin/sh

main() {

    continue=1;
    menuOption='';

    while [ $continue = 1 ]
    do

        clear;

        echo 'This program helps you to work with a salt stack faster.';
        echo '';

        echo '1. Install Salt';
        echo 'Press Q to quit';
        echo;

        read -r menuOption;
        echo;

        case "$menuOption" in

            '1')
                install_salt;
                ;;
            [qQ])
                echo 'Exiting program.';
                echo;

                continue=0;
                ;;
            *)
                clear;
                echo 'Invalid option provided. Please try again.';
                echo;
                ;;
        esac
    done
}

install_salt() {

    saltType='';
    saltVersion='';

    echo 'Which version of salt are you installing right now?';
    echo;

    echo '1. master';
    echo '2. minion';
    echo;

    read -r saltType;
    echo;

    case "$saltType" in

        1|'master')
            saltVersion='master';
            ;;
        2|'minion')
            saltVersion='minion';
            ;;
        *)
            echo 'Error, invalid salt installation version provided.';
            echo;

            return;
            ;;
    esac

    # Ensure keyrings dir exists
    mkdir -p /etc/apt/keyrings;
    # Download public key
    curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp;
    # Create apt repo target configuration
    curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources;

    echo 'Package: salt-*
    Pin: version 3006.*
    Pin-Priority: 1001' | sudo tee /etc/apt/preferences.d/salt-pin-1001;

    # Install Salt Version
    sudo apt install "salt-${saltVersion}";

    sudo systemctl enable "salt-${saltVersion}" && sudo systemctl start "salt-${saltVersion}";
}

main;
