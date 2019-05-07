#;/bin/bash
#lma
#nblma
log_path="/srv/log/deva/caseg2/*/application"
#k
#sadasd

#zmena3
#tg2
display_usage() {
echo "Usage: $0"
echo "-h, --help        Help"
echo "-f, --file        Search in file name"
echo "-t, --time        Time e.g. 16:14:32"
echo "-d, --date        Date e.g. 2019-04-16"
echo "-s, --string      Search string e.g. cen55321, can be used mutliple"
echo "-e, --error       Print only ERROR WARN Exception logs"

}

if [ $# -eq 0 ]
  then
    display_usage
    exit 0
fi

filename="*"
date_event="*"

while getopts hf:t:d:s:e option
do
case "${option}"
in
h) display_usage
   exit 0;;
f) filename="${OPTARG}";;
t) time_event="$time_event -e ${OPTARG}";;
d) date_event=$OPTARG;;
s) string="$string -e ${OPTARG}";;
e) grep_error="| grep -e \" ERROR \" -e \" WARN \" -e \"Exception\" -e \"Caused by\" -e \"errors\"";;
#event=${OPTARG};;

esac
done
if [ ! -z "$time_event" ]
then
      grep_time="| zgrep -i $time_event"
fi

if [ ! -z "$string" ]
then
grep_string="zgrep -i $string"
fi


#grep_string="zgrep -i$string"

#echo "$grep_string"

#shift $((OPTIND -1))

echo $grep_string
echo $grep_time
#echo "$filename $date_event $time_event $string"
log_files="$log_path/*$filename*$date_event*.log"
echo "Search in $log_files"

sleep 3

#log_files_list=`find $log_path/*$filename*$date_event*.log -type f -print0 | xargs -0`
#echo $log_files_list

#find $log_path/*$filename*$date_event*.log -type f -print0 | xargs -0 zgrep -i -e "INFO" 
#
find $log_path/*$filename*$date_event*.log -type f -print0 | xargs -0 $grep_string $grep_time #| grep -v -e "Client verification is disabled" -e "Unsupported protokol (ldap)" -e "Failed to load CRL" -e "FTA_XML_SIGNATURE_BUILDER HSM does not contain valid key" $grep_error

#find $log_path/*$filename*$date_event*.* -type f -print0 | xargs -0 zgrep  -i -e "jtosovska@csas.cz" -e "cen85233" | grep -v -e "Client verification is disabled" -e "Unsupported protokol (ldap)" -e "Failed to load CRL" -e "FTA_XML_SIGNATURE_BUILDER HSM does not contain valid key" | grep -e " ERROR " -e " WARN " -e "Exception" -e "Caused by" -e "errors"



