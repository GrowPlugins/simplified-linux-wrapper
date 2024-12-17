#~/bin/sh

##
# Definitions
##
response='';

echo 'First we will check to see who is logged in.';

w;

echo 'Do you recognize any users that should not be logged in? (Y/N)';

read -r response;

if [ "$response" = 'y' ] || [ "$response" = 'Y' ]
then

    echo 'What is the name of the account that should not be logged in?';

    read -r response;

    echo "Do you want to log the user $response out now? (Y/N)";

    read -r response;

    if [ "$response" = 'y' ] || [ "$response" = 'Y' ]
    then


    fi
fi

echo 'Securely check if your emails on the darkweb at: https://haveibeenpwned.com/';

echo 'Securely check if your password is on the darkweb at: https://haveibeenpwned.com/Passwords';