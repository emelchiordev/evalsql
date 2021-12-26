CREATE DATABASE MovieTheaterBooking;
CREATE USER admin_odyssee WITH ENCRYPTED PASSWORD 've45vetlor';
GRANT ALL PRIVILEGES ON DATABASE MovieTheaterBooking TO admin_odyssee;

CREATE table customers (
	id serial PRIMARY KEY,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	address VARCHAR(200),
	email VARCHAR(50) NOT NULL,
	phoneNumber VARCHAR(10) NOT NULL
);

CREATE table movies (
	id serial PRIMARY KEY,
	title VARCHAR(50),
	description TEXT
);

CREATE TABLE users(
	id serial PRIMARY KEY,
	email VARCHAR(50) NOT NULL,
	password UUID NOT NULL
);

CREATE TABLE admins(
	users_id serial PRIMARY KEY,
	FOREIGN KEY(users_id) REFERENCES users(id)
);

CREATE TABLE complex (
	id serial PRIMARY KEY,
	users_id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(200) NOT NULL,
	FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE rooms (
	id serial,
	complex_id INT NOT NULL,
	name VARCHAR(30) NOT NULL,
	totalSeats INT NOT NULL,
	FOREIGN KEY (complex_id) REFERENCES complex(id) ON DELETE CASCADE,
	PRIMARY KEY (id,complex_id)
);

CREATE table sessions (
	id serial PRIMARY KEY,
	users_id INT NOT NULL,
	movie_id INT NOT NULL,
	complex_id INT NOT NULL,
	dateSession DATE NOT NULL,
	startHour TIME NOT NULL,
	endHour TIME NOT NULL,
	FOREIGN KEY(users_id) REFERENCES users(id),
	FOREIGN KEY(movie_id) REFERENCES movies(id),
	FOREIGN KEY(complex_id) REFERENCES complex(id)
	
);

create table prices(
	id serial PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	amount DECIMAL(5,2) NOT NULL
);

CREATE table bookings (
	id serial PRIMARY KEY,
	session_id INT NOT NULL,
	customer_id INT NOT NULL,
	price_id INT NOT NULL,
	bookingNumber VARCHAR(10) NOT NULL UNIQUE,
	dateBooking date NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(id),
	FOREIGN KEY (session_id) REFERENCES sessions(id),
	FOREIGN KEY (price_id) REFERENCES prices(id)
);

CREATE table payments_tickets (
	id serial PRIMARY KEY,
	numTicket serial,
	booking_id INT NOT NULL,
	datePayment DATE,
	amount DECIMAL(5,2),
	FOREIGN KEY (booking_id) REFERENCES bookings(id)
);


-- CREATION DES CLIENTS
insert into customers (firstname, lastname, address, email, phonenumber) values ('Herrick', 'Rulton', '1661 Lighthouse Bay Park', 'hrulton0@hostgator.com', '0413774057');
insert into customers (firstname, lastname, address, email, phonenumber) values ('Daron', 'Brakespear', '004 Service Point', 'dbrakespear1@mysql.com', '0965099887');
insert into customers (firstname, lastname, address, email, phonenumber) values ('Costa', 'Ram', '2327 Bay Avenue', 'cram2@apple.com', '0443647042');
insert into customers (firstname, lastname, address, email, phonenumber) values ('Terry', 'Alen', '709 Amoth Drive', 'talen3@linkedin.com', '0065057416');


-- CREATION DES PRIX
insert into prices (name, amount) values 
('FullPrice',9.20),
('Student',7.60),
('less14years',5.90);

-- CREATION DES FILMS
insert into movies (title, description) values ('Las Vegas Story, The', 'Crime|Drama|Film-Noir');
insert into movies (title, description) values ('Plankton', 'Horror');
insert into movies (title, description) values ('Hannie Caulder', 'Comedy|Crime|Drama|Western');
insert into movies (title, description) values ('Old Gringo', 'Drama');

-- CREATION DES USERS
insert into users (email, password) values ('cscrymgeour0@cpanel.net', '1ae2825f-b9e9-4b9a-b0bc-90c8aaad3f11');
insert into users (email, password) values ('ycleverley1@wp.com', '4497a75e-f1d9-46ca-b7ec-ca2bc3f065f1');
insert into users (email, password) values ('bbulfield2@rambler.ru', 'a1ba0b17-d714-4868-a61e-bdfbb086b404');
insert into users (email, password) values ('lharm3@fc2.com', '466f7b2c-942e-422d-91b3-98dab2b6798c');
insert into users (email, password) values ('lhassdfm3@0dsc2.com', '466f7b2c-942e-422d-91b3-98dab2b6798c');

-- CREATION D'UN USER ADMIN
insert into admins (users_id) values (4);


-- CREATION DES COMPLEXES
insert into complex (name, address, users_id) values ('Home Ing', '50 Old Gate Alley',1);
insert into complex (name, address, users_id) values ('It', '4 Gerald Avenue',2);
insert into complex (name, address, users_id) values ('Wrapsafe', '14683 Fair Oaks Terrace',3);
insert into complex (name, address, users_id) values ('Voltsillam', '2 Kings Drive',4);

-- CREATION DES SALLES
insert into rooms (complex_id, name, totalSeats) values (1, 'Bigtax', 300);
insert into rooms (complex_id, name, totalSeats) values (1, 'Keylex', 300);
insert into rooms (complex_id, name, totalSeats) values (1, 'Solarbreeze', 300);
insert into rooms (complex_id, name, totalSeats) values (1, 'Job', 300);
insert into rooms (complex_id, name, totalSeats) values (2, 'Transcof', 400);
insert into rooms (complex_id, name, totalSeats) values (3, 'Solarbreeze', 450);
insert into rooms (complex_id, name, totalSeats) values (3, 'Transcof', 450);
insert into rooms (complex_id, name, totalSeats) values (4, 'Bytecard', 300);
insert into rooms (complex_id, name, totalSeats) values (4, 'Redhold', 300);
insert into rooms (complex_id, name, totalSeats) values (4, 'Job', 300);

-- CREATION DES SEANCES
insert into sessions (users_id, movie_id, complex_id, dateSession, startHour, endHour) values
(1,1,1,'2021-12-12','20:00:00','21:12:00'),
(1,2,1,'2021-12-26','20:00:00','21:40:00'),
(1,3,1,'2021-12-31','20:00:00','21:30:00'),
(2,1,2,'2022-01-12','20:00:00','21:12:00'),
(3,3,3,'2021-12-31','20:00:00','21:30:00'),
(4,1,4,'2022-01-12','20:00:00','21:12:00')
;

-- CREATION DES RESERVATIONS
insert into bookings (session_id, customer_id, price_id, bookingNumber, dateBooking) values
(1,1,1,'NUM-001','2021-11-10'),
(1,2,3,'NUM-002','2021-11-10'),
(1,3,2,'NUM-003','2021-11-10')
;

-- CREATION DES PAIEMENTS
insert into payments_tickets (booking_id,datePayment, amount) values
(1,'2021-11-10',9.20),
(1,'2021-11-10',5.90),
(1,'2021-11-10',7.60)
;
