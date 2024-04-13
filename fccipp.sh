#!/bin/bash

#colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
rest='\033[0m'

case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	    cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
	armv7l )
        cpu=arm
	;;
	* )
	echo "The current architecture is $(uname -m), not supported"
	exit
	;;
esac

cfwarpIP() {
    if [[ ! -f "$PREFIX/bin/warpendpoint" ]]; then
        echo "Downloading warpendpoint program"
        if [[ -n $cpu ]]; then
            curl -L -o warpendpoint -# --retry 2 https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$cpu
            cp warpendpoint $PREFIX/bin
            chmod +x $PREFIX/bin/warpendpoint
        fi
    fi
}

endipv4(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
			n=$[$n+1]
		fi
	done
}

endipv6(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
	done
}

freeCloudflareAccount(){
	output=$(curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]')
	publicKey=$(echo "$output" | grep -oP '("2606:4700:[0-9a-f:]+/128")' | tr -d '"')
	privateKey=$(echo "$output" | grep -oP '("private_key":"[0-9a-zA-Z\/+]+=")' | cut -d':' -f2 | tr -d '"')
	reserved=$(echo "$output" | grep -oP '(\[[0-9]+(,[0-9]+){2}\])' | tr -d '"' | sed 's/"reserved"://')
}
freeCloudflareAccount2(){
	output=$(curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]')
	publicKey2=$(echo "$output" | grep -oP '("2606:4700:[0-9a-f:]+/128")' | tr -d '"')
	privateKey2=$(echo "$output" | grep -oP '("private_key":"[0-9a-zA-Z\/+]+=")' | cut -d':' -f2 | tr -d '"')
	reserved2=$(echo "$output" | grep -oP '(\[[0-9]+(,[0-9]+){2}\])' | tr -d '"' | sed 's/"reserved"://')
}

endipresult() {
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt
    ulimit -n 102400
    chmod +x warpendpoint >/dev/null 2>&1
    if command -v warpendpoint &>/dev/null; then
        warpendpoint
   else
        ./warpendpoint
    fi
    
    clear
    Endip_v4=$(cat result.csv | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+" | head -n 1)
	Endip_v4_ip="${Endip_v4%:*}"
	Endip_v4_port="${Endip_v4##*:}"
    
	freeCloudflareAccount
	freeCloudflareAccount2

	template='{
	"route": {
		"geoip": {
		"path": "geo-assets\\sagernet-sing-geoip-geoip.db"
		},
		"geosite": {
		"path": "geo-assets\\sagernet-sing-geosite-geosite.db"
		},
		"rules": [
		{
			"inbound": "dns-in",
			"outbound": "dns-out"
		},
		{
			"port": 53,
			"outbound": "dns-out"
		},
		{
			"clash_mode": "Direct",
			"outbound": "direct"
		},
		{
			"clash_mode": "Global",
			"outbound": "select"
		}
		],
		"auto_detect_interface": true,
		"override_android_vpn": true
	},
	"outbounds": [
		{
		"type": "selector",
		"tag": "select",
		"outbounds": [
			"auto",
			"IP->Iran, Yotube:Geekmeek",
			"IP->Main, Yotube:Geekmeek"
		],
		"default": "auto"
		},
		{
		"type": "urltest",
		"tag": "auto",
		"outbounds": [
			"IP->Iran, Yotube:Geekmeek",
			"IP->Main, Yotube:Geekmeek"
		],
		"url": "http://cp.cloudflare.com/",
		"interval": "10m0s"
		},
		{
		"type": "wireguard",
		"tag": "IP->Iran, Yotube:Geekmeek",
		"local_address": [
			"172.16.0.2/32",
			"'$publicKey'"
		],
		"private_key": "'$privateKey'",
		"server": "'$Endip_v4_ip'",
		"server_port": '$Endip_v4_port',
		"peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
		"reserved": '$reserved',
		"mtu": 1280,
		"fake_packets": "5-10"
		},
		{
		"type": "wireguard",
		"tag": "IP->Main, Yotube:Geekmeek",
		"detour": "IP->Iran, Yotube:Geekmeek",
		"local_address": [
			"172.16.0.2/32",
			"'$publicKey2'"
		],
		"private_key": "'$privateKey2'",
		"server": "'$Endip_v4_ip'",
		"server_port": '$Endip_v4_port',
		"peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
		"reserved": '$reserved2',
		"mtu": 1280,
		"fake_packets": "5-10"
		},
		{
		"type": "dns",
		"tag": "dns-out"
		},
		{
		"type": "direct",
		"tag": "direct"
		},
		{
		"type": "direct",
		"tag": "bypass"
		},
		{
		"type": "block",
		"tag": "block"
		}
	]  
	}'

	echo "$template"

    rm warpendpoint >/dev/null 2>&1
    rm -rf ip.txt
	rm -rf result.csv
    exit
}


cfwarpIP
endipv4
endipresult
Endip_v4