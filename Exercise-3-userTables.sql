-- manage(create, update, delete) categories, articles, comments, and users --
CREATE TABLE users
(
name VARCHAR(20) PRIMARY KEY,
type VARCHAR(10)
);
CREATE TABLE articles
(
article VARCHAR(20) PRIMARY KEY,
author VARCHAR(20),
FOREIGN KEY (author) REFERENCES users(name)
);
CREATE TABLE category
(
article VARCHAR(20),
category VARCHAR(20),
FOREIGN KEY (article) REFERENCES articles(article)
);
CREATE TABLE comments 
(
article VARCHAR(20),
comment VARCHAR(30),
commented_by VARCHAR(20),
FOREIGN KEY (article) REFERENCES articles(article),
FOREIGN KEY (commented_by) REFERENCES users(name)
);

INSERT INTO users
VALUES ('user1','Admin'),
('user2','Normal'),
('user3','Normal'),
('user4','Normal');

INSERT INTO articles
VALUES ('Amazon Fires','user1'),
('ISRO Chandrayaan','user2'),
('Polotical Dilemma','user1'),
('US Open','user3'),
('Addicting Cinema','user4'),
('Gulf Crisis','user4'),
('RPA Takedown','user4');

INSERT INTO category
VALUES ('Amazon Fires','Nature'),
('ISRO Chandrayaan','Science'),
('Polotical Dilemma','Politics'),
('US Open','Entertainment'),
('Addicting Cinema','Entertainment'),
('Gulf Crisis','Politics'),
('RPA Takedown','Science');

INSERT INTO comments
VALUES ('Amazon Fires','Alarmng!!','user3'),
('ISRO Chandrayaan','New Leap Forward','user1'),
('US Open','great games','user2'),
('Amazon Fires','Concerning','user3'),
('ISRO Chandrayaan','great larnings','user4'),
('Gulf Crisis','Unlooked','user3'),
('RPA Takedown','New Beginning','user2'),
('ISRO Chandrayaan','Promising','user1');

DROP TABLE users;
DROP TABLE articles;
DROP TABLE category;
DROP TABLE comments;

-- select all articles whose author's name is user3 (Do this exercise using variable also). --
SET @user_name='user3';
SELECT article 
FROM articles WHERE author=@user_name;

-- For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query --
SELECT articles.article, comments.comment
FROM articles 
JOIN comments ON articles.article=comments.article
WHERE articles.author='user3';

SELECT article, comment
FROM comments WHERE article IN(
SELECT article FROM articles
WHERE author='user3');

-- Write a query to select all articles which do not have any comments --
SELECT article FROM articles
WHERE articles.article NOT IN (
SELECT article FROM comments);

-- Write a query to select article which has maximum comments --
SELECT article from comments 
GROUP BY article
HAVING COUNT(article) >=all (
select COUNT(article) from comments group by article);

-- Write a query to select article which does not have more than one comment by the same user  --

SELECT articles.article FROM comments
Left JOIN articles ON comments.article=articles.article
GROUP BY comments.article
HAVING count(comments.commented_by)<=1;