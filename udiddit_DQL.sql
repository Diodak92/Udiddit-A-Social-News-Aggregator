-- a
-- List all users who haven't logged in the last year

SELECT *
FROM users
WHERE last_login <= (CURRENT_DATE - interval '1 year');

-- b
-- List all users who haven’t created any post

SELECT DISTINCT id, username 
FROM
    (SELECT u.id, u.username, p.id AS post_id, p.title
     FROM posts AS p
     FULL OUTER JOIN users AS u ON p.user_id = u.id
     WHERE p.id IS NULL
     ORDER BY u.id) inactive_users;

-- c
-- Find a user by their username
SELECT *
FROM users
WHERE username = 'Angelo_Erdman';


-- e
-- Find a topic by its name
SELECT *
FROM topics
WHERE name LIKE 'engine%';


-- h
-- Find all posts that link to a specific URL, for moderation purposes

SELECT *
FROM posts
WHERE url = 'http://shakira.com'; -- IS NOT NULL

-- k
-- List the latest 20 comments made by a given user

SELECT users.id AS user_id, users.username, 
comments.post_id, comments.text_content AS comment, comments.created_on
FROM comments
JOIN users
ON users.id = comments.user_id 
-- WHERE user_id = 2164
WHERE username = 'Monica_Weber85'
ORDER BY created_on DESC
LIMIT 20;

-- l
-- Compute the score of a post, defined as the difference between the number of upvotes and the number of downvotes
SELECT SUM(value) AS post_score
FROM votes
WHERE post_id = 365;
