-- create users table
CREATE TABLE "users"(
    "name" VARCHAR(25) UNIQUE NOT NULL
);

-- create topics table
CREATE TABLE "topics"(
    "name" VARCHAR(30) UNIQUE NOT NULL,
    "description" TEXT(500)
);

-- create posts table
CREATE TABLE "posts"(
    "title" TEXT(100) NOT NULL
);

CREATE TABLE "comments"(
    "text" TEXT NOT NULL,

);