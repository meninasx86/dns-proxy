#!/bin/bash
filename="$0"
image="meninasx86/dns-proxy"
version="test"

Usage(){
    echo "Usage: $filename <command> <attribute>"
    echo "command options:"
    echo "  start   start  service"
    echo "  stop    stop  service"
    echo "  status  display the status of service"
    echo "attribute options:"
    echo "  iface   interface of wan"
    echo "  port(range) port or port range of dns service    "
    exit 1
}

START(){
    if [ "$#" -ne 2 ]; then
        Usage
    fi
    WAN=$1 
    DNSPORT=$2

    docker run --rm -itd --cap-add=NET_ADMIN --network=host --privileged -e WAN=${WAN} -e DNSPORT=${DNSPORT} ${image}:${version}
}

STOP(){
    if [ "$#" -ne 2 ]; then
        Usage
    fi

    WAN=$1 
    DNSPORT=$2

    docker run --rm -itd --cap-add=NET_ADMIN --network=host --privileged -e WAN=${WAN} -e DNSPORT=${DNSPORT} --entrypoint="./clean" ${image}:${version}
}

STATUS(){
    sudo iptables -L -nv -t nat
}

if [ "$#" -lt 1 ]; then
    Usage
else
    case "$1" in
        start)
            START $2 $3
            STATUS
            ;;
        stop)
            STOP $2 $3
            STATUS
            ;;
        status)
            STATUS
            ;;       
        *)
            Usage
            ;;
    esac
fi
