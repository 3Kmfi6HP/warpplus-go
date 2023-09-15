# cloudflare warp go

## 使用方法

要求是 Linux 系统有 sudo 在中国使用

```bash
apt install -y iproute2 openresolv iptables
apt install -y wireguard-tools --no-install-recommends

cd /root

git clone https://ghproxy.com/https://github.com/3kmfi6HP/warpplus-go.git

cd warpplus-go

cp warp-go.service /etc/systemd/system/warp-go.service
# export TG_TOKEN=''
# export CHAT_ID=''
systemctl enable warp-go

systemctl start warp-go

systemctl restart warp-go

tail -f /root/warpplus-go/wireguard-go.log
```
