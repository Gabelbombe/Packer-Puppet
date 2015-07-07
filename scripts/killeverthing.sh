#!/bin/bash -eux

## ROOT check
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as su" 1>&2 ; exit 1
fi

## Die die die die die
for pid in $(ps aux |grep -i 'virtual\|vbox' |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
for pid in $(ps aux |grep vmware             |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
for pid in $(ps aux |grep parallel           |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done

[ -f 'killvbox.sh' ] && {
  bash killvbox.sh
}

for pid in $(ps aux |grep packer             |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
