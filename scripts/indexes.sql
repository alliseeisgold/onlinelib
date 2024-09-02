set search_path = 'library';
-- Индексы:
-- Для таблицы library.person создадим индекс по полю serial_number, чтобы быстро находить записи по номеру серии документа. 
-- Кроме того, это поле уникально, поэтому его использование в качестве ключа для индекса увеличивает эффективность его работы.

create index idx_person_serial_number on person (serial_number);

-- Для таблицы library.book создадим индекс по полю genre, так как запросы на выборку книг по жанру могут быть частыми в системе управления библиотекой.

create index idx_book_genre on book (genre);


-- Для таблицы library.issuance_of_book создадим индекс по полям person_id и validation_to, 
-- чтобы быстро находить записи об активных выдачах книг конкретному читателю. 
-- Это уменьшит время выполнения запросов на поиск выданных книг для определенного читателя.

create index idx_issuance_of_book_person_id_validation_to on issuance_of_book (person_id, validation_to);



