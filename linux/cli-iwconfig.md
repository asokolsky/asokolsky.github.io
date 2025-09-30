# iwconfig


[man iwconfig](https://linux.die.net/man/8/iwconfig)

```
alex@t14g3 > iwconfig
lo        no wireless extensions.

enp0s31f6  no wireless extensions.

wlp0s20f3  IEEE 802.11  ESSID:"FASTWEB-36108A"
          Mode:Managed  Frequency:5.5 GHz  Access Point: 0A:C7:F5:36:10:8A
          Bit Rate=-2.13367e+06 kb/s   Tx-Power=22 dBm
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Power Management:on
          Link Quality=67/70  Signal level=-43 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0

alex@t14g3 > iwconfig wlp0s20f3
wlp0s20f3  IEEE 802.11  ESSID:"FASTWEB-36108A"
          Mode:Managed  Frequency:5.5 GHz  Access Point: 0A:C7:F5:36:10:8A
          Bit Rate=-2.13367e+06 kb/s   Tx-Power=22 dBm
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Power Management:on
          Link Quality=67/70  Signal level=-43 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:115   Missed beacon:0
```

Relevant but unrelated is [nmcli](https://linux.die.net/man/1/nmcli):
```
alex@t14g3 > nmcli connection show
NAME                 UUID                                  TYPE      DEVICE
Auto FASTWEB-36108A  8c898d50-e498-4b35-aed2-0c655c06a69d  wifi      wlp0s20f3
lo                   c45ca9ff-e6b6-4653-ae5a-97813c381a14  loopback  lo
960-5                b862347c-408d-4957-a9d1-b41d8fb88524  wifi      --
Auto #IAD Free WiFi  f3363607-167d-4dd2-b6ec-5a295b7e390d  wifi      --
Wired connection 1   0268ef0f-32d3-33e5-a8c3-5b388f9a5152  ethernet  --

alex@t14g3 > nmcli connection show "Auto FASTWEB-36108A"
connection.id:                          Auto FASTWEB-36108A
connection.uuid:                        8c898d50-e498-4b35-aed2-0c655c06a69d
connection.stable-id:                   --
connection.type:                        802-11-wireless
connection.interface-name:              wlp0s20f3
connection.autoconnect:                 yes
connection.autoconnect-priority:        0
connection.autoconnect-retries:         -1 (default)
connection.multi-connect:               0 (default)
connection.auth-retries:                -1
connection.timestamp:                   1759265705
connection.permissions:                 --
connection.zone:                        --
connection.controller:                  --
connection.master:                      --
connection.slave-type:                  --
connection.port-type:                   --
connection.autoconnect-slaves:          -1 (default)
connection.autoconnect-ports:           -1 (default)
connection.secondaries:                 --
connection.gateway-ping-timeout:        0
connection.metered:                     unknown
connection.lldp:                        default
connection.mdns:                        -1 (default)
connection.llmnr:                       -1 (default)
connection.dns-over-tls:                -1 (default)
connection.mptcp-flags:                 0x0 (default)
connection.wait-device-timeout:         -1
connection.wait-activation-delay:       -1
802-11-wireless.ssid:                   FASTWEB-36108A
802-11-wireless.mode:                   infrastructure
802-11-wireless.band:                   --
802-11-wireless.channel:                0
802-11-wireless.bssid:                  --
802-11-wireless.mac-address:            --
802-11-wireless.cloned-mac-address:     --
802-11-wireless.generate-mac-address-mask:--
802-11-wireless.mac-address-blacklist:  --
802-11-wireless.mac-address-randomization:default
802-11-wireless.mtu:                    auto
802-11-wireless.seen-bssids:            0A:C7:F5:36:10:8A
802-11-wireless.hidden:                 no
802-11-wireless.powersave:              0 (default)
802-11-wireless.wake-on-wlan:           0x1 (default)
802-11-wireless.ap-isolation:           -1 (default)
802-11-wireless-security.key-mgmt:      wpa-psk
802-11-wireless-security.wep-tx-keyidx: 0
802-11-wireless-security.auth-alg:      open
802-11-wireless-security.proto:         --
802-11-wireless-security.pairwise:      --
802-11-wireless-security.group:         --
802-11-wireless-security.pmf:           0 (default)
802-11-wireless-security.leap-username: --
802-11-wireless-security.wep-key0:      <hidden>
802-11-wireless-security.wep-key1:      <hidden>
802-11-wireless-security.wep-key2:      <hidden>
802-11-wireless-security.wep-key3:      <hidden>
802-11-wireless-security.wep-key-flags: 0 (none)
802-11-wireless-security.wep-key-type:  unknown
802-11-wireless-security.psk:           <hidden>
802-11-wireless-security.psk-flags:     0 (none)
802-11-wireless-security.leap-password: <hidden>
802-11-wireless-security.leap-password-flags:0 (none)
802-11-wireless-security.wps-method:    0x0 (default)
802-11-wireless-security.fils:          0 (default)
ipv4.method:                            auto
ipv4.dns:                               --
ipv4.dns-search:                        --
ipv4.dns-options:                       --
ipv4.dns-priority:                      0
ipv4.addresses:                         --
ipv4.gateway:                           --
ipv4.routes:                            --
ipv4.route-metric:                      -1
ipv4.route-table:                       0 (unspec)
ipv4.routing-rules:                     --
ipv4.replace-local-rule:                -1 (default)
ipv4.ignore-auto-routes:                no
ipv4.ignore-auto-dns:                   no
ipv4.dhcp-client-id:                    --
ipv4.dhcp-iaid:                         --
ipv4.dhcp-dscp:                         --
ipv4.dhcp-timeout:                      0 (default)
ipv4.dhcp-send-hostname:                yes
ipv4.dhcp-hostname:                     --
ipv4.dhcp-fqdn:                         --
ipv4.dhcp-hostname-flags:               0x0 (none)
ipv4.never-default:                     no
ipv4.may-fail:                          yes
ipv4.required-timeout:                  -1 (default)
ipv4.dad-timeout:                       -1 (default)
ipv4.dhcp-vendor-class-identifier:      --
ipv4.link-local:                        0 (default)
ipv4.dhcp-reject-servers:               --
ipv4.auto-route-ext-gw:                 -1 (default)
ipv6.method:                            auto
ipv6.dns:                               --
ipv6.dns-search:                        --
ipv6.dns-options:                       --
ipv6.dns-priority:                      0
ipv6.addresses:                         --
ipv6.gateway:                           --
ipv6.routes:                            --
ipv6.route-metric:                      -1
ipv6.route-table:                       0 (unspec)
ipv6.routing-rules:                     --
ipv6.replace-local-rule:                -1 (default)
ipv6.ignore-auto-routes:                no
ipv6.ignore-auto-dns:                   no
ipv6.never-default:                     no
ipv6.may-fail:                          yes
ipv6.required-timeout:                  -1 (default)
ipv6.ip6-privacy:                       -1 (unknown)
ipv6.addr-gen-mode:                     default
ipv6.ra-timeout:                        0 (default)
ipv6.mtu:                               auto
ipv6.dhcp-pd-hint:                      --
ipv6.dhcp-duid:                         --
ipv6.dhcp-iaid:                         --
ipv6.dhcp-timeout:                      0 (default)
ipv6.dhcp-send-hostname:                yes
ipv6.dhcp-hostname:                     --
ipv6.dhcp-hostname-flags:               0x0 (none)
ipv6.auto-route-ext-gw:                 -1 (default)
ipv6.token:                             --
proxy.method:                           none
proxy.browser-only:                     no
proxy.pac-url:                          --
proxy.pac-script:                       --
GENERAL.NAME:                           Auto FASTWEB-36108A
GENERAL.UUID:                           8c898d50-e498-4b35-aed2-0c655c06a69d
GENERAL.DEVICES:                        wlp0s20f3
GENERAL.IP-IFACE:                       wlp0s20f3
GENERAL.STATE:                          activated
GENERAL.DEFAULT:                        yes
GENERAL.DEFAULT6:                       yes
GENERAL.SPEC-OBJECT:                    /org/freedesktop/NetworkManager/AccessPoint/143
GENERAL.VPN:                            no
GENERAL.DBUS-PATH:                      /org/freedesktop/NetworkManager/ActiveConnection/9
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/Settings/3
GENERAL.ZONE:                           --
GENERAL.MASTER-PATH:                    --
IP4.ADDRESS[1]:                         192.168.1.62/24
IP4.GATEWAY:                            192.168.1.254
IP4.ROUTE[1]:                           dst = 192.168.1.0/24, nh = 0.0.0.0, mt = 600
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 192.168.1.254, mt = 600
IP4.DNS[1]:                             192.168.1.254
IP4.DOMAIN[1]:                          lan
DHCP4.OPTION[1]:                        broadcast_address = 192.168.1.255
DHCP4.OPTION[2]:                        dhcp_client_identifier = 01:10:f6:0a:79:99:2e
DHCP4.OPTION[3]:                        dhcp_lease_time = 86400
DHCP4.OPTION[4]:                        dhcp_server_identifier = 192.168.1.254
DHCP4.OPTION[5]:                        domain_name = lan
DHCP4.OPTION[6]:                        domain_name_servers = 192.168.1.254
DHCP4.OPTION[7]:                        expiry = 1759352105
DHCP4.OPTION[8]:                        host_name = t14g3
DHCP4.OPTION[9]:                        ip_address = 192.168.1.62
DHCP4.OPTION[10]:                       next_server = 192.168.1.254
DHCP4.OPTION[11]:                       requested_broadcast_address = 1
DHCP4.OPTION[12]:                       requested_domain_name = 1
DHCP4.OPTION[13]:                       requested_domain_name_servers = 1
DHCP4.OPTION[14]:                       requested_domain_search = 1
DHCP4.OPTION[15]:                       requested_host_name = 1
DHCP4.OPTION[16]:                       requested_interface_mtu = 1
DHCP4.OPTION[17]:                       requested_ms_classless_static_routes = 1
DHCP4.OPTION[18]:                       requested_nis_domain = 1
DHCP4.OPTION[19]:                       requested_nis_servers = 1
DHCP4.OPTION[20]:                       requested_ntp_servers = 1
DHCP4.OPTION[21]:                       requested_rfc3442_classless_static_routes = 1
DHCP4.OPTION[22]:                       requested_root_path = 1
DHCP4.OPTION[23]:                       requested_routers = 1
DHCP4.OPTION[24]:                       requested_static_routes = 1
DHCP4.OPTION[25]:                       requested_subnet_mask = 1
DHCP4.OPTION[26]:                       requested_time_offset = 1
DHCP4.OPTION[27]:                       requested_wpad = 1
DHCP4.OPTION[28]:                       routers = 192.168.1.254
DHCP4.OPTION[29]:                       subnet_mask = 255.255.255.0
IP6.ADDRESS[1]:                         2001:b07:a96:1f3e:395b:f902:4835:aa58/64
IP6.ADDRESS[2]:                         2001:b07:a96:1f3e:8e86:9ef8:f9bd:7499/64
IP6.ADDRESS[3]:                         fe80::f63c:42be:adf6:fd20/64
IP6.GATEWAY:                            fe80::ac7:f5ff:fe36:b089
IP6.ROUTE[1]:                           dst = fe80::/64, nh = ::, mt = 1024
IP6.ROUTE[2]:                           dst = 2001:b07:a96:1f3e::/64, nh = ::, mt = 600
IP6.ROUTE[3]:                           dst = ::/0, nh = fe80::ac7:f5ff:fe36:b089, mt = 600
IP6.DNS[1]:                             2001:b07:a96:1f3e::1
IP6.SEARCHES[1]:                        lan
DHCP6.OPTION[1]:                        dhcp6_client_id = 00:04:4d:73:77:7f:aa:e8:36:1b:c7:15:dc:58:18:83:e5:58
DHCP6.OPTION[2]:                        dhcp6_domain_search = lan
DHCP6.OPTION[3]:                        dhcp6_name_servers = 2001:b07:a96:1f3e::1
DHCP6.OPTION[4]:                        dhcp6_ntp_servers = 2001:b07:a96:1f3e::1
DHCP6.OPTION[5]:                        iaid = 46:85:9a:df
```
