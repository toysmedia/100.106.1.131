

/interface bridge add name=billnasi_pppoe_bridge;



/ip pool add name=pppoe_pool range=19.225.0.2-19.225.63.254;




/ppp profile add dns-server=8.8.8.8,8.8.4.4 local-address=192.25.0.1 name=billnasi_ppp_profile remote-address=pppoe_pool;



/interface pppoe-server server add authentication=pap default-profile=billnasi_ppp_profile disabled=no interface=billnasi_pppoe_bridge one-session-per-host=yes keepalive-timeout=10;




/ppp aaa set use-radius=yes interim-update=00:05:50 accounting=yes;



/ip firewall filter add action=drop chain=forward comment="drop expired user's pkts" src-address-list=expired    place-before=*0;

