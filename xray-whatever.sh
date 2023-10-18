#!/bin/bash

echo Enter a valid gen4 UUID:
read UUID

rm -rf /etc/localtime
cp /usr/share/zoneinfo/Asia/Colombo /etc/localtime
date -R


#updating and adding firewall rules

apt update
apt upgrade
apt purge iptables-persistent
apt install ufw
ufw allow 'OpenSSH'
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

rm -rf /usr/local/etc/xray/config.json
cat << EOF > /usr/local/etc/xray/config.json
{
  "log": {
    "loglevel": "none"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
            "email": "xtls",
            "flow": "xtls-rprx-vision",
            "level": 0
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": "/dev/shm/trojan.sock",
            "xver": 1
          },
          {
            "path": "/trojanws",
            "dest": "/dev/shm/trojanws.sock",
            "xver": 1
          },
          {
            "path": "/websocket",
            "dest": "/dev/shm/websocket.sock",
            "xver": 1
          },
          {
            "path": "/vmesstcp",
            "dest": "/dev/shm/vmesstcp.sock",
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": "/dev/shm/vmessws.sock",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
	  "minVersion": "1.2",
          "alpn": [
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      }
    },
    {
      "listen": "/dev/shm/trojan.sock",
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
            "level": 0
          }
        ],
        "fallbacks": [
          {
            "dest": 80
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    },
    {
      "listen": "/dev/shm/trojanws.sock",
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
	    "email": "trojanws",
	    "level" : 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
	  "acceptProxyProtocol": true,
          "path": "/trojanws"
        }
      }
    },
    {
      "listen": "/dev/shm/websocket.sock",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
            "email": "vlessws",
            "level": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/websocket"
        }
      }
    },
    {
      "listen": "/dev/shm/vmesstcp.sock",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
            "email": "vmesstcp",
            "level": 0
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "acceptProxyProtocol": true,
          "header": {
            "type": "http",
            "request": {
              "path": [
                "/vmesstcp"
              ]
            }
          }
        }
      }
    },
    {
      "listen": "/dev/shm/vmessws.sock",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e",
            "email": "vmessws",
            "level": 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vmessws"
        }
      }
    },
    {
      "port": 80,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "d906afe5-7c3c-4ddc-aaa4-61c154a82e5e"
          }
        ],
        "decryption": "none"
      },
      
            "streamSettings": {
                "network": "tcp",
                "tcpSettings": {
                    "header": {
                        "type": "http",
                        "response": {
                            "version": "1.1",
                            "status": "200",
                            "reason": "OK",
                            "headers": {
                                "Content-Type": [
                                    "application/octet-stream",
                                    "video/mpeg",
                                    "application/x-msdownload",
                                    "text/html",
                                    "application/x-shockwave-flash"
                                ],
                                "Transfer-Encoding": [
                                    "chunked"
                                ],
                                "Connection": [
                                    "keep-alive"
                                ],
                                "Pragma": "no-cache"
                            }
                        }
                    }
                },
                "security": "none"
            }
        }
    ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "tag": "block"
    },
    {
      "protocol": "wireguard",
      "settings": {
        "secretKey": "MKvNH29so3k8fDo8r68Ul6dFlcq28KRVY7I6WkTmc1c=",
        "address": [
          "172.16.0.2/32",
          "2606:4700:110:8da7:cf9d:9444:e26b:763d/128"
        ],
        "peers": [
          {
            "publicKey": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "allowedIPs": [
              "0.0.0.0/0",
              "::/0"
            ],
            "endpoint": "162.159.192.1:2408"
          }
        ],
        "reserved": [
          187,
          112,
          160
        ],
        "mtu": 1280
      },
      "tag": "wireguard"
    },
    {
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6"
      },
      "proxySettings": {
        "tag": "wireguard"
      },
      "tag": "warp-IPv6"
    }
  ],
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "protocol": [
          "bittorrent"
        ],
        "outboundTag": "block"
      },
      {
        "type": "field",
        "port": "443",
        "network": "udp",
        "outboundTag": "block"
      },
      {
        "type": "field",
        "domain": [
          "geosite:openai",
          "ip.gs",
          "send.ozonedesk.com",
          "dominos.com"
        ],
        "outboundTag": "warp-IPv6"
      },
      {
        "type": "field",
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "block"
      }
      // ... (other rules remain unchanged)
    ]
  }
}
EOF
certbot 
sudo apt install python3-certbot
sudo certbot certonly --standalone -d linkedin.yesitha.tk -d in.yesitha.tk -d meetzoom.yesitha.tk
sudo nano /etc/letsencrypt/renewal/in.yesitha.tk.conf
post_hook = cp /etc/letsencrypt/live/in.yesitha.tk/fullchain.pem /etc/xray/xray.crt && cp /etc/letsencrypt/live/in.yesitha.tk/privkey.pem /etc/xray/xray.key && chmod 666 /etc/xray/xray.key && service xray restart
sudo certbot renew --dry-run 

#install bbr

curl -LJO https://raw.githubusercontent.com/teddysun/across/master/bbr.sh
bash bbr.sh
