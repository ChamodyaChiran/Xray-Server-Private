# Bash|Xray-Script

* UPDATE 14/07/2022

Xray-Script එක Use කරල ඔයාට High speed Network Connection එකක් / Low ping / Full stable Connection එකක් අත්විදින්න පුලුවන් ...

Manage Script

## :heavy_exclamation_mark: Requirements

* Ubuntu 20.04 or Ubuntu-latest Os එක සහිත Vps එකක්.
* UUID එකක් (V2rayN මගින් හෝ http://uuidgenerator.net මගින් UUID එකක් Genarate කරගන්න).
* DNS use නොකර Ip එකෙන් direct connect කරගන්න xray-nodomain ස්ක්‍රිප්ට් එක භාවිතා කරන්න.

------------------------------------------
## :book: Basic Installation

1)apt-get update -y && apt-get upgrade -y

2)sudo reboot (update එකෙන් පසු restart කිරීමට)

4)sudo git clone https://github.com/ChamodyaChiran/Xray-Server-Private

5)cd Xray-Server-Private

6)sudo chmod +x xray-nodomain.sh

7)sudo ./xray-nodomain.sh

## :book: Custom Installation - With Or Without DNS

1.xray-whatever.sh
Feature-Adblock
Protocol-Vless Xtls 443
         Vless Grpc 443
         Vmess NonTLS 80
Custom Settings
  1.Vless Xtls
      Port-443
      Encryption-None
      Network-TCP 
      HeaderType-None 
      TransportLayer-XTLS 
      Sni-www.host.com 
      FlowControl-XTLS-RPRX-Direct 
      AllowInsecure-True
  2.Vless Grpc
      Port-443
      Encryption-None
      Network-Grpc
      GrpcServiceName-grpc
      TransportLayer-TLS 
      Sni-www.host.com 
      AllowInsecure-True
  3.Vmess NonTLS
      Port-80
      AlterID-0
      Encryption-Auto
      Network-TCP 
      HeaderType-Http
      HttpHost-www.host.com
      HttpPath-/
      AllowInsecure-False

2.xray-nodomain.sh
Feature-Adblock
Protocol-Vless Xtls 443
         Vless Grpc 443
         Vmess NonTLS 80
Custom Settings
  1.Vless Xtls
      Port-443
      Encryption-None
      Network-TCP 
      HeaderType-None 
      TransportLayer-XTLS 
      Sni-www.host.com 
      FlowControl-XTLS-RPRX-Direct 
      AllowInsecure-True
  2.Vless Grpc
      Port-443
      Encryption-None
      Network-Grpc
      GrpcServiceName-grpc
      TransportLayer-TLS 
      Sni-www.host.com 
      AllowInsecure-True
  3.Vmess NonTLS
      Port-80
      AlterID-0
      Encryption-Auto
      Network-TCP 
      HeaderType-Http
      HttpHost-www.host.com
      HttpPath-/
      AllowInsecure-False
      
3.xray-websocket.sh
Protocol-Vless Ws 443
         Vless Ws 80
Custom Settings
  1.Vless Ws
      Port-443
      Encryption-None
      Network-Ws
      TransportLayer-TLS 
      WsHost-www.host.com 
      WsPath-/
      AllowInsecure-True
  2.Vless Ws
      Port-80
      Encryption-None
      Network-Ws
      TransportLayer-TLS 
      WsHost-www.host.com 
      WsPath-/
      AllowInsecure-True
      
4.CDN.sh  (Need Domain)
Protocol-Vless Ws 443
Custom Settings
  1.Vless Ws
      Host-www.Host.com
      Port-443
      Encryption-None
      Network-Ws
      TransportLayer-TLS 
      WsHost-DomainName
      WsPath-/iamtrazy
      AllowInsecure-True
  
------------------------------------------

## :book: How To Connect

1)Android User කෙනෙක්නම් V2rayNG,Anxray,Sagernet Download කරගන්න (
https://github.com/2dust/v2rayNG)

2)Windows User කෙනෙක්නම් V2rayN+Proxifire,Clash හො Netch Software Download කරගන්න

* Http Port =  80

* Xtls port = 443

## :book: Unistallation (Remove xray-core and all modified config files from the server) *will not remove BBR

1) sudo rm  -rf  ~/bash-xray-script

2) sudo git clone https://github.com/iamtrazy/bash-xray-script

3) cd bash-xray-script

4) sudo chmod 777 remove-xray.sh

5) sudo ./remove-xray.sh



Credits
    https://github.com/teddysun - BBR autoscript
    Team Rezoth - Contributor
    @Savinda1 - for the awesome readme file 😎

