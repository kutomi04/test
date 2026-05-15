//保育園テーブル
CREATE table customers(
    customer_id varchar(100) PRIMARY KEY ,      --保育園ID
    customer_name varchar(100) NOT NULL,        --保育園名
    cusotmer_post varchar(100) NOT NULL,        --郵便番号
    customer_prefecture varchar(10),            --保育園県名
    customer_city varchar(50),                  --保育園市区町村
    customer_build varchar(255),                --保育園建物
    customer_phone number,                --保育園電話
    customer_capacity int,                      --定員
    customer_agerange varchar(30)              --対象年齢        
);   

//製品テーブル
CREATE table products(
    product_id varchar(30) PRIMARY KEY,           --商品NO
    product_name varchar(100) NOT NULL,           --商品名
    product_count int DEFAULT 0 NOT NULL,         --在庫数
    product_low int NOT NULL,                     --最低在庫数
    category    string NOT NULL,                  --カテゴリー
    product_statute varchar(30) NOT NULL          --在庫状態
    is_deleted BOOLEAN DEFAULT FALSE,             --削除
);

//出荷予定/履歴テーブル
CREATE table shippings(
    shipping_id varchar(100) PRIMARY KEY ,      -- 出荷管理番号
    shipping_date date,                         --出荷日
    product_id varchar(30) NOT NULL,            -- 商品NO　PK　　参照
    product_name varchar(100),                  --商品名　参照
    customer_id int NOT NULL,                   -- 保育園NO 参照
    shipping_count int NOT NULL DEFAULT 0,      --出荷数
    category      string NOT NULL,              --カテゴリー
    shippings_scheduled_date DATE NOT NULL,     -- 出荷予定日
    shipping_actual_date DATE,                  -- 実際の出荷完了日（NULLなら未出荷）
    shipping_status int NOT NULL DEFAULT 0,     -- 0:予定, 1:完了, 9:キャンセル
);
    -- shippingsテーブルに削除フラグを追加
    ALTER table shippings ADD COLUMN is_deleted BOOLEAN DEFAULT false;
    
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

//カテゴリーID
CREATE table category(

);
//出荷予定 追加
INSERT INTO shippings (
    product_id, 
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



//ユーザー
CREATE TABLE users(
        user_mail varchar(255) PRIMARY KEY,
        user_password varchar(255)
);
-----テスト
-- 在庫の挿入
INSERT INTO products (product_id, product_name, product_category, product_count, product_low, product_statute)
VALUES ('Z1', 'おしりふきS', 'おしりふき', 100, 10, '在庫あり');

-- ユーザーの挿入 (user_mail を主キーに合わせる)
INSERT INTO users (user_mail, user_password)
VALUES ('test@example.com', 'user_password123');

-- 保育園の挿入 (出荷予定をテストするために必要)
INSERT INTO customers (customer_name, customer_city)
VALUES ('たんぽぽ保育園', '名古屋市');