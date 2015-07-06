#!/bin/bash

if [ ! -d /etc ]; then
  mkdir -p

mkdir -p /etc
cp /tmp/metadata.json /etc/metadata.json
chmod 0444 /etc/metadata.json
rm -f /tmp/metadata.json
