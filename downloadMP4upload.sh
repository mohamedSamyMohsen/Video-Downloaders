#! /bin/bash

while [ "$1" != "" ]
do
    case $1 in
        -d | --output-directory )           shift
                                	    opt="-P$1"
                          	            ;;
	-*)				    echo "Invalid option $1"
					    exit
					    ;;
        * )                     	    link=$1

    esac
    shift
done

[[ -z "$link" ]] && echo "Please Enter the link in the correct format: http://www.mp4upload.com/anytext.html" && read link
echo "Getting download link..."
newlink=`curl -s "$link" | awk -F 'file' '{print$2}' | tr -d ',' | tr -d "'" | tr -d '\n' | awk -F ': ' '{print $2}'`
[[ -z "$newlink" ]] && echo "Broken link or no connection. Please enter the link in the correct format: http://www.mp4upload.com/anytext.html and make sure that the video exists." && exit 255
wget "$opt" "$newlink"
echo "Done."
