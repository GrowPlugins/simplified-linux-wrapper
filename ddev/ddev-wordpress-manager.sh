#!/bin/sh

main() {

    ##
    # Local Variables
    ##
    local __continue_program=1;

    ##
    # Global Variables
    ##
    ddev_directory="$HOME/dev";

    clear;

    echo 'This program is a simple interface for ddev, which is itself an interface for docker.';
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

install_ddev() {

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

start() {

    echo;
    echo 'Here is a list of available projects to start.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to start.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    cd "${ddev_directory}/${project_name}" || exit;
    
    ddev start;

    # Launch WordPress admin dashboard in your browser
    firefox "https://${project_name}.ddev.site/wp-admin/";
}

stop() {

    echo;
    echo 'Here is a list of available projects to stop.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to stop.';
    echo 'Or type ALL to stop all.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    if [ "$project_name" != "ALL" ];
    then
        ddev stop "$project_name";
    else
        ddev stop --all --stop-ssh-agent;
    fi
}

new_snapshot() {

    echo;
    echo 'Here is a list of available projects to take a snapshot of.';
    echo 'A snapshot allows you to go back in time at any point, if you restore the snapshot.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to take a snapshot of.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    cd "${ddev_directory}/${project_name}" || exit;

    echo 'What name do you want to give your new snapshot?';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r snapshot_name;
    echo;

    if [ "$snapshot_name" = "[Q|q]" ];
    then
        return;
    fi

    ddev snapshot --name="${snapshot_name}"
}

restore_snapshot() {

    echo;
    echo 'Here is a list of available projects to restore a snapshot for.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to restore a snapshot for.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    cd "${ddev_directory}/${project_name}" || exit;

    echo "Here are the snapshots for ${project_name}";

    ddev snapshot --list;

    echo 'What snapshot do you want to restore?';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r snapshot_name;
    echo;

    if [ "$snapshot_name" = "[Q|q]" ];
    then
        return;
    fi

    ddev restore-snapshot "${snapshot_name}"
}

export_database() {

    ##
    # Local Variables
    ##
    local __export_directory="${ddev_directory}/.database-exports";

    echo;
    echo 'Here is a list of available projects to export the database for.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to export the database for.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    cd "${ddev_directory}/${project_name}" || exit;

    mkdir "${__export_directory}";

    ddev export-db --file="${__export_directory}/${project_name}-database-$(date +%Y%m%d).sql" --gzip=false;

    echo 'Your database export is here:';
    echo;
    echo "${__export_directory}/${project_name}-database-$(date +%Y%m%d).sql";
}

create() {

    echo;
    echo 'What is the name of the WordPress project?';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi

    if [ ! -d "$HOME/dev" ];
    then
        mkdir "$HOME/dev";
    fi

    mkdir "$HOME/dev/$project_name" || exit;
    cd "$HOME/dev/$project_name" || exit;

    # Create a new DDEV project inside the newly-created folder
    # (Primary URL automatically set to `https://<folder>.ddev.site`)
    ddev config --project-type=wordpress;
    ddev start;

    # Download WordPress
    ddev wp core download;

    # Setup WordPress (we need to use single quotes to get the primary site URL from `.ddev/config.yaml` as variable)
    ddev wp core install --url='$DDEV_PRIMARY_URL' --title="$project_name" --admin_user=admin --admin_email=admin@example.com --prompt=admin_password

    echo;
    echo 'Username is admin';

    # Launch WordPress admin dashboard in your browser
    firefox "https://${project_name}.ddev.site/wp-admin/";
}

delete() {

    echo;
    echo 'Here is a list of available projects to delete.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to delete.';
    echo 'Or type ALL to delete all.';
    echo 'Type Q to quit/cancel.'
    echo;
    
    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi
    
    if [ "$project_name" != "ALL" ];
    then
        ddev delete "$project_name";
        rm -R "${HOME:?}/dev/$project_name";
    else
        ddev delete --all;
        rm -R "${HOME:?}/dev/"*;
    fi
}

duplicate() {

    echo;
    echo 'Here is a list of available projects to duplicate.';
    echo;

    ddev list;

    echo 'Type in the name of the one you want to duplicate';
    echo 'Type Q to quit/cancel.'
    echo;

    read -r project_name;
    echo;

    if [ "$project_name" = "Q" ] || [ "$project_name" = "q" ];
    then
        return;
    fi

    echo 'What name do you want to give your duplicated project?';
    echo 'Type Q to quit/cancel.'
    echo;

    read -r duplicate_name;
    echo;

    if [ "$duplicate_name" = "[Q|q]" ];
    then
        return;
    fi

    cp -r "${ddev_directory}/${project_name}" "${ddev_directory}/${duplicate_name}";

    echo "$(sed "s/^name: [a-zA-Z0-9\_\-\ ]*$/name: ${duplicate_name}/" "${ddev_directory}/${duplicate_name}/.ddev/config.yaml")" > "${ddev_directory}/${duplicate_name}/.ddev/config.yaml";

    cd "${ddev_directory}/${duplicate_name}" || exit;

    ddev config --project-name "$duplicate_name";
}

main;
