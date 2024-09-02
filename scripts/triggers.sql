-- Триггеры:

-- Триггер для таблицы library.book_history, который будет записывать в отдельную таблицу library.book_history_log 
-- все изменения в таблице library.book_history, включая дату и время изменения, ID книги и ID записи о выдаче.

CREATE OR REPLACE FUNCTION book_history_trigger()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO library.book_history_log (book_id, issuance_id, date_changed)
    VALUES (NEW.book_id, NEW.issuance_id, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER book_history_log_trigger
AFTER INSERT OR UPDATE OR DELETE ON library.book_history
FOR EACH ROW
EXECUTE FUNCTION book_history_trigger();

-- Триггер для таблицы library.person, который будет автоматически обновлять поле count в таблице library.person_level, 
-- когда книги будут выдаваться или возвращаться. В данном случае мы предполагаем, что count - это количество книг, 
-- которые читатель может взять в библиотеке.

CREATE OR REPLACE FUNCTION person_count_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE library.person_level SET count = count - NEW.count WHERE level = NEW.level;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE library.person_level SET count = count + OLD.count WHERE level = OLD.level;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE library.person_level SET count = count - NEW.count + OLD.count WHERE level = NEW.level;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER person_count_trigger
AFTER INSERT OR UPDATE OR DELETE ON library.issuance_of_book
FOR EACH ROW
EXECUTE FUNCTION person_count_trigger();



