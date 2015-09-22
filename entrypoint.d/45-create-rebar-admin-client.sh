mkdir -p /etc/chef

cd /tmp
KEYFILE="/tmp/rebar.pem"
EDITOR=/bin/true knife client create rebar \
   -s http://localhost:4646 \
   -a --file "$KEYFILE" -u admin \
   -k /etc/goiardi/admin.pem

# Store rebar pem file.
baseurl="http://127.0.0.1:8500/v1/kv/digitalrebar/private/chef/system"
token="?token=$CONSUL_M_ACL"
curl --data-binary "$(cat $KEYFILE)" -X PUT ${baseurl}/pem${token}
curl --data-binary "rebar" -X PUT ${baseurl}/account${token}
curl --data-binary "http" -X PUT ${baseurl}/proto${token}

rm -f $KEYFILE

while true; do
    sleep 300
done
