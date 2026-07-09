-- استورد الملف ده في phpMyAdmin (أو mysql CLI) على قاعدة بيانات فاضية
-- بعد ما تعمل القاعدة من لوحة تحكم الاستضافة (cPanel وغيرها).

CREATE TABLE IF NOT EXISTS users (
  id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(150) NOT NULL,
  phone         VARCHAR(30)  NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at    DATETIME     NOT NULL,
  UNIQUE KEY uniq_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS trips (
  id                INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id           INT UNSIGNED NOT NULL,
  trip_name         VARCHAR(255) DEFAULT '',
  driver_name       VARCHAR(150) DEFAULT '',
  trip_date         DATE NULL,
  cargo_weight      VARCHAR(30) DEFAULT '',
  funded            DECIMAL(12,2) NOT NULL DEFAULT 0,
  fund_extras_json  JSON NULL,
  items_json        JSON NULL,
  total             DECIMAL(12,2) NOT NULL DEFAULT 0,
  remain            DECIMAL(12,2) NOT NULL DEFAULT 0,
  save_title        VARCHAR(255) DEFAULT '',
  saved_at          DATETIME NOT NULL,
  created_at        DATETIME NOT NULL,
  updated_at        DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_trips_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_saved (user_id, saved_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
