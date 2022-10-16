-- check users table constraint
INSERT INTO "users" VALUES
    (DEFAULT, 'Tim');

INSERT INTO "users" VALUES
    (DEFAULT, '');

INSERT INTO "users" VALUES
    (DEFAULT, NULL);  

-- check posts table constraint

-- check url_or_text constraint
-- insert url
INSERT INTO "posts" VALUES 
    (DEFAULT,
    'Chapter 5. Data Definition',
    'https://www.postgresql.org/docs/9.6/ddl-constraints.html');

-- insert text content
DELETE FROM "posts";
INSERT INTO "posts" ("id", "title", "url", "text_content") VALUES
    (DEFAULT,
    'Chapter 5. Data Definition',
    NULL,
    'Data types are a way to limit the kind of data that can be stored in a table.
    For many applications, however, the constraint they provide is too coarse.
    For example, a column containing a product price should probably only accept positive values.');

-- insert url and text content
DELETE FROM "posts";
INSERT INTO "posts" ("id", "title", "url", "text_content") VALUES
    (DEFAULT,
    'Chapter 5. Data Definition',
    'https://www.postgresql.org/docs/9.6/ddl-constraints.html',
    'Data types are a way to limit the kind of data that can be stored in a table.
    For many applications, however, the constraint they provide is too coarse.
    For example, a column containing a product price should probably only accept positive values.');