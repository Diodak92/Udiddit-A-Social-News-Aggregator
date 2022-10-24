-- create users table
CREATE TABLE "users"(
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR(25) NOT NULL,
    "last_login" TIMESTAMP,
    CONSTRAINT EMPTY_USER CHECK(LENGTH(TRIM("username")) > 0)
);
CREATE UNIQUE INDEX ON "users" (LOWER("username"));

-- create topics table
CREATE TABLE "topics"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(30) UNIQUE NOT NULL,
    "description" VARCHAR(500) DEFAULT NULL,
    CONSTRAINT EMPTY_TOPIC CHECK(LENGTH(TRIM("name")) > 0)
);
CREATE INDEX ON "topics" (LOWER("name") VARCHAR_PATTERN_OPS);

-- create posts table
CREATE TABLE "posts"(
    "id" BIGSERIAL PRIMARY KEY,
    "title" VARCHAR(100) NOT NULL,
    "url" VARCHAR(2048) DEFAULT NULL,
    "text_content" TEXT DEFAULT NULL,
    "created_on" TIMESTAMP,
    "topic_id" INTEGER,
    "user_id" INTEGER,
    CONSTRAINT "url_or_text" CHECK(("url" IS NOT NULL AND "text_content" IS NULL)
    OR ("url" IS NULL AND "text_content" IS NOT NULL)),
    CONSTRAINT EMPTY_TITLE CHECK(LENGTH(TRIM("title")) > 0),
    CONSTRAINT "delete_posts" FOREIGN KEY ("topic_id") REFERENCES "topics" ON DELETE CASCADE,
    CONSTRAINT "dissociate_post" FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL
);
CREATE INDEX "find_posts_on_topic" ON "posts" ("topic_id");
CREATE INDEX "find_user_posts" ON "posts" ("user_id");

CREATE TABLE "comments"(
    "id" SERIAL PRIMARY KEY,
    "text_content" TEXT NOT NULL,
    "created_on" TIMESTAMP, 
    "post_id" BIGINT,
    "user_id" INTEGER,
    "parent_id" INTEGER,
    CONSTRAINT EMPTY_TEXT_CONTENT CHECK(LENGTH(TRIM("text_content")) > 0),
    CONSTRAINT "delete_comments" FOREIGN KEY ("post_id") REFERENCES "posts" ON DELETE CASCADE,
    CONSTRAINT "dissociate_comment" FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL,
    CONSTRAINT "child_comment" FOREIGN KEY ("parent_id") REFERENCES "comments" ON DELETE CASCADE
);
CREATE INDEX "find_user_comments" ON "comments" ("user_id");

CREATE TABLE "votes"(
    "id" SERIAL PRIMARY KEY,
    "value" SMALLINT,
    "user_id" INTEGER,
    "post_id" BIGINT,
    CONSTRAINT UP_DOWN_VOTE CHECK("value" = -1 OR "value" = 1),
    CONSTRAINT "dissociate_user" FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL,
    CONSTRAINT "delete_votes" FOREIGN KEY ("post_id") REFERENCES "posts" ON DELETE CASCADE
);