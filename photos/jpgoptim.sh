#!/bin/sh

optionsString="";
inputFile="";
outputFile="";
quality="";
answer="";

# Introduction
echo 'This script helps you to compress JPG/JPEG images using a program called jpegoptim.';

echo '';

echo "Would you like to continue? (Type 'q' to quit.)";

read answer;

if [ "$answer" = "q" ]
then
    exit;
fi

# Gather User Options
echo '';

echo 'What is the name of the file you want to optimize? (Include the full path to the file.)';

read inputFile;

if [ ! -f "$inputFile" ]
then

    echo '';
    echo "The file";
    echo "$inputFile";
    echo "does not exist. Exiting script.";
    exit;
fi

echo '';

echo 'What is the percent quality you want, to determine how much to compress the image? (0-100) Leave empty to use lossless compression.';

read quality;

while [ "$outputFile" = "" ]
do

    echo '';

    echo 'What is the name of the file you want to export to? (Include the full path to the file. Type --overwrite to overwrite the original file.)';

    read outputFile;

    if [ "$outputFile" != "" ]
    then

        echo '';

        echo "You put ${outputFile}. Is that Okay? (Type 'yes' or 'y' for yes.)";

        read answer;

        echo '';

        if [ "$answer" = "yes" -o "$answer" = "y" ]
        then

            echo "Okay";
            break;
        else

            echo "Okay, let's try that again, then.";

            outputFile="";
        fi
    fi
done

# Put Together the Options String
if [ "$quality" != "" ]
then

    optionsString="--max=$quality";
fi

if [ "$outputFile" != "--overwrite" ]
then

    optionsString="$optionsString - < '$inputFile' > '$outputFile'";
else

    optionsString="$optionsString '$inputFile'";
fi

echo '';
echo "Compressing the file.";
echo "jpegoptim $optionsString";

eval "jpegoptim $optionsString";
