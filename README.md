# ipsec-infra
Projeto de configuração para VPN Site-to-Site utilizando a ferramenta strongSwan

[Documentação](https://wiki.strongswan.org/projects/strongswan/wiki/ConnSection)


## Configurações
SO: CentOS 7, disponibilizado pela SaveInCloud

## iptables
```
iptables -t nat -A POSTROUTING -o venet0 -j MASQUERADE
iptables -A FORWARD --source <CIDR server1> --destination <CIDR server2> --jump ACCEPT
iptables -A FORWARD --source <CIDR server2> --destination <CIDR server1> --jump ACCEPT
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
    leftsubnet=<CIDR server1>
    leftfirewall=yes
conn aws-1
    right=<IP server2/tunnel1>
    rightsubnet=<CIDR server2>
conn aws-2
    right=<IP server2/tunnel2>
    rightsubnet=<CIDR server2>
```
vi /etc/strongswan/sysctl.secrets
```
34.199.65.225 : PSK "ziV45E3gszu5nhZ3s7sPx.sDR7nwI1kq"
52.55.239.176 : PSK "blLGkXvxAJrzyJsjjl.UaIRUo_Fl2mYt"
```
