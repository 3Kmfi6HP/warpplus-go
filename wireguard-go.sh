#!/bin/bash
ips=4
# TG_TOKEN=''
# CHAT_ID=''
function sendmessage() {
        local message="$(echo -e "$1")"
        local chat_id="$2"
        local token="$3"
        if [[ "$token" == "" ]]; then
                curl -s -X POST https://cloudflare-reverse-proxy-4c5.pages.dev/proxy/https://api.telegram.org/bot$token/sendMessage \
                        -d chat_id="$chat_id" \
                        -d text="$message" \
                        -d parse_mode=markdown >>/dev/null 2>&1
        fi
}
function cfwarp() {
        unset temp
        if [ $ips == 4 ]; then
                n=0
                iplist=100
                while true; do
                        temp[$n]=$(echo 162.159.192.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 162.159.193.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 162.159.195.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 188.114.96.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 188.114.97.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 188.114.98.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo 188.114.99.$(($RANDOM % 256)))
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                done
                while true; do
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 162.159.192.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 162.159.193.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 162.159.195.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 188.114.96.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi

                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 188.114.97.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi

                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 188.114.98.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi

                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo 188.114.99.$(($RANDOM % 256)))
                                n=$(($n + 1))
                        fi
                done
        else
                n=0
                iplist=100
                while true; do
                        temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                        temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
                        n=$(($n + 1))
                        if [ $n -ge $iplist ]; then
                                break
                        fi
                done
                while true; do
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
                                n=$(($n + 1))
                        fi
                        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
                                break
                        else
                                temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
                                n=$(($n + 1))
                        fi
                done
        fi
        echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u >ip.txt
        ./warp
        endpoint=$(cat result.csv | grep ms | head -1 | awk -F, '{print $1}')
        clear
        rm -rf ip.txt result.csv
        cat >/etc/wireguard/warp.conf <<EOF
[Interface]
PrivateKey = yG/Phr+fhiBR95b22GThzxGs/Fccyl0U9H4X0GwEeHs=
Address = 172.16.0.2/32, 2606:4700:110:81fa:8060:92b3:1f91:a8d4/128
DNS = 1.1.1.1, 1.0.0.1, 8.8.8.8, 9.9.9.9
PostUp = ip -4 rule add from $inet lookup main
PostDown = ip -4 rule delete $inet lookup main
#PostUp = ip -6 rule add from $inet6 lookup main
#PostDown = ip -6 rule delete from $inet6 lookup main

[Peer]
PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = $endpoint
PersistentKeepAlive = 30
#Reserved = [ 0, 0, 0 ]
EOF
}
# 设置可执行权限
chmod +x wg-quick.sh mjj wireguard-go warp

# 获取本机IP地址
inet=$(ifconfig eth0 | awk '/inet / {print $2}')
inet6=$(ifconfig eth0 | awk '/inet6 / {print $2}')

./wg-quick.sh down warp
cfwarp
echo 设置WARP端点为 $endpoint
./wg-quick.sh up warp
sleep 5

# 更换WARP端点
change_warp_endpoint() {
        echo "正在更换WARP端点..."
        ./wg-quick.sh down warp
        cfwarp
        ./wg-quick.sh up warp
        local current_time=$(date +'%H:%M:%S')
        local warp_info=$(curl -s https://cp.cloudflare.com/cdn-cgi/trace && ifconfig warp)
        local msg="${current_time} 设置WARP端点为 $endpoint #端点\n\`${warp_info}\`"
        sendmessage "$msg" "$CHAT_ID" "$TG_TOKEN"
}

while true; do
        # 检查WARP端点状态
        http_code=$(curl -s http://cp.cloudflare.com -w %{http_code} --connect-timeout 3 --max-time 15)

        if [ "$http_code" != "204" ]; then
                echo "$(date +'%H:%M:%S') 端点 $endpoint 发生故障"
                msg="$(date +'%H:%M:%S') WARP端点 $endpoint 发生故障"
                sendmessage "$msg" "$CHAT_ID" "$TG_TOKEN"
                change_warp_endpoint
                sleep 5
                starttime=$(date +%s)
        else
                echo "$(date +'%H:%M:%S') 端点 $endpoint 状态正常"
                sleep 60
                [ -f "mjj" ] && ./mjj -max 10 || speedtest -s 49365
        fi
done
