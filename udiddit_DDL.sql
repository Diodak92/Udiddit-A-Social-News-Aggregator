-- create users table
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR(25) UNIQUE NOT NULL,
    CONSTRAINT empty_user CHECK(LENGTH(TRIM("username")) > 0)
);

-- create topics table
CREATE TABLE "topics"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(30) UNIQUE NOT NULL,
    "description" VARCHAR(500) DEFAULT NULL
);

-- create posts table
CREATE TABLE "posts"(
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(100) NOT NULL,
    "url" VARCHAR(2048) DEFAULT NULL,
    "text_content" TEXT DEFAULT NULL,
    CONSTRAINT "url_or_text" CHECK(("url" IS NOT NULL AND "text_content" IS NULL) OR
    ("url" IS NULL AND "text_content" IS NOT NULL))
);

CREATE TABLE "comments"(
    "id" SERIAL PRIMARY KEY,
    "text" TEXT NOT NULL
);

CREATE TABLE "votes"(
    "id" SERIAL PRIMARY KEY,
    "value" SMALLINT,
    "user_id" INTEGER,
    "post_id" INTEGER,
    CONSTRAINT up_down_vote CHECK("value" = -1 OR "value" = 1)
);