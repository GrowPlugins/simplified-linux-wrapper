#!/bin/sh

main() {
    program_continue=1;

    clear;
    
    script_title;
    introduction_message;

    while [ $program_continue -eq 1 ];
    do

        echo '-------- Instructions --------';
        echo 'Type any part of an application you want to run and press Enter to search for it.';
        echo 'Enter ALL to see all available application wrappers.';
        echo;
        menu_usage_message;
        echo;
        echo 'Enter :q to quit.';
        echo;

        read -r choice;
        clear;

        if [ "${choice}" = ':q' ];
        then

            exit;

        fi;

        if [ "${choice}" != 'ALL' ] && [ "${choice}" != 'all' ];
        then

            case "${choice}" in

                # If Numeral Provided, Run Associated Script
                [0-9]*)
                    main_directory=$(pwd);

                    # Determine Selected Script Path
                    full_path=$(grep -i "^${choice} \-" ./wrapper-list.txt | sed s/"^[0-9]* - [a-zA-Z0-9\,\;\:\?\!\.\ \/\_\-]* ("/''/g | sed s/")$"/''/g);

                    path=$(echo "$full_path" | sed s/"\/[a-zA-Z0-9\,\;\:\?\!\.\ \_\-]*.sh$"/''/g);

                    wrapper=$(echo "$full_path" | sed s/"^\.\/[a-zA-Z0-9\,\;\:\?\!\.\ \/\_\-]*\/"/''/g);

                    # Change to Wrapper Directory to Allow Wrapper-Level Includes
                    cd "$path" || exit;

                    # Execute Selected Script
                    sh "./${wrapper}";

                    # Go Back to Main Directory
                    cd "$main_directory" || exit;

                    # Clear Screen After Script Exits
                    clear;
    
                    script_title;
                    ;;

                # Otherwise Assume Search, Return Scripts That Match Search
                *)
                    echo 'ID - Application Wrapper';
                    echo '----------------------';

                    # Return Wrappers Based on Input
                    value=$(grep -i "\- [a-zA-Z\_\-]*${choice}[a-zA-Z\_\-]* \-" ./wrapper-list.txt | sed s/"[a-zA-Z0-9\/\(\)\.\-]*.sh)$"/''/g;);

                    if [ "$value" != "" ]
                    then
                        echo "$value";
                        echo;
                    else
                        echo 'Nothing seems to match that search.';
                        echo;
                    fi

                    display_waiting 3;
                    ;;

            esac;

        else

                echo 'These are all the applications available.';
                echo;

                sed s/"[a-zA-Z0-9\/\(\)\.\-]*.sh)$"/''/g < ./wrapper-list.txt;
                echo;

                display_waiting 3;
        fi;

    done;
}

script_title() {

    echo '====================';
    echo 'Simplified Linux Wrapper Menu';
    echo '====================';
}

introduction_message(){
    
    echo 'All application wrappers that can be run through this menu can be run directly as well.';
    echo 'This menu is only provided for your convenience.';
    echo;
}

menu_usage_message() {

    echo "When you know what application wrapper you want to use, enter the application wrapper's ID";
}

display_waiting() {

    time_to_wait="$1";
    timer=0;

    while [ "$timer" -lt "$time_to_wait" ]
    do
        sleep .5;

        echo '-\c';

        sleep .5;

        echo '-\c';

        timer=$(expr $timer + 1);
    done

    echo;
    echo;
}

main;