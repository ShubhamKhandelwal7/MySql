-- manage(create, update, delete) categories, articles, comments, and users --
CREATE TABLE users
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
type VARCHAR(10)
);
CREATE TABLE categories
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) 
);
CREATE TABLE articles
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY, 
content VARCHAR(20),
user_id INTEGER,
category_id INTEGER,
FOREIGN KEY (user_id) REFERENCES users(ID),
FOREIGN KEY (category_id) REFERENCES categories(ID)
);

CREATE TABLE comments 
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
article_id INTEGER,
remark VARCHAR(30),
remarked_by INTEGER,
FOREIGN KEY (article_id) REFERENCES articles(ID),
FOREIGN KEY (remarked_by) REFERENCES users(ID)
);

INSERT INTO users(name,type)
VALUES ('user1','Admin'),
('user2','Normal'),
('user3','Normal'),
('user4','Normal');

INSERT INTO categories(name)
VALUES ('Nature'),
('Science'),
('Politics'),
('Entertainment');

INSERT INTO articles(content,user_id,category_id)
VALUES ('Amazon Fires',1,1),
('ISRO Chandrayaan',2,2),
('Polotical Dilemma',1,3),
('US Open',3,4),
('Addicting Cinema',4,4),
('Gulf Crisis',4,3),
('RPA Takedown',4,2),
('NewsLetter',2,4);

INSERT INTO comments(article_id,remark,remarked_by)
VALUES (1,'Alarmng!!',3),
(2,'New Leap Forward',1),
(4,'great games',2),
(1,'Concerning',3),
(2,'great larnings',4),
(6,'Unlooked',3),
(7,'New Beginning',2),
(2,'Promising',1);

UPDATE articles
SET content='ISRO Chandrayaan II'  
WHERE ID=2;
DELETE FROM articles
WHERE ID=5;
DELETE FROM articles
WHERE ID=8;

-- select all articles whose author's name is user3 (Do this exercise using variable also). --
SET @user_name='user3';
SELECT content 
FROM articles WHERE user_id =(
SELECT ID FROM users 
WHERE name=@user_name);

-- For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query --
SELECT articles.content, comments.remark
FROM articles 
JOIN comments ON articles.id=comments.article_id
WHERE articles.user_id IN(
SELECT ID FROM users 
WHERE name='user3');

SELECT articles.content, comments.remark
FROM articles 
JOIN comments ON articles.id=comments.article_id
JOIN users ON articles.user_id=users.id
WHERE name='user3';

-- Write a query to select all articles which do not have any comments --
SELECT content FROM articles
WHERE articles.id NOT IN (
SELECT article_id FROM comments);

SELECT articles.content FROM articles
LEFT JOIN comments ON articles.id=comments.article_id
WHERE comments.article_id IS NULL;

-- Write a query to select article which has maximum comments --

SELECT content FROM articles 
JOIN comments ON articles.id=comments.article_id
GROUP BY comments.article_id
HAVING COUNT(comments.article_id)>=All (
SELECT COUNT(article_id) FROM comments GROUP BY article_id);
-- Write a query to select article which does not have more than one comment by the same user  --

SELECT articles.content FROM comments
Left JOIN articles ON comments.article_id=articles.id
GROUP BY comments.article_id
HAVING count( comments.remarked_by)<=1;