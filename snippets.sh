#!/bin/sh

main() {
    program_continue=1;

    clear;
    
    script_title;
    introduction_message;

    while [ $program_continue -eq 1 ];
    do

        echo '-- Instructions -------';
        echo 'Type any part of a snippet name and press Enter to search for it.';
        echo 'Enter ALL to see all available snippets.';
        echo;
        snippet_usage_message;
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
                    full_path=$(grep -i "^${choice} \-" ./snippets-list.txt | sed s/"^[0-9]* - [a-zA-Z0-9\,\;\:\?\!\.\ \_\-]* ("/''/g | sed s/")$"/''/g);

                    path=$(echo "$full_path" | sed s/"\/[a-zA-Z0-9\,\;\:\?\!\.\ \_\-]*.sh$"/''/g);

                    snippet=$(echo "$full_path" | sed s/"^\.\/[a-zA-Z0-9\,\;\:\?\!\.\ \_\-]*\/"/''/g);

                    # Change to Snippet Directory to Allow Snippet-Level Includes
                    cd "$path" || exit;

                    # Execute Selected Script
                    sh "./${snippet}";

                    # Go Back to Main Directory
                    cd "$main_directory" || exit;

                    # Clear Screen After Script Exits
                    clear;
    
                    script_title;
                    ;;

                # Otherwise Assume Search, Return Scripts That Match Search
                *)
                    echo 'ID - Snippet';
                    echo '----------------------';

                    # Return Snippets Based on Input
                    value=$(grep -i "\- [a-zA-Z\_\-]*${choice}[a-zA-Z\_\-]* \-" ./snippets-list.txt | sed s/"[a-zA-Z0-9\/\(\)\.\-]*.sh)$"/''/g;);

                    if [ "$value" != "" ]
                    then
                        echo "$value";
                        echo;
                    else
                        echo 'Nothing seems to match that search.';
                        echo;
                    fi

                    sleep 2;
                    ;;

            esac;

        else

                echo 'These are all the snippets available.';
                echo;

                sed s/"[a-zA-Z0-9\/\(\)\.\-]*.sh)$"/''/g < ./snippets-list.txt;
                echo;

                sleep 2;
        fi;

    done;
}

script_title() {

    echo '====================';
    echo 'The "snippets" Menu';
    echo '====================';
}

introduction_message(){
    
    echo 'All snippets that can be run through this menu can be found in the "snippets"'\
        'folder and run directly.';
    echo 'This menu is only provided for convenience.';
    echo;
}

snippet_usage_message() {

    echo "When you know what snippet you want to use, enter the snippet's ID";
}

main;