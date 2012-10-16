CREATE DATABASE web2012 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON web2012.* TO 'web'@'localhost' IDENTIFIED BY 'asdf';

use web2012;


CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userid VARCHAR(100) NOT NULL UNIQUE,
	name VARCHAR(100),
	pwd VARCHAR(255) NOT NULL, 
	email VARCHAR(100) UNIQUE,
	country VARCHAR(100),
	gender CHAR(1) NOT NULL,
	favorites VARCHAR(255)
);

INSERT INTO users VALUES (1, 'dongseop', 'Dongseop Kwon', '12345', 'dongseop@gmail.com', 'KOREA','M', null);
INSERT INTO users VALUES (2, 'test1', 'test2', '12345', 'test@gmail.com', 'USA','M', null);
INSERT INTO users VALUES (3, 'testa', 'test2', '12345', 'testa@gmail.com', 'USA','F', null);
INSERT INTO users VALUES (4, 'testb', 'test2', '12345', 'testb@gmail.com', 'JAPAN','F', null);
INSERT INTO users VALUES (5, 'testc', 'test2', '12345', 'testc@gmail.com', 'USA','M', null);
INSERT INTO users VALUES (6, 'testd', 'test2', '12345', 'testd@gmail.com', 'KOREA','F', null);
INSERT INTO users VALUES (7, 'teste', 'test2', '12345', 'teste@gmail.com', 'USA','M', null);
