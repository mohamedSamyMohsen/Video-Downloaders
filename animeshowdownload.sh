#! /bin/bash

while [ "$1" != "" ]
do
    case $1 in
        -d | --output-directory )           shift
                                            outputdir="$1"
                                            ;;
        -*)                                 echo "Invalid option $1"
                                            exit
                                            ;;
        * )                                 episodelink=$1

    esac
    shift
done

[[ -z "$episodelink" ]] && echo "Please Enter the link in the correct format: http://www.animeshow.tv/anime-name-episode-number-mirror-number/" && read link

echo "Getting video link..."

videolink=`curl -s "$episodelink" | awk -F 'id="embbed-video"' '{print $2}' | awk -F 'SRC="' '{print $2}' | awk -F '"' '{print $1}' | tr -d '\n'`

[[ -z "$outputdir" ]] && ./downloadMP4upload.sh "$videolink" && exit

./downloadMP4upload.sh "$videolink" -d "$outputdir"
