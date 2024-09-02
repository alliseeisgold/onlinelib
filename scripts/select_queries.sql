set search_path = 'library';
-- 1. group by + having
-- вывести имена и количество книг, которые были взяты из библиотеки более 5 раз:
select p.person_name,
       count(*) as num_of_books
from person as p
         join issuance_of_book as iob on p.person_id = iob.person_id
group by p.person_name
having count(*) > 5;


-- 2. order by
-- вывести список книг, отсортированных по жанру в алфавитном порядке, а затем
-- по названию книги в обратном алфавитном порядке:
select book_name, genre
from book
order by genre, book_name desc;


-- 3. <func>...over(...)
-- 3.1 partition by
-- вывести суммарное количество выданных книг каждым пользователем
select p.person_id,
       person_name,
       count(*) over (partition by p.person_id) as total_issued_books
from issuance_of_book as iss
         join person as p on iss.person_id = p.person_id;

--3. <func>...over(...)
--3.1 order by
select b.book_id,
       b.book_name,
       b.genre,
       count(*) over (partition by b.book_id) as issuance_count
from book as b
         join book_history as bh on bh.book_id = b.book_id
order by issuance_count desc;


select person_name,
       p.count,
       iss.validation_to,
       row_number() over (partition by p.person_id order by iss.validation_to desc) as row_num
from person as p
         join issuance_of_book as iss on p.person_id = iss.person_id
         join book_return as ret on iss.issuance_id = ret.issuance_id
order by iss.validation_to desc;

select p.person_id,
       p.person_name,
       p.count         as books_read,
       p.expire_amount as late_returns,
       l.level         as user_level
from person as p
         join person_level as l
              on p.count >= l.count and p.expire_amount <= l.expire_amount
