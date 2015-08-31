#!/bin/sh

if [ $# -ne 1 ]; then
 echo "Stopped Script: args target [e.g. JP,CN,IN(format of ISO3166-1)]" 1>&2
 exit 1
fi

TIME_STAMP=`date +%s`
CRNT_PATH=$(cd $(dirname $0); pwd)
TMP="$CRNT_PATH/tmp"
OUT="$CRNT_PATH/out"
OUT_FILE_LIMIT=5

# rm -rf $TMP
mkdir $TMP $OUT

cd $TMP
# curl -O ftp://ftp.apnic.net/pub/apnic/stats/apnic/delegated-apnic-latest
curl -O ftp://ftp.apnic.net/pub/stats/apnic/delegated-apnic-extended-latest
# perl $CRNT_PATH/countryfilter.pl text KR,CN,KP < delegated-apnic-extended-latest > filter.sh
perl $CRNT_PATH/countryfilter.pl text $1 < delegated-apnic-extended-latest > filter.sh
$CRNT_PATH/cut.sh filter.sh out_$TIME_STAMP.txt

cd $CRNT_PATH
mv $TMP/out_$TIME_STAMP.txt $OUT/

cd $OUT
while true
do
 if [ `ls | wc -l` -gt $OUT_FILE_LIMIT ]; then
  fileOldest=`ls | sort -r | tail -n 1`
  rm $fileOldest
 else
	break
 fi
done

cd $CURNT_PATH

echo ""
echo "output -> $OUT/out_$TIME_STAMP.txt"
echo ""




