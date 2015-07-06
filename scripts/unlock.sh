#!/bin/bash
## Because sometimes Virtualbox goes just crazy...

rm -rf "$HOME/VirtualBox VMs/packer*"
rm -rf ../packer/output/packer*
PID=$(ps aux |grep "[p]acker*" |awk '{ print $2 }')
if [ ! -z "$PID" ]; then
  kill $PID
fi