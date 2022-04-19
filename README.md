# ipsec-infra
Projeto de configuração para VPN Site-to-Site utilizando a ferramenta strongSwan

[Documentação](https://wiki.strongswan.org/projects/strongswan/wiki/ConnSection)


## Configurações
SO: CentOS 7, disponibilizado pela SaveInCloud

## iptables
```
iptables -t nat -A POSTROUTING -o <venet0> -j MASQUERADE
iptables -A FORWARD --source <CIDR server_local> --destination <CIDR server_remote> --jump ACCEPT
iptables -A FORWARD --source <CIDR server_remote> --destination <CIDR server_local> --jump ACCEPT
```

## Strongswan Configuration Example

vi /etc/strongswan/sysctl.conf
```
conn %default
    authby=secret
    type=tunnel
    dpdaction=restart
    auto=start
    installpolicy=yes
    keyexchange=ikev2
    ike=aes128-sha1-modp1024
    ikelifetime=28800s
    esp=aes128-sha1-modp1024
    lifetime=3600s
    left=%any
    leftsubnet=<CIDR server_local>
    leftfirewall=yes
conn aws-1
    right=<IP server_remote1/tunnel1>
    rightsubnet=<CIDR server_remote>
conn aws-2
    right=<IP server_remote2/tunnel2>
    rightsubnet=<CIDR server_remote>
```
vi /etc/strongswan/sysctl.secrets
```
IP server_remote1 : PSK "xxxxxxxxxx"
IP server_remote2 : PSK "xxxxxxxxxx"
```
