
/interface bridge add name=PPP_HOTSPOT;


/ip pool add name=pppoe_pool range=19.225.0.2-19.225.63.254;



/ppp profile add dns-server=8.8.8.8,8.8.4.4 local-address=19.225.0.1 name=billnasi_ppp_profile remote-address=pppoe_pool;



/interface pppoe-server server add authentication=pap default-profile=billnasi_ppp_profile disabled=no interface=PPP_HOTSPOT one-session-per-host=yes keepalive-timeout=10;


/ppp aaa set use-radius=yes interim-update=00:06:16 accounting=yes;



/ip firewall filter add action=drop chain=forward comment="drop expired pppoe user's pkts" src-address-list=expired    place-before=*0;




/ip address add address=11.220.0.1/16 interface=PPP_HOTSPOT;



/ip pool add name=billnasi_hs_pool ranges=11.220.0.2-11.220.255.254;



/ip dhcp-server add address-pool=billnasi_hs_pool disabled=no interface=PPP_HOTSPOT lease-time=1d-00:10:00 name=billnasi_hs_dhcp;



/ip dhcp-server network  add address=11.220.0.0/16 comment="billnasi_hs_network" gateway=11.220.0.1;



/ip hotspot profile  add hotspot-address=11.220.0.1 login-by=cookie,https,http-pap,mac-cookie name=billnasi_hs_prof use-radius=yes radius-interim-update=00:06:30;



/ip hotspot  add address-pool=billnasi_hs_pool addresses-per-mac=3 disabled=no  idle-timeout=1m interface=PPP_HOTSPOT name=billnasi_hs_server profile=billnasi_hs_prof;



/ip hotspot walled-garden ip  add action=accept disabled=no !dst-address !dst-address-list dst-host=isp.billnasi.com !dst-port !protocol !src-address !src-address-list comment="whitelist billnasi server";



/ip hotspot walled-garden ip  add action=accept disabled=no !dst-address !dst-address-list dst-host=isp.billnasi.com !dst-port !protocol !src-address !src-address-list comment="whitelist billnasi server proxy";




