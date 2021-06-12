/usr/bin/sleep 2
/usr/sbin/ip address add 10.100.2.2/24 dev eth1
/usr/sbin/ip address add 2001:db8:0:1::2/64 dev eth1
/usr/sbin/ip route add 10.0.0.0/8 via 10.100.2.1 dev eth1
/usr/sbin/ip route add 2001:db8::/32 via 2001:db8:0:1::1 dev eth1
/bin/bash
