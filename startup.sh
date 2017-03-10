#!/bin/sh

#exportfs -o "*(rw,sync,no_subtree_check,no_root_squash,fsid=0)" /data
if [ $# -eq 0 ]; then
    EXPORT="*:/data"
else
    EXPORT="$@"
fi
echo "Exporting: $EXPORT"

exportfs -o "rw,sync,no_subtree_check,no_root_squash,fsid=0" "$EXPORT"
rpcbind 
rpc.statd 
rpc.nfsd 
exec rpc.mountd --foreground
