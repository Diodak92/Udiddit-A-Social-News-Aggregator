 -- migrate users
WITH temp_users AS
    (SELECT DISTINCT username
     FROM bad_comments
     UNION SELECT DISTINCT username
     FROM bad_posts
     UNION SELECT DISTINCT regexp_split_to_table(upvotes, ',')
     FROM bad_posts
     UNION SELECT DISTINCT regexp_split_to_table(downvotes, ',')
     FROM bad_posts)
INSERT INTO users ("username")
SELECT *
FROM temp_users;

-- migrate topics
INSERT INTO topics ("name")
SELECT DISTINCT topic
FROM bad_posts;

-- migrate posts
INSERT INTO posts ("title", "url", "text_content", "topic_id", "user_id")
SELECT SUBSTRING("title", 0, 100) AS title,
       -- SUBSTRING("title", 0, 10) AS title,
       url,
       text_content,
       -- SUBSTRING(text_content, 0, 10) AS text_content,
       topics.id AS topic_id,
       users.id AS user_id
FROM bad_posts
JOIN topics
ON topics.name = bad_posts.topic
JOIN users
ON users.username = bad_posts.username;

-- migrating comments
INSERT INTO "comments"("text_content", "post_id", "user_id")
SELECT bad_comments.text_content, posts.id, posts.user_id
FROM bad_comments
JOIN posts
ON bad_comments.post_id = posts.id
JOIN users
ON bad_comments.username = users.username;

-- migrate upvotes
INSERT INTO "votes" ("post_id", "user_id", "value")
WITH upvote_users AS
    (SELECT id AS post_id,
            REGEXP_SPLIT_TO_TABLE(upvotes, ',') AS username
    FROM bad_posts)
SELECT upvote_users.post_id, users.id AS user_id, 1 AS value
FROM upvote_users
JOIN users
ON upvote_users.username = users.username;

-- migrate downvotes
INSERT INTO "votes" ("post_id", "user_id", "value")
WITH downvote_users AS
    (SELECT id AS post_id,
            REGEXP_SPLIT_TO_TABLE(downvotes, ',') AS username
     FROM bad_posts)
SELECT downvote_users.post_id, users.id AS user_id, -1 AS value
FROM downvote_users
JOIN users
ON downvote_users.username = users.username;