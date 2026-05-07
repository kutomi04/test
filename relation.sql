//保育園テーブル
CREATE table customers(
    customer_id int PRIMARY KEY  AUTO_INCREMENT,--保育園ID
    customer_name varchar(100) NOT NULL,        --保育園名
    customer_email varchar(255),                --保育園アドレス
    customer_phone varchar(100),                --保育園電話
    customer_prefecture varchar(10),            --保育園県名
    customer_city varchar(50),                  --保育園市区町村
    customer_adress_build varchar(200)          --保育園番地・建物
);

//在庫テーブル
CREATE table stocks(
    stock_id varchar(30) PRIMARY KEY,           --在庫NO
    stock_name varchar(100) NOT NULL,           --在庫商品名
    stock_category varchar(20) NOT NULL,        --在庫カテゴリー
    stock_count int DEFAULT 0 NOT NULL,         --在庫数
    stock_low int NOT NULL,                     --最低在庫数
    stock_statute varchar(30) NOT NULL          --在庫状態
);

//出荷予定/履歴テーブル
CREATE table shippings(
    shipping_id int PRIMARY KEY AUTO_INCREMENT, -- 出荷管理番号
    stock_id varchar(30) NOT NULL,              -- 在庫NO
    customer_id int NOT NULL,                   -- 保育園NO
    shipping_count int NOT NULL DEFAULT 0,      --　個数
    shippings_scheduled_date DATE NOT NULL,     -- 出荷予定日
    shipping_actual_date DATE,                  -- 実際の出荷完了日（NULLなら未出荷）
    shipping_status int NOT NULL DEFAULT 0,     -- 0:予定, 1:完了, 9:キャンセル
    
    -- shippingsテーブルに削除フラグを追加
    ALTER table shippings ADD COLUMN is_deleted BOOLEAN DEFAULT false;
    
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_stock FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

//出荷予定/履歴 追加
INSERT INTO shippings (
    stock_id, 
    customer_id, 
    shipping_count, 
    shippings_scheduled_date, 
    shipping_status  -- 0:予定として登録

) VALUES (
    ?, -- 画面で選んだ在庫NO
    ?, -- 画面で選んだ保育園ID
    ?, -- 画面で入力した個数
    ?, -- 画面で選んだ出荷日付
    0, --　出荷予定としてデフォルト登録
);

//出荷予定削除(論理削除)
UPDATE shippings
SET 
  shipping_status = 1,                 -- 完了ステータス
  shipping_actual_date = CURRENT_DATE  -- 今日の日付を入れる
WHERE shipping_id = ? AND is_deleted = false; --true出荷履歴のデータ(出荷済),false出荷予定のデータ(未出荷)

//ユーザー
CREATE TABLE users(
        user_mail varchar(255) PRIMARY KEY,
        user_password varchar(255)
);
-----テスト
-- 在庫の挿入
INSERT INTO stocks (stock_id, stock_name, stock_category, stock_count, stock_low, stock_statute)
VALUES ('Z1', 'おしりふきS', 'おしりふき', 100, 10, '在庫あり');

-- ユーザーの挿入 (user_mail を主キーに合わせる)
INSERT INTO users (user_mail, user_password)
VALUES ('test@example.com', 'user_password123');

-- 保育園の挿入 (出荷予定をテストするために必要)
INSERT INTO customers (customer_name, customer_city)
VALUES ('たんぽぽ保育園', '名古屋市');