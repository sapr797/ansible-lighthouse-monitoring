# Ansible Role: vector

## Description
Installs and configures Vector log shipper for sending Lighthouse audit logs to ClickHouse.

## Requirements
- Ansible 2.9+
- Ubuntu/Debian system
- ClickHouse server

## Role Variables
| Variable | Default | Description |
|----------|---------|-------------|
| `vector_version` | `"0.28.0"` | Vector version to install |
| `clickhouse_host` | `localhost` | ClickHouse server host |
| `clickhouse_port` | `8123` | ClickHouse HTTP port |
| `clickhouse_user` | `default` | ClickHouse username |
| `clickhouse_password` | `""` | ClickHouse password |

## Example Playbook
```yaml
- hosts: log_servers
  roles:
    - role: vector
      vars:
        clickhouse_host: "clickhouse.internal"
        clickhouse_user: "vector_user"
Tasks
Installs Vector from package repository

Configures Vector to read Lighthouse logs

Sets up ClickHouse sink configuration

Starts and enables Vector service

Configuration Files
/etc/vector/lighthouse.conf - Vector configuration

/etc/systemd/system/vector.service - Service file

Dependencies
Requires ClickHouse server to be available

Works alongside lighthouse role

License
MIT
