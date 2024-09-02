create schema library;

create table library.person
(
    person_name     varchar(100) not null,
    person_id       integer      not null primary key,
    count           integer      not null,
    validation_from date         not null,
    validation_to   date         not null,
    expire_amount   integer      not null,
    serial_number   varchar(300) not null,
    flg_black       boolean      not null
);

create table library.clerk
(
    clerk_name varchar(200) not null,
    clerk_id   integer      not null primary key
);

create table library.issuance_of_book
(
    issuance_id     serial  not null primary key,
    person_id       integer not null,
    foreign key (person_id) references library.person (person_id),
    count           integer not null,
    validation_from date    not null,
    validation_to   date    not null,
    clerk_id        integer not null,
    foreign key (clerk_id) references library.clerk (clerk_id)
);

create table library.person_level
(
    level         varchar(100) not null,
    count         integer      not null,
    expire_amount integer      not null
);

create table library.book_archive
(
    book_type_id integer not null primary key,
    book_amount  integer not null
);

create table library.book
(
    book_name    varchar(300) not null,
    book_id      integer      not null primary key,
    genre        varchar(200) not null,
    book_type_id integer      not null,
    foreign key (book_type_id) references library.book_archive (book_type_id)
);

create table library.book_history
(
    registration_id serial  not null primary key,
    book_id         integer not null,
    issuance_id     integer not null,
    foreign key (book_id) references library.book (book_id),
    foreign key (issuance_id) references library.issuance_of_book (issuance_id)
);

create table if not exists library.book_return
(
    issuance_id     serial  not null primary key,
    person_id       integer not null,
    foreign key (person_id) references library.person (person_id),
    count           integer not null,
    validation_from date    not null,
    validation_to   date    not null,
    clerk_id        integer not null,
    return_date     date    not null
);
