#!/bin/sh
#nslookup redis | grep -v local.net | grep Name | head -n 1 | awk 'BEGIN{ORS=" "} $1=="Name:" {print $2}' > /tmp/redis-fqdn.txt
#FQDN_REDIS=`cat /tmp/redis-fqdn.txt`
cp -f parseurl.lua.dist parseurl.lua
#sed -i 's/127.0.0.1/'$FQDN_REDIS'/g' parseurl.lua
sed -i 's/nginx.redis/'$LUA_REDIS_LIB'/g' parseurl.lua
