-- добавляем нового пользователя в таблицу person
insert into library.person
values ('Jim Johnes', 1011, 15, '2022-07-18', '2023-08-18', 1, 'BCA890', false);

-- добавляем для этого пользователся информацию об одной выдачи
-- в таблицу issuance_of_book
insert into library.issuance_of_book
values (1243, 1011, 2, '2022-07-18', '2022-08-05', 15781);

-- выводим все данные из таблицы person
select *
from library.person;

--выводим все данные из таблицы issuance_of_book
select *
from library.issuance_of_book;

-- меняем имя пользователся с id = 1011
update library.person
set person_name='John Johnes'
where person_id = 1011;
-- select *
-- from library.person;

-- меняем клерка, который выдал выдачу с id = 1243
update library.issuance_of_book
set clerk_id = 13619
where issuance_id = 1243;
-- select *
-- from library.issuance_of_book;

-- удаляем последние добавленные данные из обоих таблиц
delete
from library.issuance_of_book
where person_id = 1011;

delete
from library.person
where person_id = 1011;
