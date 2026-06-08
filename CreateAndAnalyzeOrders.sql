CREATE PROCEDURE CreateAndAnalyzeOrders 
 @IsDelTables BIT = 0 
AS
BEGIN
    SET NOCOUNT ON;

    -- если таблицы существуют
    IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
    IF OBJECT_ID('goods', 'U') IS NOT NULL DROP TABLE goods;
    IF OBJECT_ID('clients', 'U') IS NOT NULL DROP TABLE clients;

    -- таблица клиентов
    CREATE TABLE clients (
        id_clients INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(100) NOT NULL
    );
 
    INSERT INTO clients (name) VALUES
    ('Иван'), ('Федор'), ('Степан'), ('Марья'), ('Антон'),
    ('Николай'), ('Петр'), ('Анна'), ('Мария'), ('Дмитрий');

    -- таблица товаров
    CREATE TABLE goods (
        id_goods INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(200) NOT NULL
    );


    INSERT INTO goods (name) VALUES
    ('Масло моторное'), ('Масло трансмиссионное'), ('Антифриз'),
    ('Жидкость тормозная'), ('Стекло лобовое'), ('Колодки тормозные'),
    ('Бампер'), ('Свеча зажигания'), ('Аккумулятор'),
    ('Фильтр масляный'), ('Фильтр воздушный');

    -- таблица заказов 
    CREATE TABLE orders (
        id_orders INT IDENTITY(1,1) PRIMARY KEY,
        id_clients INT NOT NULL,
        id_goods INT NOT NULL
    );

    -- индексы 
    CREATE INDEX I_clients ON orders(id_clients);
    CREATE INDEX I_goods ON orders(id_goods);

    -- заполнегние orders 
    DECLARE @i INT = 0;
    WHILE @i < 1000000
    BEGIN
        INSERT INTO orders (id_clients, id_goods)
        VALUES (
            ABS(CHECKSUM(NEWID())) % 10 + 1,  -- Случайный id_clients от 1 до 10
            ABS(CHECKSUM(NEWID())) % 11 + 1   -- Случайный id_goods от 1 до 11
        );
        SET @i = @i + 1;
    END;

    -- ТОП 5 клиентов с max количеством заказов
    SELECT TOP 5
        c.name AS client_name,
        COUNT(o.id_orders) AS orders_count
    FROM clients c
    JOIN orders o ON c.id_clients = o.id_clients
    GROUP BY c.id_clients, c.name
    ORDER BY COUNT(o.id_orders) DESC;

 IF @IsDelTables = 1
    BEGIN
        DROP TABLE orders;
        DROP TABLE goods;
        DROP TABLE clients;
    END
END;
GO
