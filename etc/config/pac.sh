#!/bin/sh

dev='Wi-Fi'

if [ "$1" == "" ]; then
    echo "input t(tencent)/h(home)/s(shadowsocks) name pls."
else
    echo "Changing the $dev proxy, may need password"
fi

if [ "$1" == "t" ]; then
    sudo networksetup -setautoproxyurl $dev "http://txp-01.tencent.com/proxy.pac"
    echo "http://txp-01.tencent.com/proxy.pac"
elif [ "$1" == 'h' ]; then
    sudo networksetup -setautoproxyurl $dev ""
    echo "no proxy"
elif [ "$1" == 's' ]; then
    sudo networksetup -setautoproxyurl $dev "http://127.0.0.1:8090/proxy.pac"
    echo "http://127.0.0.1:8090/proxy.pac"
fi

#networksetup -setwebproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
