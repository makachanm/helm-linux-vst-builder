#!/bin/sh
set -e
cd "$(dirname "$0")"

if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    ENGINE=docker
elif command -v podman >/dev/null 2>&1; then
    ENGINE=podman
else
    echo "please install docker or podman" >&2
    exit 1
fi

$ENGINE build -t helm-linux-vst-builder .
ID=$($ENGINE create helm-linux-vst-builder)
$ENGINE cp "$ID:/helm/builds/linux/VST/build/helm.so" ./helm.so
$ENGINE rm "$ID" >/dev/null
echo "완료: $(pwd)/helm.so"
