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

-- Статистическая таблица
CREATE TABLE IF NOT EXISTS lighthouse_metrics.daily_stats (
  date Date,
  url String,
  avg_performance Float32,
  avg_accessibility Float32,
  audit_count UInt32
) ENGINE = SummingMergeTree()
ORDER BY (date, url);
