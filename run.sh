#! /usr/bin/bash

# Getting the file name as the first argument
filename=$1

echo $2

# Checkig if the user wants to remove the files generted during compilation
if [[ ${2}!="remove" ]];
then
    delete=0
    echo $2!="remove"
else
    delete=1
    echo "$2"
    echo yes padded remove flag
fi

echo $delete
# Getting the name and extension from the filename
base=${filename%.*}
ext=${filename#$base.}

case $ext in
    "py")
        python3 $filename
    ;;

    "c")
        gcc $filename -o $base
        ./$base
        if [ $delete -eq 1 ]; then
            echo hi
            rm $base
        fi
    ;;

    "js")
        node $filename
    ;;

    "ts")
        tsc $filename
        node "$base.js"
        if [ $delete  -eq 1 ]; then
            rm "$base.js"
        fi
    ;;

    "sh")
        bash "$filename"
    ;;

    *)
        echo "File extension not supported or invalid!"
    ;;
esac
