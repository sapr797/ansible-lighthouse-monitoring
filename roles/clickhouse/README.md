# ClickHouse Database Role

## Description
Deploys ClickHouse database server for the Lighthouse monitoring system.
This is a local copy of the external role from AlexeySetevoi.

## Original Source
- Repository: https://github.com/AlexeySetevoi/ansible-clickhouse
- Version: 1.13
- License: MIT

## Role Variables
Key variables used in our project:

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `clickhouse_version` | "25.11.2.24" | ClickHouse version to install |
| `clickhouse_install_method` | "package" | Installation method |
| `clickhouse_skip_install` | false | Skip installation if already installed |

## Usage in Lighthouse Project
```yaml
- hosts: clickhouse_servers
  roles:
    - role: clickhouse
      vars:
        clickhouse_version: "25.11.2.24"
        clickhouse_install_method: "package"
Modifications for Our Project
Database setup: Extended to create lighthouse database automatically

Network configuration: Configured to allow remote connections from Lighthouse server

Table creation: Added tasks to create reports table for audit data

Related Files
playbooks/deploy-all.yml - Main deployment playbook

inventory/hosts - Example inventory with clickhouse_servers group
