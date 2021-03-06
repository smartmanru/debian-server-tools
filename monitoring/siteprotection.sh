#!/bin/bash
#
# List /home dynamic web files modified in the last hour.
#
# VERSION       :0.4.1
# DATE          :2017-06-22
# IDEA          :https://www.maxer.hu/siteprotection.html
# AUTHOR        :Viktor Szépe <viktor@szepe.net>
# LICENSE       :The MIT License (MIT)
# URL           :https://github.com/szepeviktor/debian-server-tools
# BASH-VERSION  :4.2+
# LOCATION      :/usr/local/sbin/siteprotection.sh
# CRON.D        :00 *	* * *	root	/usr/local/sbin/siteprotection.sh

#   Exclude WordPress cache
#   Exclude Laravel view cache
find /home/ -type f "(" -iname "*.php" -or -iname ".htaccess" -or -iname ".env" ")" \
    "(" -cmin -61 -or -mmin -61 ")" -printf '%p @%TH:%TM:%TS\n' \
    | grep -v -x '/home/[[:alnum:]]\+/website/html/wp-content/cache/\S\+\.php @[0-9:.]\+' \
    | grep -v -x '/home/[[:alnum:]]\+/website/html/wp-content/focus-object-cache/[a-z_-]\+/\S\+\.php @[0-9:.]\+' \
    | grep -v -x '/home/[[:alnum:]]\+/website/html/storage/framework/views/[0-9a-z]\{40\}\.php @[0-9:.]\+' \

exit 0
