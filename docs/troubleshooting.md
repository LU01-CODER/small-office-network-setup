# Troubleshooting Playbook

This playbook uses a layered approach: **Physical → Data Link → Network → Transport → Application**.

## Common Scenarios

### 1) No Internet on VLAN 20 (Servers)
- **Symptom:** Servers cannot reach internet; users can.
- **Checks:**
  - `ping 8.8.8.8` from server
  - `tracert 8.8.8.8` → stops at gateway?
  - Verify default route on router and NAT ACL includes VLAN 20
- **Fix:** Correct gateway NAT ACL (`ip nat inside` on VLAN 20 SVI and relevant ACL).
- **Root Cause:** Gateway misconfiguration
- **Prevention:** Config backup and post‑change smoke tests

### 2) Printer Unreachable from Users
- **Symptom:** Users time out printing
- **Checks:**
  - Confirm printer is on VLAN 30 with correct IP
  - Check ACL allowing TCP 9100/IPP from VLAN 10 → VLAN 30
  - `arp -a` and `ping` from user PC
- **Fix:** Add ACL rule and document port requirement
- **KB:** See `docs/user_kb_printing.md`

### 3) Guest Wi‑Fi Sees Internal Hosts
- **Symptom:** Guest can ping internal IPs
- **Checks:** VLAN mapping on SSID, trunk allowed VLANs, firewall rules
- **Fix:** Block RFC1918 destinations from VLAN 50 via ACL; verify AP VLAN tagging

### 4) Intermittent Drops on Port
- **Checks:** Interface errors, duplex mismatch, cable test
- **Commands (Cisco):**
  - `show interface status`
  - `show interface Gi1/0/5`
  - `test cable-diagnostics tdr interface Gi1/0/5`
- **Fix:** Replace cable; hard‑set speed/duplex if needed

## Tools
- Windows: `ipconfig /all`, `tracert`, `netsh winsock reset`
- Linux/macOS: `ip a`, `ip route`, `traceroute`, `dig`
- Network: Wireshark, Nmap (with authorization), iperf3

## Post‑Incident
- Document **timeline**, **impact**, **fix**, **prevention** in `templates/incident_report.md`.
