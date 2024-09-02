# Физическая модель

---

Таблица `person`:

| Название          | Описание                       | Тип данных     | Ограничение   |
|-------------------|--------------------------------|----------------|---------------|
| `person_name`     | Имя пользователя               | `VARCHAR(100)` | `NOT NULL`    |
| `person_id`       | Идентификатор                  | `INTEGER`      | `PRIMARY KEY` |
| `count`           | Кол-во прочитанных книг        | `VARCHAR(200)` | `NOT NULL`    |
| `validation_from` | Дата начала регистрации        | `DATE`         | `NOT NULL`    |
| `validation_to`   | Дата окончания регистрации     | `DATE`         | `NOT NULL`    |
| `expire_amount`   | Кол-воо просроченных дедлайнов | `INTEGER`      | `NOT NULL`    |
| `serial_number`   | Серийный номер паспорта        | `VARCHAR(300)` | `NOT NULL`    |
| `flg_black`       | В черном списке или нет        | `BOOLEAN`      | `NOT NULL`    |

Таблица `issuance_of_book`:

| Название          | Описание                   | Тип данных | Ограничение   |
|-------------------|----------------------------|------------|---------------|
| `issuance_id`     | Идентификатор выдачи       | `SERIAL`   | `PRIMARY KEY` |
| `person_id`       | Идентификатор пользователя | `INTEGER`  | `FOREIGN KEY` |
| `count`           | Кол-во книг на выдаче      | `INTEGER`  | `NOT NULL`    |
| `validation_from` | Дата оформления выдачи     | `DATE`     | `NOT NULL`    |
| `validation_to`   | Дата дедлайна выдачи       | `DATE`     | `NOT NULL`    |
| `clerk_id`        | Идентификатор клерка       | `INTEGER`  | `FOREIGN KEY` |

Таблица `clerk`:

| Название          | Описание                | Тип данных     | Ограничение   |
|-------------------|-------------------------|----------------|---------------|
| `clerk_name`      | Имя клерка              | `VARCHAR(200)` | `NOT NULL`    |
| `clerk_id`        | Идентификатор клерка    | `INTEGER`      | `PRIMARY KEY` |

Таблица `person_level`:

| Название          | Описание                          | Тип данных     | Ограничение   |
|-------------------|-----------------------------------|----------------|---------------|
| `level`           | Уровень доверия пользователю      | `VARCHAR(100)` | `NOT NULL`    |
| `count`           | Граница по прочитанным книгам     | `INTEGER`      | `NOT NULL`    |
| `expire_amount`   | Граница по просроченным дедлайнам | `INTEGER`      | `NOT NULL`    |

Таблица `book_archive`:

| Название          | Описание                             | Тип данных     | Ограничение   |
|-------------------|--------------------------------------|----------------|---------------|
| `book_type_id`    | Идентифакатор типа книги             | `INTEGER`      | `PRIMARY KEY` |
| `book_amount`     | Количество книг такого типа в архиве | `INTEGER`      | `NOT NULL`    |

Таблица `book`:

| Название          | Описание                 | Тип данных     | Ограничение   |
|-------------------|--------------------------|----------------|---------------|
| `book_name`       | Имя книги                | `VARCHAR(300)` | `NOT NULL`    |
| `book_id`         | Идентификатор книги      | `INTEGER`      | `PRIMARY KEY` |
| `genre`           | Жанр книги               | `VARCHAR(200)` | `NOT NULL`    |
| `book_type_id`    | Идентифакатор типа книги | `INTEGER`      | `FOREIGN KEY` |

Таблица `book_history`:

| Название          | Описание                  | Тип данных     | Ограничение   |
|-------------------|---------------------------|----------------|---------------|
| `registration_id` | Идентификатор регистрации | `SERIAL`       | `PRIMARY KEY` |
| `book_id`         | Идентификатор книги       | `INTEGER`      | `FOREIGN KEY` |
| `issuance_id`     | Идентификатор выдачи      | `INTEGER`      | `FOREIGN KEY` |

Таблица `book_return`:

