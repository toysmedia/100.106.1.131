
/interface bridge add name=billnasi_hotspot_bridge;



/ip address add address=11.220.0.1/16 interface=billnasi_hotspot_bridge;



/ip pool add name=billnasi_hs_pool ranges=11.220.0.2-11.220.255.254;



/ip dhcp-server add address-pool=billnasi_hs_pool disabled=no interface=billnasi_hotspot_bridge lease-time=1d-00:10:00 name=billnasi_hs_dhcp;



/ip dhcp-server network  add address=11.220.0.0/16 comment="billnasi_hs_network" gateway=11.220.0.1;



/ip hotspot profile  add hotspot-address=11.220.0.1 login-by=cookie,https,http-pap,mac-cookie name=billnasi_hs_prof use-radius=yes radius-interim-update=00:03:45 ;



/ip hotspot  add address-pool=billnasi_hs_pool addresses-per-mac=3 disabled=no  idle-timeout=1m interface=billnasi_hotspot_bridge name=billnasi_hs_server profile=billnasi_hs_prof;



/ip hotspot walled-garden ip  add action=accept disabled=no !dst-address !dst-address-list dst-host=isp.billnasi.com !dst-port !protocol !src-address !src-address-list comment="whitelist billnasi server";




