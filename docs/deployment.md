
Deployment Guide
Prerequisites
Two Ubuntu servers (or one for testing)

SSH access between servers

Ansible 2.9+ on control node

Server Requirements
ServerRoleRequirements
lighthouse-Lighthouse Auditor2GB RAM, 10GB disk
clickhousClickHouse Database4GB RAM, 20GB disk
Step-by-Step Deployment
1. Clone Repository
bash
git clone https://github.com/USERNAME/ansible-lighthouse-monitoring.git
cd ansible-lighthouse-monitoring
2. Configure Inventory
Edit inventory/hosts:

ini
[lighthouse_servers]
lighthous ansible_host=192.168.1.100 ansible_user=ubuntu

[clickhouse_servers]
clickhous ansible_host=192.168.1.101 ansible_user=ubuntu
3. Install Dependencies
bash
ansible-galaxy install -r requirements.yml
4. Deploy System
bash
ansible-playbook -i inventory/hosts playbooks/deploy-all.yml
5. Verify Deployment
bash
ansible-playbook lighthouse-status.yml
