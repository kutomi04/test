//保育園のデータ
CREATE table customers(
    customer_id int PRIMARY KEY  AUTO_INCREMENT,
    customer_name varchar(100) NOT NULL,
    customer_email varchar(255),
    customer_phone varchar(100),
    customer_address varchar(255)

);
//在庫のデータ
CREATE table stocks(
    stock_id  int PRIMARY KEY  AUTO_INCREMENT,
    stock_name varchar(100) NOT NULL,
    stock_count int DEFAULT 0
);


//出荷履歴のデータ
CREATE table  shippings(
    shipping_id int PRIMARY KEY  AUTO_INCREMENT,
    stock_id int NOT NULL,
    customer_id int NOT NULL,
    shipping_count int NOT NULL DEFAULT 0,
    shipping_date DATE NOT NULL,
    --  CONSTRAINTで参照整合性を保持する
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_stock FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);
//--------------------------------------------------------
//DBML形式
//保育園のデータ
table customers{
    customer_id int [PRIMARY KEY]
    customer_name varchar
    customer_email varchar
    customer_phone varchar
    customer_address varchar
    created_at DATETIME
}
//商品のデータ
table items{
    items_id  int
    items_name varchar
    items_price DECIMAL
    items_stock int
}
//営業のデータ
table sales{
    sale_id int
    sale_name varchar
}