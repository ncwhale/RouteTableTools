 #!/bin/sh
 wget http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest -O /tmp/apnic.list
 grep "|CN|ipv4|"  /tmp/apnic.list | grep "|allocated" | cut -f 4,5 -d "|" >/tmp/cn.list



 rm /tmp/apnic.list
 rm /tmp/cn.list