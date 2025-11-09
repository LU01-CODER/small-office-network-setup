#!/usr/bin/env bash
# Quick network health check
set -euo pipefail

GATEWAYS=("10.0.10.1" "10.0.20.1" "10.0.30.1" "10.0.40.1" "10.0.50.1")
DNS=("10.0.20.10" "8.8.8.8")

echo "== Ping gateways =="
for gw in "${GATEWAYS[@]}"; do
  ping -c 2 "$gw" >/dev/null && echo "OK  $gw" || echo "FAIL $gw"
done

echo "== DNS tests =="
for d in "${DNS[@]}"; do
  nslookup example.com "$d" >/dev/null 2>&1 && echo "OK  $d" || echo "FAIL $d"
done
