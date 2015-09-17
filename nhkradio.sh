#!/bin/bash
#

#
# https://gist.github.com/riocampos/5656450
#
#   JOAK Tokyo
#   JOBK Osaka
#   JOCK Nagoya
#
declare -A chs
chs["JOAK R1"]="rtmpe://netradio-r1-flash.nhk.jp NetRadio_R1_flash@63346"
chs["JOAK R2"]="rtmpe://netradio-r2-flash.nhk.jp NetRadio_R2_flash@63342"
chs["JOAK FM"]="rtmpe://netradio-fm-flash.nhk.jp NetRadio_FM_flash@63343"
chs["JOBK R1"]="rtmpe://netradio-bkr1-flash.nhk.jp NetRadio_BKR1_flash@108232"
chs["JOBK FM"]="rtmpe://netradio-bkfm-flash.nhk.jp NetRadio_BKFM_flash@108233"
chs["JOCK R1"]="rtmpe://netradio-ckr1-flash.nhk.jp NetRadio_CKR1_flash@108234"
chs["JOCK FM"]="rtmpe://netradio-ckfm-flash.nhk.jp NetRadio_CKFM_flash@108235"


sortedstations=`for a in "${!chs[@]}"; do echo "$a"; done | sort`

SWF="http://www3.nhk.or.jp/netradio/files/swf/rtmpe.swf"
APP="live"


IFS=$'\n'
select ch in "quit" $sortedstations; do
    #echo $ch;

    if [ -z "$ch" ]; then
	continue
    fi
    
    if [ "$ch" = "quit" ]; then
	exit
    fi
	
    url=`echo ${chs[$ch]} | awk '{print $1}'`
    pth=`echo ${chs[$ch]} | awk '{print $2}'`
    rtmpdump --rtmp $url --playpath $pth --app $APP --swfVfy $SWF --live -o - \
	| mplayer -
done
