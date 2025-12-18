# Ansible Role: lighthouse

## Description
Deploys and configures automated website auditing system using Google Lighthouse.
Collects performance metrics and stores them in ClickHouse database.

## Requirements
- Ansible 2.9+
- Ubuntu/Debian target system
- ClickHouse server (local or remote)
- Python 3.8+
- Node.js 14+

## Role Variables

### Main Configuration (defaults/main.yml)
| Variable | Default | Description |
|----------|---------|-------------|
| `lighthouse_user` | `lighthouse` | System user for audit operations |
| `lighthouse_dir` | `/opt/lighthouse` | Installation directory |
| `audit_sites` | `[]` | List of URLs to audit |
| `clickhouse_host` | `localhost` | ClickHouse server hostname/IP |
| `clickhouse_port` | `9000` | ClickHouse server port |
| `clickhouse_database` | `lighthouse` | Database name in ClickHouse |
| `audit_interval_hours` | `24` | Hours between audits |
| `audit_timeout_seconds` | `120` | Audit timeout in seconds |

### System Dependencies (vars/main.yml)
| Variable | Default | Description |
|----------|---------|-------------|
| `python_packages` | List | Required Python packages |
| `system_dependencies` | List | System packages for Chrome |

## Example Playbook
```yaml
- hosts: audit_servers
  roles:
    - role: lighthouse
      vars:
        lighthouse_user: "web-auditor"
        audit_sites:
          - https://example1.com
          - https://example2.com
        clickhouse_host: "clickhouse.internal"
Tasks Overview
User setup: Creates lighthouse user and group

Directory creation: Sets up /opt/lighthouse structure

Package installation: Installs Node.js, Chrome, dependencies

Lighthouse installation: Installs Lighthouse CLI via npm

Python environment: Creates virtualenv with required packages

Configuration: Deploys config files and scripts

Service setup: Configures systemd service and cron job

Logging setup: Configures log rotation and monitoring

Files Created
/opt/lighthouse/ - Main application directory

/opt/lighthouse/config.ini - Configuration file

/opt/lighthouse/lighthouse_audit.py - Main audit script

/etc/systemd/system/lighthouse.service - Systemd service

/var/log/lighthouse/audit.log - Application logs

Verification
bash
# Check service status
systemctl status lighthouse

# Run manual audit
sudo -u lighthouse /opt/lighthouse/venv/bin/python /opt/lighthouse/lighthouse_audit.py

# Check logs
tail -f /var/log/lighthouse/audit.log
Dependencies
clickhouse role (for ClickHouse database)

vector role (optional, for log shipping)

License
MIT
