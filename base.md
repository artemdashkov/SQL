- [Теория. Определения.](#теория-определения)
- [Типы данных в SQL](#типы-данных-в-sql)
- [SELECT Таблицы](#select-таблицы)
- [Сортировка данных - ORDER BY](#сортировка-данных---order-by)
- [Ограничения (LIMIT И OFFSET)](#ограничения-limit-и-offset)


# Теория. Определения.

**База данных** — это организованная структура для хранения, изменения и обработки взаимосвязанной информации. Обычно базы данных используют для взаимодействия с большими объёмами данных. Практически ни одна большая компания (от интернет-магазинов до банков) сейчас не обходится без использования баз данных.

КАКИЕ БАЗЫ ДАННЫХ СУЩЕСТВУЮТ?
- Реляционные базы данных: В них данные хранятся в виде связанных таблиц. Три кита: связи, таблицы, структура.

- Нереляционные базы данных: В них данные хранятся иначе, например в формате ключ-значение или в виде дерева

**Система Управления Базами Данных (СУБД, DBMS — DataBase Management System)** — это комплекс программных средств, необходимых для создания структуры новой базы, ее наполнения, редактирования содержимого и отображения информации.

Для работы с данными, хранящимися в БД, используется специальный язык — SQL.

СУБД бывают разные, и языки для них тоже отличаются, являясь диалектами SQL. Наиболее распространенными СУБД являются:
- MySQL,
- PostgreSQL,
- Oracle,
- Microsoft SQL Server.

Для очень большого объёма данных также используют ClickHouse, Hadoop и другие СУБД.

**SQL (Structured Query Language)** - язык запросов применяется для создания, модификации и управления данными. 

```sql
-- получить все данные из таблицы city схемы sql
SELECT *
FROM sql.city
```
- `SELECT` - отвечает за то, какие колонки будут выбираться из данных.
- `*` - означает всё, т.е. выбрать все
- `FROM` -откуда, из какой таблицы эти данные.
- `sql` - название схемы
- `city` - название таблицы
- `,` - обязательный знак при перечислении
- `--` - комментировать строку
- `/* */` - если нужно закомментировать большой кусок
- `WHERE` -фильтрацию строк в данных

**Структура запроса в SQL**:
- ВЫБЕРИ (SELECT) колонки column_names
- ИЗ (FROM) ТАБЛИЦЫ table_name,
- ДЛЯ СТРОК КОТОРЫХ ВЫПОЛНЕНЫ УСЛОВИЯ (WHERE) conditions.

Первичный ключ - уникальный индентификатор строки. По нему можно вытянуть строку. Подмножество столбцов, которое уникально идентифицирует строку. Часто в качестве первичного ключа берут просто ID объекта, например, ID пользователя или ID покупки.

Для численных типов данных в SQL используются традиционные арифметические операторы:
- `+`	- Сложение
- `-`	- Вычитание
- `*`	- Умножение
- `/`	- Деление
- `%`	- Остаток от деления
Пример:
```sql
select 3/5; -- >>> 0
select 3./5; -- >>> 0.6000000
select 2+3; -- >>> 5
select 2.0 + 3.0; -- >>> 5.0
select (2+2)*2 -- >>> 8
```

# Типы данных в SQL
- integer (или bigint) — используется для больших чисел;
- numeric — он особенно рекомендуется для хранения денежных сумм и других величин, где важна точность;
- serial — используется для создания первичных ключей таблицы (обычно для создания ID строки). Он очень удобен, так как при добавлении строк в таблицу сам проставляет им уникальный ID на 1 больше, чем предыдущий проставленный ID;
- real — подходит для чисел, где хорошая точность не очень нужна.

**СИМВОЛЬНЫЕ**
- character varying(n), varchar(n) — строка ограниченной переменной длины, для коротких строк (до 255 символов)
- character(n), char(n)	— строка фиксированной длины, дополненная пробелами
- text — строка неограниченной переменной длины, для строк, длина которых заранее не известна, но известно, что она может быть больше 255 символов.

**Типы данных для даты и времени:**
- timestamp [ (p) ] [ without time zone ]	8 байт	дата и время (без часового пояса)	1 микросекунда / 14 цифр	2019-3-1 12:00:00'
- timestamp [ (p) ] with time zone	8 байт	дата и время (с часовым поясом)	1 микросекунда / 14 цифр	2019-3-1 12:00:00+2'
- date	4 байта	дата (без времени суток)	1 день	2019-3-1'
- time [ (p) ] [ without time zone ]	8 байт	время суток (без даты)	1 микросекунда / 14 цифр	12:00:00'
- time [ (p) ] with time zone	12 байт	только время суток (с часовым поясом)	1 микросекунда / 14 цифр	12:00:00+2
- interval [ поля ] [ (p) ]	16 байт	временной интервал	1 микросекунда / 14 цифр	interval '2 years'

- bool - бинарный тип данных,данные в котором хранятся в виде true или false. 
- json. В json данные хранятся в формате key : value
- и любые другие пользовательские типы

```sql
select 2.13::int; --Перевод real в int >>> 2
select '2018-3-1'::date; --Перевод строки в дату >>> март 1, 2018
select true::int::numeric; --Перевод bool в int, а потом в numeric >>> 1
```

Также однотипные данные можно сравнивать друг с другом (например, int и numeric, text и varchar, timestamp и date)
```sql
select 2 = 3; --false
select 3 < 5; --true
select 'hi' != 'hello'; --true
select 3 >= -23; --true
```

Такие же операторы равенства и неравенства можно использовать и для сравнения однотипных данных в столбцах:
```sql
select author = book_name as author_book
from books;
```

# SELECT Таблицы

```sql
-- получить данные только по колонками city_id и city_name таблицы city схемы sql
SELECT city_id
, city_name --рекомендуется запятые переносить на строку, т.к. удобно исключать элемент путем комментирования 
FROM sql.city
```

```sql
SELECT city_id
, city_name
, state
, population - 50052 as populationWOfans -- выведет результат вычитания 'population - 50052' в колонке populationWOfans
, population/area as populationDensity -- выведет результат деления одного столбца на другой в каждой строке
, population/nullif((area-3), 0) as densityWO3m2 --выведет null если результат вычитания равен 0. для других случаев выведет значение
, area
FROM sql.city c
```

NULLIF(expr1, expr2). Эта функция при равенстве expr1 и expr2 возвращает NULL, а иначе — expr1. 

# Поиск
```sql
SELECT *
FROM [table]
WHERE [bool - ДА/НЕТ] AND [bool2 - ДА/НЕТ] OR [bool3 - ДА/НЕТ]
```
- `WHERE` - ГДЕ. SQL будет проверять каждую строчку на предмет 'да' или 'нет'. Можно добавить любую длину условий, которые соединяются ключевым словом 'AND' или 'OR'

=, <>, !=, <, >, <=, >=, BETWEEN [1] AND [2], NOT, IS
- <>, != - не равно можно записывать разными способами
- NOT - логическое НЕ 
- IS - используется для Null, так как NULL в принципе нельзя ни с чем сравнить, то в запросах сравнения он не выводится.
- BETWEEN - включает границы

```sql
SELECT city_name
, state
FROM sql.city
WHERE area <= 3
```

```sql
-- оператор BEETWEEN
book_average_rating between 3 and 4 -- это то же самое, что и
book_average_rating >= 3 and book_average_rating <= 4

-- ОПЕРАТОР NULL
select * 
from books 
where language_code is null;

-- отрицание условия
where book_average_rating < 4 -- это то же самое, что и
where not book_average_rating >= 4
```
### Кортеж
В случае реляционных БД кортеж — это строка в таблице. Для поиска по строкам (кортежам) используется ключевое слово WHERE, после которого перечисляются условия на кортежи данных. 


# Сортировка данных - ORDER BY
Ключевое слово ORDER BY используется для сортировки данных. Оно указывается в самом конце запроса (если в запросе нет LIMIT или OFFSET). После ORDER BY через запятую передаются названия колонок, по которым должна проходить сортировка.
- `order by population` - упорядочить по увеличению в колонке population
- `order by population` desc - упорядочить в обратном порядке в колонке population

Пример:
```sql
select author, book_name, publishing_year 
from books 
where publishing_year > 1980 
order by author desc
```
Если в ORDER BY выбрано несколько полей, то сортировка идёт последовательно: сначала по первому столбцу, а если значения в этом столбце одинаковые, то сортировка идёт по следующему столбцу и так далее.

### Упрощение работы с ORDER BY
Для упрощения работы с ORDER BY можно использовать не названия столбцов, а номер столбца в выгружаемых данных. Например:
```sql
select author, book_id
from books
order by 2;
```
Этот запрос выведет список авторов и ID их книг, отсортированный по второй колонке в запросе, то есть по book_id.

Также в ORDER BY помимо параметра desc/asc можно передавать параметр NULLS FIRST / NULLS LAST, который показывает, в начало списка или в конец ставить пустые значения сортируемой колонки.

# Ограничения (LIMIT И OFFSET)
Иногда нам нужны не все данные по каким-то условиям, а лишь их часть. Например, когда нужно посмотреть, что и в каком формате содержится в таблице. С этим могут помочь ключевые слова LIMIT и OFFSET.

LIMIT и OFFSET можно использовать вместе, их порядок не важен.

LIMIT, и OFFSET всегда пишутся в самом конце запроса.

```sql
-- вывести третий город по количеству населения в штате Техас
select * 
FROM sql.city 
where state = 'Texas'
ORDER BY population desc
limit 1 offset 2
```

```sql
-- вывести сначала невалидные значение (значение которых Null)
select city_name
, population/nullif((area-1.3), 0) as dens
FROM sql.city 
order by dens nulls first
limit 15 
```