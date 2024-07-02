#!/usr/bin/env bash

if command -v /usr/bin/podman &> /dev/null;then
  DRIVER="podman"
else
  DRIVER="docker"
fi

jq -n "{\"driver\":\"$DRIVER\"}"