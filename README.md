# Lighthouse Monitoring System - Ansible Развёртывание

Полная система мониторинга для аудита производительности веб-сайтов с использованием Google Lighthouse и ClickHouse.

## 📦 Состав системы

| Компонент | Назначение | Репозиторий |
|-----------|------------|-------------|
| **ClickHouse** | Хранение результатов аудитов | [Локальная копия AlexeySetevoi/ansible-clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse) |
| **Lighthouse** | Аудит производительности сайтов | [sapr797/ansible-role-lighthouse](https://github.com/sapr797/ansible-role-lighthouse) |
| **Vector** | Сбор и пересылка логов | [sapr797/ansible-role-vector](https://github.com/sapr797/ansible-role-vector) |

## 🚀 Быстрый старт

### Клонирование репозитория
# Система Мониторинга Lighthouse - Ansible Развёртывание

## Обзор проекта
Полная система мониторинга для аудита производительности веб-сайтов с использованием Google Lighthouse и ClickHouse.

## Быстрый старт
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
# Клонировать с подмодулями
git clone --recursive https://github.com/sapr797/ansible-lighthouse-monitoring.git

# Или клонировать и инициализировать подмодули отдельно
git clone https://github.com/sapr797/ansible-lighthouse-monitoring.git
cd ansible-lighthouse-monitoring
git submodule init
git submodule update

Развёртывание системы
# Развернуть всю систему
ansible-playbook -i inventory/hosts playbooks/deploy-all.yml
📁 Структура репозитория

# Развернуть систему
ansible-playbook -i inventory/hosts playbooks/deploy-all.yml
Структура репозитория

>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
ansible-lighthouse-monitoring/          # Этот репозиторий
├── roles/                              # Роли Ansible
│   ├── clickhouse/                     # Локальная копия
│   ├── lighthouse/                     # Git submodule → https://github.com/sapr797/ansible-role-lighthouse
│   └── vector/                         # Git submodule → https://github.com/sapr797/ansible-role-vector
├── playbooks/                          # Плейбуки Ansible
├── inventory/                          # Инвентарь (списки хостов)
├── docs/                               # Документация
<<<<<<< HEAD
├── configs/                            # Конфигурационные файлы
│   ├── vector/vector.yaml.example      # Пример конфигурации Vector
│   └── clickhouse/create_tables.sql    # SQL для создания таблиц
├── templates/                          # Шаблоны конфигурации
├── .cat                                # Конфигурационный файл
├── requirements.yml                    # Зависимости ролей
├── deploy-roles.yml                    # Плейбук для развёртывания ролей
├── deploy-lighthouse.yml               # Основной плейбук развёртывания
└── README.md                           # Этот файл
🛠️ Документация по ролям

├── .cat                                # Конфигурационный файл
├── requirements.yml                    # Зависимости ролей
├── deploy-roles.yml                    # Плейбук для развёртывания ролей
└── README.md                           # Этот файл
📦 Документация по ролям
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
🚀 Роль: lighthouse
Назначение: Основная роль системы аудита - устанавливает и настраивает Google Lighthouse.

Репозиторий: https://github.com/sapr797/ansible-role-lighthouse.git

Описание: Роль для развёртывания системы мониторинга производительности веб-сайтов. Выполняет регулярные аудиты указанных сайтов с сохранением результатов.

Переменные по умолчанию: Роль не предоставляет переменные в defaults/main.yml. Конфигурация управляется через:

Переменные по умолчанию:
Роль не предоставляет переменные в defaults/main.yml. Конфигурация управляется через:
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
Выполнение задач в плейбуках

Переменные инвентаря

Переопределения для окружений

Пример использования:

yaml
- name: Развернуть Lighthouse

Пример использования в плейбуке:

yaml
- name: Deploy Lighthouse
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
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


🔄 Конфигурация интеграции
Vector → ClickHouse
Конфигурационный файл Vector (/etc/vector/vector.yaml):

yaml
sources:
  lighthouse_logs:
    type: file
    include: ["/var/log/lighthouse/audit.log"]
    ignore_older_secs: 600
    read_from: "beginning"

sinks:
  clickhouse_sink:
    type: clickhouse
    inputs: ["lighthouse_logs"]
    endpoint: "http://127.0.0.1:8123"
    database: "lighthouse_metrics"
    table: "audits"
    skip_unknown_fields: true
    format: "json_each_row"
Структура таблицы ClickHouse
sql
-- Создание базы данных и таблиц для Lighthouse Monitoring System
CREATE DATABASE IF NOT EXISTS lighthouse_metrics;

CREATE TABLE IF NOT EXISTS lighthouse_metrics.audits (
  timestamp DateTime DEFAULT now(),
  url String,
  performance Float32,
  accessibility Float32,
  best_practices Float32,
  seo Float32,
  pwa Float32
) ENGINE = MergeTree()
ORDER BY timestamp;

-- Индекс для быстрого поиска по URL
ALTER TABLE lighthouse_metrics.audits ADD INDEX url_index url TYPE minmax GRANULARITY 1;
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
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

Мониторинг логов
bash
# Просмотр логов аудита
tail -f /var/log/lighthouse/audit.log

# Проверка конфигурации
cat {{ lighthouse_dir }}/config.ini
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
🔄 Обновление подмодулей
# Обновить до последних версий
git submodule update --remote

# Или обновить конкретную роль
cd roles/lighthouse
git pull origin main
cd ../..
git add roles/lighthouse
git commit -m "Обновление роли lighthouse"

🔗 Связи между компонентами
text
Аудиты Lighthouse → Логи → Vector (сбор) → ClickHouse (хранение)
Процесс развёртывания:
Развернуть ClickHouse на clickhouse_servers

Развернуть Vector на lighthouse_servers (указывает на ClickHouse)


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
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
Развернуть Lighthouse на lighthouse_servers (логи обрабатываются Vector)

💻 Разработка
Добавление новых сайтов для аудита
Измените переменную audit_sites в плейбуке deploy-all.yml или создайте отдельный плейбук для конфигурации.

Скрипт автоматического аудита

# Запуск аудита вручную
sudo /opt/lighthouse/mock-audit-fixed.sh

# Проверка результатов
clickhouse-client --query "SELECT * FROM lighthouse_metrics.audits ORDER BY timestamp DESC LIMIT 5"

Мониторинг логов

# Просмотр логов аудита
tail -f /var/log/lighthouse/audit.log

# Проверка конфигурации
cat {{ lighthouse_dir }}/config.ini
>>>>>>> 0101c6c117bb9229126b29a34a7c698464d111ab
📞 Поддержка и ссылки
Основной проект: https://github.com/sapr797/ansible-lighthouse-monitoring

Роль Lighthouse: https://github.com/sapr797/ansible-role-lighthouse

Роль Vector: https://github.com/sapr797/ansible-role-vector

Роль ClickHouse: https://github.com/AlexeySetevoi/ansible-clickhouse (внешняя зависимость)

>>> 0101c6c117bb9229126b29a34a7c698464d111ab
📄 Лицензия
MIT

