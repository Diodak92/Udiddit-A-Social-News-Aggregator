-- create users table
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR(25) UNIQUE NOT NULL,
    CONSTRAINT EMPTY_USER CHECK(LENGTH(TRIM("username")) > 0)
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
    "topic_id" INTEGER,
    "user_id" INTEGER,
    CONSTRAINT "url_or_text" CHECK(("url" IS NOT NULL AND "text_content" IS NULL) OR ("url" IS NULL AND "text_content" IS NOT NULL)),
    CONSTRAINT "delete_posts" FOREIGN KEY ("topic_id") REFERENCES "topics" ON DELETE CASCADE,
    CONSTRAINT "dissociate_post" FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL
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
    CONSTRAINT UP_DOWN_VOTE CHECK("value" = -1 OR "value" = 1),
    CONSTRAINT "dissociate_user" FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL,
    CONSTRAINT "delete_votes" FOREIGN KEY ("post_id") REFERENCES "posts" ON DELETE CASCADE
);