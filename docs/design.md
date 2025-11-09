# Network Design

## Goals
- Support 10–15 users with room to grow
- Minimize broadcast domains using VLANs
- Enforce least-privilege access between segments
- Centralize identity and name resolution (AD/DNS)
- Enable **observability** (logs, NetFlow/sFlow optional)
- Provide a documented **backup & recovery** workflow

## Addressing & VLANs
| VLAN | Name     | Subnet         | Gateway     | Notes                  |
|-----:|----------|----------------|-------------|------------------------|
| 10   | Users    | 10.0.10.0/24   | 10.0.10.1   | Workstations           |
| 20   | Servers  | 10.0.20.0/24   | 10.0.20.1   | AD, File, App servers  |
| 30   | Printers | 10.0.30.0/24   | 10.0.30.1   | Network printers       |
| 40   | Mgmt     | 10.0.40.0/24   | 10.0.40.1   | Admin-only             |
| 50   | Guest    | 10.0.50.0/24   | 10.0.50.1   | Internet-only          |

## Routing
- Inter‑VLAN routing via the **edge router** (ROUTER‑ON‑A‑STICK or SVI on L3 switch)
- Default route → ISP gateway (PPPoE/DHCP/static as available)
- NAT overload (PAT) for internal → internet

## DHCP
- DHCP on the router for all user/guest subnets
- Reservations for servers/printers via MAC
- Option 003 (Router), 006 (DNS), 015 (Domain Name)

## DNS
- Primary DNS: 10.0.20.10 (AD/DNS)
- Secondary DNS: 10.0.20.11 or router as forwarder

## Security
- ACLs between VLANs (Users → Servers: allow required ports only)
- Guest VLAN blocked from internal subnets, allowed → internet
- Port security: max 2 MACs on access ports
- Management VLAN access restricted to IT staff
- Enable SSH, disable telnet, strong crypto

## Monitoring
- Syslog to 10.0.20.15
- Optional: NetFlow/sFlow export to 10.0.20.16
- NTP from 0.pool.ntp.org or ISP

## Hardware (Example)
- Edge Router: Cisco ISR/IOS or MikroTik/RouterOS
- Switch: 24‑port Layer‑2 with 802.1Q
- AP: Business AP with multiple SSIDs → VLAN mapping

## Change Management
- All changes logged in `inventory/change_log.md` using the template in `templates/change_request.md`.
