#!/bin/bash

#URL="https://api.telegram.org/bot8157740334:AAE9p-lX9FMAal0Jxy72VHcke2uBoztDpJs/sendMessage"
#TEXT="CICD status: $1"

TOKEN="8157740334:AAE9p-lX9FMAal0Jxy72VHcke2uBoztDpJs"
CHAT_ID="5123243638"  # Сюда поместите ваш Chat ID
TEXT="CICD status: $1"

curl -s "https://api.telegram.org/bot$TOKEN/sendMessage" \
-F chat_id=$CHAT_ID \
-F text="$TEXT"
