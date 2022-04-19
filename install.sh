iptables -t nat -A POSTROUTING -o venet0 -j MASQUERADE
iptables -A FORWARD --source <CIDR server1> --destination <CIDR server2> --jump ACCEPT
iptables -A FORWARD --source <CIDR server2> --destination <CIDR server1> --jump ACCEPT

yum upgrade -y && yum install  zsh -y && yum install epel-release -y  && yum install strongswan strongswan-libipsec -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

systemctl enable strongswan
