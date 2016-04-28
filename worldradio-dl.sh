#!/bin/bash
#
# USAGE
#
#   $ nhkworldradio-dl.sh [-play]
#

#
# XXXDIR must be followed by '/'
#
if [ -z "$TRGDIR" ]; then
    TRGDIR=./
fi


#
# path to xml
#
XML=http://www.nhk.or.jp/rj/podcast/rss/english.xml


# select a program
url=`wget -q -O- $XML | grep 'url.*mp3' | sed 's/.*\(http:.*mp3\).*/\1/'`
name=$TRGDIR`basename $url`


# download
if [ -n "$url" ]; then
    wget $url -c -O $name
    chmod 644 $name
fi

# play it
if [ "-play" = "$1" ]; then
    mplayer $name
fi
