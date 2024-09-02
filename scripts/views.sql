set search_path = 'library';

create or replace view v_persons_data as
select person_name,
       person_id,
       count,
       validation_from,
       validation_to,
       expire_amount,
       '******' AS serial_number,
       flg_black
from person;

create or replace view v_most_popular_books as
select p.person_name,
       count(*) as num_of_books
from person as p
         join issuance_of_book as iob on p.person_id = iob.person_id
group by p.person_name
having count(*) > 5;

create or replace view v_print_all_books as
select book_name, genre
from book
order by genre, book_name desc;

create view v_book_history as
select '******' as registration_id,
       book_id,
       issuance_id
from book_history;

create or replace view v_print_person_level as
select p.person_id,
       p.person_name,
       p.count         as books_read,
       p.expire_amount as late_returns,
       l.level         as user_level
from person as p
         join person_level as l
              on p.count >= l.count and p.expire_amount <= l.expire_amount

create or replace view v_expired_persons as
select p.person_name,
       br.issuance_id
from person as p
         join book_return as br on p.person_id = br.person_id
where br.return_date > br.validation_to;
