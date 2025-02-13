#!/bin/sh

# Source: https://ounapuu.ee/posts/2024/09/02/iphone-media-recovery/

#sudo apt install -y ifuse libimobiledevice libimobiledevice-utils

#echo 'Provide a directory where you want your iPhone files to be mounted temporarily.';
#echo;

#idevicepair pair && idevicepair validate;

#mkdir ~/xxx

#ifuse ~/xxx;

##
# Includes
##
# Include 
if [ "$common_dir" = '' ]
then
    common_dir='simplified-linux-wrapper';
fi

. "$(echo $(echo $(pwd) | sed -e s/"${common_dir}.*"/"${common_dir}"/))/includes/classic_sh/init_required.sh";

include 'includes/classic_sh/package_management.sh' 'simplified-linux-wrapper';

main() {

    ##
    # Local Variables
    ##
    local __continue_program=1;

    clear;

    echo 'This program mounts your iPhone to your computer so you can access photos, documents, and other storage.';
    echo 'What do you want to do?';

    install_ddev;

    while [ "$__continue_program" -eq "1" ]
    do
        echo '-- Main Menu --';
        echo;
        echo 'Please select one of these options:';
        echo '--------------------';
        echo;
        echo 'start - Start a DDEV WordPress Site';
        echo 'stop - Stop a DDEV WordPress Site';
        echo 'snapshot-create - Create a Snapshot of a DDEV WordPress Site';
        echo 'snapshot-restore - Restore a Snapshot of a DDEV WordPress Site'
        echo 'export-database - Export a DDEV WordPress Site database'
        echo 'create - Create a New DDEV WordPress Site';
        echo 'delete - Delete an Existing DDEV WordPress Site';
        echo 'duplicate - Duplicate an Existing DDEV WordPress Site';
        echo 'Exit'
        echo;

        read -r choice;
        echo;

        case "$choice" in
            [sS]tart)
                start;

                echo;
                ;;
            [sS]top)
                stop;

                echo;
                ;;
            [sS]napshot-create)
                new_snapshot;

                echo;
                ;;
            [sS]napshot-restore)
                restore_snapshot;

                echo;
                ;;
            [eE]xport-database)
                export_database;

                echo;
                ;;
            [cC]reate)
                create;

                echo;
                ;;
            [dD]elete)
                delete;

                echo;
                ;;
            [dD]uplicate)
                duplicate;

                echo;
                ;;
            [eE]xit)
                # Close Program
                __continue_program=0;

                ddev poweroff;
                ;;
            *)
                echo 'Menu selection not recognized. Please try again.';

                echo;
                ;;
        esac
    done

    echo;
    echo 'Program Closed';

    exit 0;
}

install_dependencies() {

    ddev_path=$(which ddev);

    if [ ! -f "$ddev_path" ]
    then

        echo 'DDEV cannot be found. Would you like to install it?';
        echo 'Y = yes; N = no';
        echo;

        read -r choice;

        if [ "$choice" = "Y" ] || [ "$choice" = "y" ];
        then

            # Download and run the install script
            curl -fsSL https://ddev.com/install.sh | bash
        fi
    fi
}

