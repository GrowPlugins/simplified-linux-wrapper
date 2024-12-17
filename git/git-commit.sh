#!/bin/sh

initialMenu() {

    input=''

    clear
    echo 'Welcome to your handy git push/pull tool.'

    while [ 1 ]
    do
        echo ''
        echo 'What would you like to do?'
        echo '[R]epository Update (1)'
        echo '[A]ll Repositories Update'
        echo '[U]pdate list of Repositories'
        echo '[Q]uit'

        read input

        case "$input" in
            [Rr])
                clear
                updateOneRepository
                ;;
            [Aa])
                clear
                echo 'This option is not finished yet'
                ;;
            [Uu])
                repositoriesList
                ;;
            [Qq])
                exit
                ;;
            *)
                echo ''
                echo 'Sorry, that is not an option.'
                ;;
        esac
    done
}

repositoriesList() {

    input=''

    while [ 1 ]
    do
        clear

        if [ -f "git_repositories.txt" ]
        then
            echo 'Here is a list of all your saved repositories.'
            cat git_repositories.txt
            echo ''
        fi

        echo 'What would you like to do?'
        echo '[A]dd a repository'
        echo '[R]emove a repository'
        echo '[B]ack to main menu'

        read input

        case "$input" in
            [Aa])
                echo ''
                getNewRepositoryLocation
                ;;
            [Rr])
                if [ ! -f "git_repositories.txt" ]
                then
                    echo 'There are no repositories to remove.'
                else
                    echo ''
                    removeRepositoryLocation
                fi
                ;;
            [Bb])
                clear
                break
                ;;
        esac
    done
}

getNewRepositoryLocation() {

    input=''

    while [ 1 ]
    do
        echo 'Please enter the location of your git repository you want to commit. (or Q to quit)'

        read input

        if [ -f "$input/.git/config" -o "$input" = 'Q' -o "$input" = 'q' ]
        then
            break
        fi
    done

    if [ -f "$input/.git/config" ]
    then
        echo "That looks right. Okay, we will save that repository location."
        echo ''

        sleep 1

        echo "$input" >> git_repositories.txt
    fi
}

removeRepositoryLocation() {

    input=''
    selectionLine=0

    while [ 1 ]
    do
        echo 'Please enter the git repository location you want to remove. (or Q to quit)'
        echo ''

        echo 'Your options are:'

        cat git_repositories.txt

        read input

        if [ -f "$input/.git/config" -o "$input" = 'Q' -o "$input" = 'q' ]
        then
            break
        fi
    done

    if [ -f "$input/.git/config" ]
    then
        echo "That looks right. That repository location will now be removed."
        echo ''

        sleep 1

        selectionLine=`cat git_repositories.txt | grep -n "$input" | grep -o "[0-9]*"`

        cat git_repositories.txt | sed -n "$selectionLine"d > git_repositories.txt
    fi
}

updateOneRepository() {

    input=''
    oldWorkingDirectory=`pwd`
    gitFolder=''
    gitStatus=''
    dateNow=`date +%D`
    tempOutput=''

    while [ 1 ]
    do
        echo 'Please enter the git repository location you want to update. (or Q to quit)'
        echo ''

        echo 'Your options are:'

        cat git_repositories.txt

        read input

        if [ -f "$input/.git/config" -o "$input" = 'Q' -o "$input" = 'q' ]
        then
            break
        fi
    done

    if [ -f "$input/.git/config" ]
    then
        echo "That looks right. That repository will be updated and used to update the origin repository."
        echo ''

        sleep 1

        # Change Working Directory
        cd "$input"

        # Get Folder to Track
        while [ 1 ]
        do
            echo 'Please enter the folder within your repository that might have '
            echo 'new files you want to track. (Q to quit)'

            echo ''

            read gitFolder

            echo ''

            if [ "$gitFolder" = 'Q' -o "$gitFolder" = 'q' ]
            then
                cd "$oldWorkingDirectory"
                clear
                return
            else
                tempOutput=`ls ./$gitFolder`

                if [ "$tempOutput" != "" ]
                then
                    break
                fi
            fi

            echo ''
        done

        clear
        echo 'Okay, everything looks good.'

        sleep 1

        # Pull Updates from Origin
        echo 'Pulling updates from origin to selected repository.'
        echo 'Pull Results:' `git pull`
        echo ''

        # Push Changes if Any
        while [ 1 ]
        do
            gitStatus=`git status`

            case "$gitStatus" in
                *'Your branch is ahead'*)
                    echo 'Your repository branch is ahead of the origin branch.'
                    echo 'Pushing changes now.'

                    tempOutput=`git push origin master`

                    echo "$tempOutput"
                    ;;
                *'Untracked files:'*"$gitFolder/"*)
                    echo 'There are new files in your watched folder.'
                    echo 'Adding new files to be committed now.'
                    echo ''

                    git add "$gitFolder"
                    echo ''
                    ;;
                *'Changes to be committed'*)
                    echo 'There are changes to commit.'
                    echo 'Committing changes now.'
                    echo ''

                    git commit -am "$dateNow"
                    echo ''
                    ;;
                *'Changes not staged for commit'*)
                    echo 'There are changes to commit.'
                    echo 'Committing changes now.'
                    echo ''

                    git commit -am "$dateNow"
                    echo ''
                    ;;
                *'Your branch is up to date'*)
                    echo 'The repository is up to date.'
                    break
                    ;;
                *)
                    echo 'Hmm. Something went wrong.'
                    break
                    ;;
            esac
        done

        echo ''
        echo 'Press any key to continue'

        read input

        cd "$oldWorkingDirectory"
    fi

    clear
}

initialMenu
