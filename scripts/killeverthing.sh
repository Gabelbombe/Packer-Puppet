#!/bin/bash -eux

## Die die die die die
for pid in $(ps aux |grep -i 'virtual\|vbox' |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
for pid in $(ps aux |grep vmware             |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
for pid in $(ps aux |grep parallel           |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done
for pid in $(ps aux |grep packer             |grep -v grep |awk '{print$2}'); do sudo kill -9 $pid; done


while read -r name; do
  VBoxManage unregistervm "$(echo $name |awk '{print$2}' |sed -e 's/.*{\([^}]\+\)}.*/\1/g')" --delete 2>&1 /dev/null
done < <(VBoxManage list vms)


while read -r name; do
  prlctl unregister  $(echo $name awk '{print$1}' |sed -e 's/.*{\([^}]\+\)}.*/\1/g')
done < <(prlctl list -a |tail -n +2)


rm -fr ~/VirtualBox\ VMs/* ../packer/output/*

