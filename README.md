# Lighthouse Monitoring System - Ansible Deployment

## Project Overview
Complete monitoring system for website performance audits using Google Lighthouse and ClickHouse.

## Quick Start
```bash
# Clone with submodules
git clone --recursive https://github.com/sapr797/ansible-lighthouse-monitoring.git

# Or clone and init submodules separately
git clone https://github.com/sapr797/ansible-lighthouse-monitoring.git
cd ansible-lighthouse-monitoring
git submodule init
git submodule update

# Deploy
ansible-playbook -i inventory/hosts playbooks/deploy-all.yml
Repository Structure
text
ansible-lighthouse-monitoring/          # This repository
├── roles/
│   ├── clickhouse/                    # Local copy
│   ├── lighthouse/                    # Git submodule → https://github.com/sapr797/ansible-role-lighthouse
│   └── vector/                       # Git submodule → https://github.com/sapr797/ansible-role-vector
├── playbooks/
├── inventory/
└── docs/
Role Repositories
RoleRepositoryDescription
lighthouse-sapr797/ansible-role-lighthouseMain audit system role
vectorsapr797/ansible-role-vectorLog shipping role
clickhouseLocal copy of AlexeySetevoi/ansible-clickhouseDatabase role
Complete Deployment
yaml
# playbooks/deploy-all.yml
---
- name: Deploy Complete System
  hosts: all
  vars:
    lighthouse_user: lighthouse
    audit_sites:
      - https://voronezh.poryadok.ru
      - https://krasnodar.poryadok.ru
      - https://poryadok.ru
  
  roles:
    - clickhouse    # Local role
    - lighthouse    # From GitHub
    # - vector      # Optional from GitHub
Development
Update Submodules
bash
# Update to latest versions
git submodule update --remote

# Or update specific role
cd roles/lighthouse
git pull origin main
cd ../..
git add roles/lighthouse
git commit -m "Update lighthouse role"
License
MIT

Links
Main Project

Lighthouse Role

Vector Role
