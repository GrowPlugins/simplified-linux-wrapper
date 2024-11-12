#!/bin/sh

. ../includes/classic_sh/platform_processes.sh;

main_menu()
{
    ##
    # Local Variables
    ##
    local __continue_program=1;

    clear;

    echo 'ZeroTier Simple Manager';
    echo;
    echo 'Please Note: This program requires super user' \
        'privileges and will ask you for a super user password.';
    echo '===========================================';
    echo;

    while [ "$__continue_program" -eq "1" ]
    do
        echo '-- Main Menu --';
        echo;
        echo 'Please select one of these options:';
        echo '1. Connect to ZeroTier';
        echo '2. Disconnect from ZeroTier';
        echo '3. Set/Change ZeroTier Connection';
        echo '4. Close Program';
        echo;

        read choice;
        echo;

        case "$choice" in
            [1])
                connect;

                echo;
                ;;
            [2])
                disconnect;

                echo;
                ;;
            [3])
                change_connection;

                echo;
                ;;
            *)
                # Close Program
                __continue_program=0;
                ;;
        esac
    done

    echo;
    echo 'Program Closed';

    exit 0;
}

connect()
{
    if [ ! "$(superuser 'systemctl enable --now zerotier-one')" ]
    then
        echo;
        echo 'Successfully connected to ZeroTier!';
    else
        echo;
        echo 'Something went wrong....';
    fi
}

disconnect()
{
    if [ ! "$(superuser 'systemctl disable --now zerotier-one')" ]
    then
        echo;
        echo 'Successfully disconnected from ZeroTier!';
    else
        echo;
        echo 'Something went wrong....';
    fi
}

change_connection()
{
    echo 'Here are the networks you are connected to:';
    echo;
    superuser 'zerotier-cli listnetworks';
    echo;

    echo 'What do you want to do?';

    echo '1. Add Connection';
    echo '2. Remove Connection';
    echo '3. Go Back';
    echo;

    read choice;
    echo;

    case "$choice" in
        [1])
            add_zt_connection;
            echo;
            ;;
        [2])
            leave_zt_connection;
            echo;
            ;;
        *)
            echo ''
            echo 'Going back to the previous menu.'
            ;;
    esac
}

add_zt_connection()
{
    echo 'Type the network ID you want to join, or Q to quit.';
    echo;

    read choice;
    echo;

    case "$choice" in
        [Qq])
            return;
            ;;
        [a-zA-Z0-9]*)
            echo "Joining $choice";
            superuser "zerotier-cli join $choice";
            echo;
            echo 'You are now connected to these networks:';
            echo;
            superuser 'zerotier-cli listnetworks';
            ;;
        *)
            echo ''
            echo 'Invalid input. Going back to the previous menu.'
            ;;
    esac
}

leave_zt_connection()
{
    echo 'Type the network ID you want to leave, or Q to quit.';
    echo;

    read choice;
    echo;

    case "$choice" in
        [Qq])
            return;
            ;;
        [a-zA-Z0-9]*)
            echo "Leaving $choice";
            superuser "zerotier-cli leave $choice";
            echo;
            echo 'You are now connected to these networks:';
            echo;
            superuser 'zerotier-cli listnetworks';
            ;;
        *)
            echo ''
            echo 'Invalid input. Going back to the previous menu.'
            ;;
    esac
}

main_menu;