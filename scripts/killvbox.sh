#!/bin/bash -eux
## Destroys all Virtualbox VMs

while read -r name; do
  VBoxManage unregistervm "$(echo $name |awk '{print$2}' |sed -e 's/.*{\([^}]\+\)}.*/\1/g')" --delete 2>&1 /dev/null
done < <(VBoxManage list vms)
