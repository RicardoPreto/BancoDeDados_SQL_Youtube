-- We are gonna select some videos in the end to a Youtube database in MySQL
-- video(id, author, title, likes, dislikes)
-- playlist(id, name)
-- SEO (id, category)
-- Author (id, name)
-- Make some relations -> video with SEO and author / playlist with video and author

-- First, we are gonna create the database and the tables:
create database youtube_project
create table videos(id_videos int primary key AUTO_INCREMENT, author varchar(30) not null, 
title varchar(45) not null, likes int, dislikes int);
create table author(id_author int primary key auto_increment, name_author varchar(30) not null);
create table playlist(id_playlist int primary key auto_increment, name_playlist varchar(30) not null);
create table seo(id_seo int primary key auto_increment, category varchar(20) not null);
create table videos_playlist(id_vp int primary key auto_increment, fk_videos int not null,
fk_playlist int not null);

-- Now We are gonna insert data into videos:
insert into videos (author, title, likes, dislikes) values ('Maria', 'MySQL', 100, 2);
insert into videos (author, title, likes, dislikes) values ('Joana', 'CSS', 52, 30);
insert into videos (author, title, likes, dislikes) values ('Joãozinho', 'HTML', 38, 25);
insert into videos (author, title, likes, dislikes) values ('Maria', 'HTML5', 37, 3);
insert into videos (author, title, likes, dislikes) values ('Joana', 'Python', 730, 0);
-- MySQL=1, HTML5=2, CSS=3, HTML=4, Python=5;

-- After that, We will insert author informations:
insert into author (name_author) values ('Maria');
insert into author (name_author) values ('Joãozinho');
insert into author (name_author) values ('Joana');
insert into author (name_author) values ('Flávia');
insert into author (name_author) values ('Ronald');
insert into author (name_author) values ('Pedrinho')
-- Maria=1, Joãozinho=2, Joana=3, Flávia=4, Ronald=5, Pedrinho=6;

-- Now, We are gonna make some relations -> Video with author;
-- For that, We need to make some updates:
update videos set author='';
alter table videos change author fk_author INT NOT NULL;
-- The relations:
update videos set author=1 where title='MySQL';
update videos set author=1 where title='HTML5';
update videos set author=3 where title='CSS';
update videos set author=2 where title='HTML';
update videos set author=3 where title='Python';
alter table videos add constraint fk_author foreign key (fk_author)
references author(id_author) on delete cascade on update cascade;

-- Now, we are gonna see all videos informations with author information:
select * from videos join author on videos.fk_author = author.id_author;

-- Insert informations into category
insert into seo (category) values ('Backend');
insert into seo(category) values('Frontend');
-- Backend=1, Frontend=2;

-- Make Relations -> video with seo
-- First, update the columns and tables:
alter table videos add fk_seo int not null after title;
alter table videos add CONSTRAINT fk_seo foreign key (fk_seo) references seo (id_seo)
on delete cascade on update cascade;
-- The relations:
update videos set fk_seo=1 where id_videos=1;
update videos set fk_seo=1 where id_videos=5;
update videos set fk_seo=2 where id_videos=2;
update videos set fk_seo=2 where id_videos=3;
update videos set fk_seo=2 where id_videos=4;

-- Now, let's see the informations connected:
select videos.title, seo.category from videos join seo on videos.fk_seo = seo.id_seo;

-- Let's see the informations about seo and videos connected with author too:
select videos.title, seo.category, author.name_author from videos join seo on videos.fk_seo = seo.id_seo
join author on videos.fk_author = author.id_author
-- Or with all informations:
select * from videos join seo on videos.fk_seo = seo.id_seo
join author on videos.fk_author = author.id_author

-- Insert informations into playlist:
insert into playlist (name_playlist) values ('Backend');
insert into playlist (name_playlist) values ('Create a Website');
-- Backend=1, Create a Website=2;

--Insert informations into videos_playlist:
insert into videos_playlist (fk_videos, fk_playlist) values(1,1);
insert into videos_playlist (fk_videos, fk_playlist) values(2,2);
insert into videos_playlist (fk_videos, fk_playlist) values(3,2);
insert into videos_playlist (fk_videos, fk_playlist) values(4,2);
insert into videos_playlist (fk_videos, fk_playlist) values(5,1);

-- Now, let's see the informations connected:
select * from videos join videos_playlist on videos.id_videos = videos_playlist.fk_videos
join playlist on videos_playlist.fk_playlist = playlist.id_playlist;
-- Only selected informations connected:
select videos.title, author.name_author, videos.likes, videos.dislikes, playlist.name_playlist 
from videos join videos_playlist 
on videos.id_videos = videos_playlist.fk_videos
join playlist on videos_playlist.fk_playlist = playlist.id_playlist
join author on videos.fk_author = author.id_author;