#!/bin/sh

# Usage: [ip_of_testserver] [vpn_profile_id] [vpn_profile_name]

ping $1 -c 4 > /dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Online: OK"
else
    echo "Offline: Reconnect ..."

    /usr/syno/bin/synovpnc kill_client > /dev/null 2>&1

    # Wait some seconds to cleanup connection
    ping 127.0.0.1 -c 10 > /dev/null 2>&1

    echo conf_id=$2 > /usr/syno/etc/synovpnclient/vpnc_connecting
    echo proto=openvpn >> /usr/syno/etc/synovpnclient/vpnc_connecting
    echo conf_name= $3 >> /usr/syno/etc/synovpnclient/vpnc_connecting

    /usr/syno/bin/synovpnc connect --id=$2
fi
