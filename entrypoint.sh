#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "decryption": "none",
        "clients": [
          {
            "id": "$UUID"
          }
        ]
      },
      "streamSettings": {
        "network": "ws"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "shadowsocks",
                  "settings": {
                        "servers": [
                                {
                                "address": "$server",
                                "method": "$enc",
                                "ota": false,
                                "port": $server_port,
                                "password": "$pass"
                                }
                        ]
            }
    }
  ]
}
EOF

#run xray

xray -c /etc/xray/config.json