| Название          | Описание                   | Тип данных | Ограничение   |
|-------------------|----------------------------|------------|---------------|
| `issuance_id`     | Идентификатор выдачи       | `SERIAL`   | `PRIMARY KEY` |
| `person_id`       | Идентификатор пользователя | `INTEGER`  | `FOREIGN KEY` |
| `count`           | Кол-во книг на выдаче      | `INTEGER`  | `NOT NULL`    |
| `validation_from` | Дата оформления выдачи     | `DATE`     | `NOT NULL`    |
| `validation_to`   | Дата дедлайна выдачи       | `DATE`     | `NOT NULL`    |
| `clerk_id`        | Идентификатор клерка       | `INTEGER`  | `FOREIGN KEY` |
| `return_date`     | Дата возврата выдачи       | `DATE`     | `NOT NULL`    |

---
Таблица `person`:
```postgresql
CREATE TABLE library.person (
	person_name     VARCHAR(100) NOT NULL,
	person_id       INTEGER      NOT NULL     PRIMARY KEY,
	count           INTEGER      NOT NULL,
	validation_from DATE         NOT NULL,
	validation_to   DATE         NOT NULL,
	expire_amount   INTEGER      NOT NULL,
	serial_number   VARCHAR(300) NOT NULL,
	flg_black       BOOLEAN      NOT NULL
);
```
Таблица `clerk`:
```postgresql
CREATE TABLE library.clerk (
	clerk_name VARCHAR(200) NOT NULL,
	clerk_id   INTEGER      NOT NULL    PRIMARY KEY
);
```
Таблица `issuance_of_book`:
```postgresql
CREATE TABLE library.issuance_of_book (
	issuance_id     SERIAL  NOT NULL    PRIMARY KEY,
	person_id       INTEGER NOT NULL,
	FOREIGN KEY (person_id) REFERENCES library.person(person_id),
	count           INTEGER NOT NULL,
	validation_from DATE    NOT NULL,
	validation_to   DATE    NOT NULL,
	clerk_id        INTEGER NOT NULL,
	FOREIGN KEY (clerk_id) REFERENCES library.clerk(clerk_id)
);
```
Таблица `person_level`:
```postgresql
CREATE TABLE library.person_level (
	level         VARCHAR(100) NOT NULL,
	count         INTEGER      NOT NULL,
	expire_amount INTEGER      NOT NULL
);
```
Таблица `book_archive`:
```postgresql
CREATE TABLE library.book_archive (
	book_type_id INTEGER    NOT NULL    PRIMARY KEY,
	book_amount  INTEGER    NOT NULL
);
```
Таблица `book`:
```postgresql
CREATE TABLE library.book (
	book_name    VARCHAR(300)    NOT NULL,
	book_id      INTEGER         NOT NULL    PRIMARY KEY,
	genre        VARCHAR(200)    NOT NULL,
	book_type_id INTEGER         NOT NULL,
	FOREIGN KEY (book_type_id) REFERENCES library.book_archive(book_type_id)
);
```
Таблица `book_history`:
```postgresql
CREATE TABLE library.book_history (
	registration_id    SERIAL    NOT NULL    PRIMARY KEY,
	book_id            INTEGER   NOT NULL,
	issuance_id        SERIAL    NOT NULL,
	FOREIGN KEY (book_id) REFERENCES library.book(book_id),
	FOREIGN KEY (issuance_id) REFERENCES library.issuance_of_book(issuance_id)
);
```
Таблица `book_return`:
```postgresql
CREATE TABLE library.issuance_of_book (
	issuance_id     SERIAL  NOT NULL    PRIMARY KEY,
	person_id       INTEGER NOT NULL,
	FOREIGN KEY (person_id) REFERENCES library.person(person_id),
	count           INTEGER NOT NULL,
	validation_from DATE    NOT NULL,
	validation_to   DATE    NOT NULL,
	clerk_id        INTEGER NOT NULL,
	FOREIGN KEY (clerk_id) REFERENCES library.clerk(clerk_id),
	return_date     DATE    NOT NULL
);
```
