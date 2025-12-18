# System Architecture

## Component Diagram
┌─────────────────┐ Audit ┌─────────────────┐
│ │──────────────>│ │
│ Lighthouse │ │ Websites │
│ Server │<──────────────│ │
│ (lighthous) │ Metrics │ │
└────────┬────────┘ └─────────────────┘
│ Store
│ Results
▼
┌─────────────────┐
│ │
│ ClickHouse │
│ Database │
│ (clickhous) │
│ │
└─────────────────┘

text

## Data Flow
1. **Audit Trigger**: Systemd/cron запускает `lighthouse_audit.py`
2. **Data Collection**: Скрипт подключается к сайтам (пока заглушка)
3. **Data Storage**: Метрики сохраняются в ClickHouse таблицу `reports`
4. **Logging**: Все операции логируются в `/var/log/lighthouse/audit.log`

## Database Schema
```sql
CREATE TABLE lighthouse.reports (
    id UUID DEFAULT generateUUIDv4(),
    site String,
    performance Float32,
    accessibility Float32,
    best_practices Float32,
    seo Float32,
    pwa Float32,
    timestamp DateTime DEFAULT now(),
    report_path String
) ENGINE = MergeTree()
ORDER BY (site, timestamp)
SETTINGS index_granularity = 8192;
