1. Создать таблицу
CREATE TABLE genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_genre VARCHAR(30)
);


2. Сформулируйте SQL запрос для создания таблицы book
Поле	    Тип, описание
book_id	    INT PRIMARY KEY AUTO_INCREMENT
title	    VARCHAR(50)
author	    VARCHAR(30)
price	    DECIMAL(8, 2)
amount	    INT

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT
    , title VARCHAR(50)
    , author VARCHAR(30)
    , price DECIMAL(8, 2)
    , amount INT
);


3. Добавть данные в таблицу
INSERT INTO таблица(поле1, поле2) 
VALUES (значение1, значение2);

INSERT INTO genre (name_genre) 
VALUES ('Роман');
/*-------------------------------------------*/
INSERT INTO book (title, author, price, amount)
VALUES ("Мастер и Маргарита", "Булгаков М.А.", 670.99, 3);

INSERT INTO book (title, author, price, amount)
VALUES ("Белая гвардия", "Булгаков М.А.", 540.50, 5);

INSERT INTO book (title, author, price, amount)
VALUES ("Идиот", "Достоевский Ф.М.", 460.00, 10);

INSERT INTO book (title, author, price, amount)
VALUES ("Братья Карамазовы", "Достоевский Ф.М.", 799.01, 2);

4. Выбрать авторов, название книг и их цену из таблицы book
SELECT 
author
, title
, price
from book;

5. Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор. 
SELECT title AS Название
, author AS Автор
FROM book;

6. Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack. 
select title
, amount
, amount * 1.65 AS pack
from book;