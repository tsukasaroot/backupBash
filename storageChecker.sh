#!/bin/bash

STORAGE=`du -shm | tr -dc '0-9'`
GIT=`du -shm public_html/.git | tr -dc '0-9'`
RESULT=$(($STORAGE-$GIT))

read -r -d '' MERGE << EOM
{
        "dns": "$1",
        "storage": "$RESULT"
}
EOM

curl -X POST --data "$MERGE" -H "Content-Type: application/json" -H "X-Storage-Delivery: yes" -H "X-Storage-Event: push" https://app.fructiweb.com/api/storageWebhook
