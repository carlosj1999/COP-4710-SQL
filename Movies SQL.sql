create schema MOVIES_COP4710;

use MOVIES_COP4710;

create table Movie(
Movie_id varchar(10) primary key,
Title varchar(100) not null,
M_Year integer not null,
Length integer not null,
Prod_Comp varchar(50),
Plot_Outline varchar(50)
);

create table Director(
Director_id varchar(50) primary key,
D_Name varchar(50) not null,
Dob datetime
);

Alter table Director add constraint primary key Director(Director_id);
drop table Director;

create table Actor(
Actor_id varchar(50) primary key,
A_Name varchar(50) not null,
Dob datetime
);
drop table Actor;

create table Movie_Directors(
Movie varchar(10),
Director varchar(50),
primary key (Movie, Director),
foreign key (Movie) references Movie(Movie_id) On update cascade,
foreign key (Director) references Director(Director_id) On update cascade
);

create table Movie_Actors(
Movie varchar(10),
Actor varchar(50),
primary key (Movie, Actor),
foreign key (Movie) references Movie(Movie_id) On update cascade,
foreign key (Actor) references Actor(Actor_id) On update cascade
);

create table Quotes(
Movie varchar(10),
Actor varchar(50),
primary key (Movie, Actor),
foreign key (Movie) references Movie(Movie_id) On update cascade,
foreign key (Actor) references Actor(Actor_id) On update cascade,
Quote varchar(500) Not null
);



