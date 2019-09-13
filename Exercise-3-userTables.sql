-- manage(create, update, delete) categories, articles, comments, and users --
CREATE TABLE users
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20),
type VARCHAR(10)
);
CREATE TABLE articles
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY, 
content VARCHAR(20),
users_ID INTEGER,
categories_ID INTEGER,
FOREIGN KEY (users_ID) REFERENCES users(ID),
FOREIGN KEY (categories_ID) REFERENCES categories(ID)
);
CREATE TABLE categories
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
category VARCHAR(20)
);
CREATE TABLE comments 
(
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
articles_ID INTEGER,
comment VARCHAR(30),
commented_by INTEGER,
FOREIGN KEY (articles_ID) REFERENCES articles(ID),
FOREIGN KEY (commented_by) REFERENCES users(ID)
);

INSERT INTO users
VALUES (1,'user1','Admin'),
(2,'user2','Normal'),
(3,'user3','Normal'),
(4,'user4','Normal');

INSERT INTO articles
VALUES ('Amazon Fires',1),
('ISRO Chandrayaan',2),
('Polotical Dilemma',1),
('US Open',3),
('Addicting Cinema',4),
('Gulf Crisis',4),
('RPA Takedown',4);

INSERT INTO categories
VALUES ('Amazon Fires','Nature'),
('ISRO Chandrayaan','Science'),
('Polotical Dilemma','Politics'),
('US Open','Entertainment'),
('Addicting Cinema','Entertainment'),
('Gulf Crisis','Politics'),
('RPA Takedown','Science');

INSERT INTO comments
VALUES ('Amazon Fires','Alarmng!!',3),
('ISRO Chandrayaan','New Leap Forward',1),
('US Open','great games',2),
('Amazon Fires','Concerning',3),
('ISRO Chandrayaan','great larnings',4),
('Gulf Crisis','Unlooked',3),
('RPA Takedown','New Beginning',2),
('ISRO Chandrayaan','Promising',1);

DROP TABLE users;
DROP TABLE articles;
DROP TABLE categories;
DROP TABLE comments;

-- select all articles whose author's name is user3 (Do this exercise using variable also). --
SET @user_name='user3';
SELECT paper 
FROM articles WHERE author_ID =(
SELECT ID FROM users 
WHERE name=@user_name);

-- For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query --
SELECT articles.paper, comments.comment
FROM articles 
JOIN comments ON articles.paper=comments.article
WHERE articles.author_ID=(
SELECT ID FROM users 
WHERE name='user3');

SELECT article, comment
FROM comments WHERE article IN(
SELECT paper FROM articles
WHERE author_ID=(
SELECT ID FROM users 
WHERE name='user3'));

-- Write a query to select all articles which do not have any comments --
SELECT paper FROM articles
WHERE articles.paper NOT IN (
SELECT article FROM comments);

-- Write a query to select article which has maximum comments --
SELECT article from comments 
GROUP BY article
HAVING COUNT(article) >=all (
select COUNT(article) from comments group by article);

-- Write a query to select article which does not have more than one comment by the same user  --

SELECT articles.paper FROM comments
Left JOIN articles ON comments.article=articles.paper
GROUP BY comments.article
HAVING count(comments.commented_by)<=1;