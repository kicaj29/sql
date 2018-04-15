drop table users;
drop table usersRoles;

create table users
(
	userId int primary key,
	userName varchar(100)
);

create table usersRoles
(
	userId int,
	roleName varchar(100)
);

alter table usersRoles add constraint FK_userId
foreign key (userId) references users(userId);

insert users(userId, userName)
values (1, 'Jacek');
insert users(userId, userName)
values (2, 'Placek');

insert usersRoles(userId, roleName)
values (1, 'SuperUser');

--direction (left, right) defines table from which we want to get all rows:

--all rows from users table:
select u.userId, u.userName, ur.roleName from users u left outer join usersRoles ur on u.userId = ur.userId;
select u.userId, u.userName, ur.roleName from usersRoles ur right outer join users u on u.userId = ur.userId;

--all rows from usersRoles table:
select u.userId, u.userName, ur.roleName from users u right outer join usersRoles ur on u.userId = ur.userId;
select u.userId, u.userName, ur.roleName from usersRoles ur left outer join users u on u.userId = ur.userId;

