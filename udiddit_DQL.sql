-- a.
-- List all users who haven't logged in the last year

SELECT *
FROM users
WHERE last_login <= (CURRENT_DATE - interval '1 year');

-- b.
-- List all users who haven’t created any post

SELECT DISTINCT id, username 
FROM
    (SELECT u.id, u.username, p.id AS post_id, p.title
     FROM posts AS p
     FULL OUTER JOIN users AS u ON p.user_id = u.id
     WHERE p.id IS NULL
     ORDER BY u.id) inactive_users;

-- c.
-- Find a user by their username
SELECT *
FROM users
WHERE username = 'Angelo_Erdman';

-- d.
-- List all topics that don’t have any posts
SELECT topics.id AS topic_id, topics.name AS topic_name
FROM topics
FULL OUTER JOIN posts
ON posts.topic_id = topics.id
WHERE posts.topic_id IS NULL
ORDER BY topic_id;

-- e.
-- Find a topic by its name
SELECT *
FROM topics
WHERE name LIKE 'engine%';

-- f.
-- List the latest 20 posts for a given topic
SELECT p.id AS post_id, p.title AS post_title, t.name AS topic_name,
p.created_on
FROM posts p
JOIN topics t
ON p.topic_id = t.id
WHERE t.name = 'Plastic'
ORDER BY created_on DESC
LIMIT 20;

-- g.
-- List the latest 20 posts made by a given user
SELECT u.id AS user_id, u.username, 
p.id AS post_id, p.title AS post_title, p.created_on
FROM posts p
JOIN users u
ON p.user_id = u.id
WHERE u.username = 'Luz45'
ORDER BY created_on DESC
LIMIT 20;

-- h.
-- Find all posts that link to a specific URL, for moderation purposes

SELECT *
FROM posts
WHERE url = 'http://shakira.com'; -- IS NOT NULL


-- i.
-- List all the top-level comments (those that don’t have a parent comment) for a given post.

-- j.
-- List all the direct children of a parent comment.


-- k.
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

-- l.
-- Compute the score of a post, defined as the difference between the number of upvotes and the number of downvotes
SELECT SUM(value) AS post_score
FROM votes
WHERE post_id = 365;
