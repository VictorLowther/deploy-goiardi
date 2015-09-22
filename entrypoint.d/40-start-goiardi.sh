#!/bin/bash

echo "hostname=\"$IP\"" > /tmp/goiardi.conf
cat /etc/goiardi/goiardi.conf >> /tmp/goiardi.conf
cp /tmp/goiardi.conf /etc/goiardi/goiardi.conf
rm -f /tmp/goiardi.conf

/go/bin/goiardi -c /etc/goiardi/goiardi.conf &

while [ ! -e /etc/goiardi/admin.pem ] ; do
  echo "Waiting for goiardi to start"
  sleep 5
done
