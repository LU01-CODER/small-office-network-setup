# Backup & Recovery Plan

## Objectives
- Ensure **rapid recovery** of router/switch/AP configs
- Keep **3-2-1** copies (3 versions, 2 media, 1 offsite)
- Validate restores quarterly

## What to Back Up
- Router running-config & startup-config
- Switch startup-config
- AP configuration export (controller or local)
- DHCP bindings/leases (if locally stored)
- Firewall ruleset export

## Frequency
- Nightly incremental, weekly full
- Before/after any change window

## Storage
- Primary: On-prem backup share (10.0.20.50)
- Secondary: Encrypted cloud bucket
- Retention: 30/90/365 (daily/weekly/yearly)

## Recovery Runbook (Router – Cisco IOS Example)
1. **Isolate** the device from production if compromised
2. **Console** in → `erase startup-config` → `reload`
3. Enter ROMMON/initial config dialog, set mgmt IP on VLAN 40 SVI
4. TFTP/SCP the last good config:
   ```
   copy scp://backupuser@10.0.20.50/router-backups/R1-2025-01-15.cfg running-config
   write memory
   ```
5. Validate reachability, NAT, ACLs, DHCP scopes
6. Close change with evidence (before/after `show run`)

## Test
- Quarterly restore to lab device/VM
- Record RTO/RPO and lessons learned
