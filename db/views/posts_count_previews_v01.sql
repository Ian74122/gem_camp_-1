SELECT posts.id as post_id, (SELECT count(*) FROM comments where comments.post_id = posts.id) as count
FROM posts;