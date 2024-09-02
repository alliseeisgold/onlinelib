set search_path = 'library';
--Функция 1 - get_issued_books
--Цель: Получить книги, которые были выданы
drop function get_issued_books();
create or replace function get_issued_books()
    returns table
            (
                book_name     varchar(300),
                genre         varchar(200),
                issuance_date date,
                return_date   date,
                person_name   varchar(100),
                clerk_name    varchar(200)
            )
as
$$
begin
    return query
        select b.book_name,
               b.genre,
               cast(ib.validation_from as date),
               cast(br.return_date as date),
               p.person_name,
               c.clerk_name
        from book as b
                 inner join book_history as bh on bh.book_id = b.book_id
                 inner join issuance_of_book as ib on ib.issuance_id = bh.issuance_id
                 left join book_return as br on br.issuance_id = ib.issuance_id
                 left join person as p on p.person_id = ib.person_id
                 left join clerk as c on c.clerk_id = ib.clerk_id;
end;
$$ language plpgsql;
-- select * from get_books_by_genre('classic fiction');

--Функция 2 - get_books_by_genre(genre)
--Цель: Получить список книг по заданному жанру.
drop function get_books_by_genre(book_genre varchar(200));
create or replace function get_books_by_genre(book_genre varchar(200)) returns table (
    book_name varchar(300),
    book_id integer,
    book_type_id integer
) as $$
begin
    return query
        select b.book_name, b.book_id, b.book_type_id
        from book as b
        where lower(b.genre) = lower(book_genre);
end;
$$ language plpgsql;
-- select * from get_issued_books();