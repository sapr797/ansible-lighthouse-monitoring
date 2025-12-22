# Система Мониторинга Lighthouse - Ansible Развёртывание

## Обзор проекта
Полная система мониторинга для аудита производительности веб-сайтов с использованием Google Lighthouse и ClickHouse.

## Быстрый старт
# Клонировать с подмодулями
git clone --recursive https://github.com/sapr797/ansible-lighthouse-monitoring.git

# Или клонировать и инициализировать подмодули отдельно
git clone https://github.com/sapr797/ansible-lighthouse-monitoring.git
cd ansible-lighthouse-monitoring
git submodule init
git submodule update

# Развернуть систему
ansible-playbook -i inventory/hosts playbooks/deploy-all.yml
Структура репозитория

ansible-lighthouse-monitoring/          # Этот репозиторий
├── roles/                              # Роли Ansible
│   ├── clickhouse/                     # Локальная копия
│   ├── lighthouse/                     # Git submodule → https://github.com/sapr797/ansible-role-lighthouse
│   └── vector/                         # Git submodule → https://github.com/sapr797/ansible-role-vector
├── playbooks/                          # Плейбуки Ansible
├── inventory/                          # Инвентарь (списки хостов)
├── docs/                               # Документация
├── .cat                                # Конфигурационный файл
├── requirements.yml                    # Зависимости ролей
├── deploy-roles.yml                    # Плейбук для развёртывания ролей
└── README.md                           # Этот файл
📦 Документация по ролям
🚀 Роль: lighthouse
Назначение: Основная роль системы аудита - устанавливает и настраивает Google Lighthouse.

Репозиторий: https://github.com/sapr797/ansible-role-lighthouse.git

Описание: Роль для развёртывания системы мониторинга производительности веб-сайтов. Выполняет регулярные аудиты указанных сайтов с сохранением результатов.

Переменные по умолчанию:
Роль не предоставляет переменные в defaults/main.yml. Конфигурация управляется через:

Прямое выполнение задач в плейбуках

Переменные инвентаря

Переопределения для окружений

Пример использования в плейбуке:

yaml
- name: Deploy Lighthouse
  hosts: lighthouse_servers
  vars:
    lighthouse_user: lighthouse
    audit_sites:
      - https://example.com
      - https://test.site.com
  roles:
    - lighthouse
📊 Роль: vector
Назначение: Роль для пересылки логов - устанавливает и настраивает Vector.

Репозиторий: https://github.com/sapr797/ansible-role-vector.git

Описание: Настраивает сбор, обработку и отправку логов аудита в базу данных ClickHouse.

Переменные по умолчанию:

yaml
# Версия Vector для установки
vector_version: "0.28.0"

# Настройки подключения к ClickHouse
clickhouse_host: localhost
clickhouse_port: 8123
clickhouse_user: default
clickhouse_password: ""  # По умолчанию пусто
Пример использования:

yaml
- name: Deploy Vector
  hosts: lighthouse_servers
  roles:
    - vector
  vars:
    clickhouse_host: "10.128.0.25"  # IP вашего сервера clickhous
🗄️ Роль: clickhouse
Назначение: Роль базы данных - устанавливает и настраивает ClickHouse.

Источник: Локальная копия на основе AlexeySetevoi/ansible-clickhouse

Описание: Развёртывает и настраивает СУБД ClickHouse для хранения результатов аудита Lighthouse.

🎯 Полное развёртывание системы
yaml
# playbooks/deploy-all.yml
---
- name: Развернуть полную систему
  hosts: all
  vars:
    lighthouse_user: lighthouse
    audit_sites:
      - https://voronezh.poryadok.ru
      - https://krasnodar.poryadok.ru
      - https://poryadok.ru

  roles:
    - clickhouse    # Локальная роль
    - lighthouse    # Из GitHub (подмодуль)
    # - vector      # Опционально из GitHub
🔧 Использование системы
Проверка статуса
bash
ansible-playbook -i inventory/hosts playbooks/lighthouse-status.yml
Полная проверка
bash
ansible-playbook -i inventory/hosts playbooks/lighthouse-complete.yml
Развёртывание только ролей
bash
ansible-playbook deploy-roles.yml
🔄 Обновление подмодулей
bash
# Обновить до последних версий
git submodule update --remote

# Или обновить конкретную роль
cd roles/lighthouse
git pull origin main
cd ../..
git add roles/lighthouse
git commit -m "Обновление роли lighthouse"
📋 Роли и их репозитории
Роль	Репозиторий	Описание
lighthouse	sapr797/ansible-role-lighthouse	Основная роль системы аудита
vector	sapr797/ansible-role-vector	Роль пересылки логов
clickhouse	Локальная копия AlexeySetevoi/ansible-clickhouse	Роль базы данных
🔗 Связи между компонентами
Аудиты Lighthouse → Логи → Vector (сбор) → ClickHouse (хранение)
Процесс развёртывания:
Развернуть ClickHouse на clickhouse_servers
Развернуть Vector на lighthouse_servers (указывает на ClickHouse)
Развернуть Lighthouse на lighthouse_servers (логи обрабатываются Vector)

💻 Разработка
Добавление новых сайтов для аудита
Измените переменную audit_sites в плейбуке deploy-all.yml или создайте отдельный плейбук для конфигурации.

Мониторинг логов
bash
# Просмотр логов аудита
tail -f /var/log/lighthouse/audit.log

# Проверка конфигурации
cat {{ lighthouse_dir }}/config.ini
📞 Поддержка и ссылки
Основной проект: https://github.com/sapr797/ansible-lighthouse-monitoring

Роль Lighthouse: https://github.com/sapr797/ansible-role-lighthouse

Роль Vector: https://github.com/sapr797/ansible-role-vector

📄 Лицензия
MIT

