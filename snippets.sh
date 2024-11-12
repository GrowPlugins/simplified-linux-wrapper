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

        read choice;
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
                    # Determine Selected Script Path
                    path=$(grep -i "$choice " ./snippets-list.txt | sed s/"^[0-9]* - [a-zA-Z0-9\_\ \-]* ("/''/g);
                    path=$(echo "$path" | sed s/")$"/''/g);

                    # Execute Selected Script
                    sh "$path";

                    # Clear Screen After Script Exits
                    clear;
    
                    script_title;
                    ;;

                # Otherwise Assume Search, Return Scripts That Match Search
                *)
                    echo 'ID - Snippet';
                    echo '----------------------';

                    value=$(grep -i "$choice" ./snippets-list.txt | sed s/"[a-zA-Z0-9\/\(\)\.\-]*.sh)$"/''/g;);

                    if [ "$value" != "" ]
                    then
                        echo "$value";
                        echo;
                    else
                        echo 'Nothing seems to match that search.';
                        echo;
                    fi

                    wait_for_input;
                    ;;

            esac;

        else

                echo 'These are all the snippets available.';
                echo;

                cat ./snippets-list.txt | sed s/" - [a-zA-Z0-9\-]*\.sh$"/''/g;
                echo;

                wait_for_input;
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

wait_for_input(){

    echo 'Press Enter to continue.';
    echo;
    
    read -r choice;
}

snippet_usage_message() {

    echo "When you know what snippet you want to use, enter the snippet's ID";
}

main;