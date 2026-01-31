
/ip dns   set servers=8.8.8.8,8.8.4.4;


/ppp profile   add change-tcp-mss=yes name=billnasi_vpn_profile@100.106.0.1 use-encryption=yes;
  

/certificate import file-name=server100.106.0.1.crt name="billnasica@100.106.0.1" passphrase="";
/certificate import file-name=100.106.1.131.crt name="100.106.1.131" passphrase="";    
/certificate import file-name=100.106.1.131.key name="100.106.1.131.key" passphrase="";       

/radius add address=100.106.0.1 secret=3pf37ehrnw service=hotspot,ppp timeout=3s  src-address=100.106.1.131  comment="billnasi";
/radius incoming set accept=yes port=3799;


/user add name=100.106.1.131 password=3pf37ehrnw group=full comment="billnasi remote user";


/system clock set time-zone-name=Africa/Nairobi time-zone-autodetect=no;


/ip firewall filter disable [find where comment="defconf: fasttrack"];


/ip firewall filter add chain=input src-address=100.106.0.0/18 action=accept comment="accept remote management from billnasi servers" place-before=*0;


/ip firewall nat add chain=srcnat action=masquerade place-before=*0;


/interface ovpn-client add connect-to=45.32.234.53 profile=billnasi_vpn_profile@100.106.0.1 name=billnasi@100.106.0.1 port=1195  certificate=100.106.1.131 cipher=aes256-cbc  use-peer-dns=no user=100.106.1.131;


/system ntp client set enabled=yes servers=216.239.35.8;


