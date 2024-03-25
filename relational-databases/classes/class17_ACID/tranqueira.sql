DROP DATABASE IF EXISTS tranqueira;
CREATE DATABASE tranqueira;
USE tranqueira;

CREATE TABLE comida (
    id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(30),
    idPerigo INT,
    PRIMARY KEY (id)
);

CREATE TABLE perigo (
    id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(20),
    PRIMARY KEY (id)
);

ALTER TABLE comida ADD CONSTRAINT fk_perigo FOREIGN KEY (idPerigo) REFERENCES perigo (id);

INSERT INTO perigo VALUES (1, 'Cardiaco'), (2, 'Intestinal'), (3, 'Dermatologico'), (4, 'Mental');
INSERT INTO comida VALUES (1, 'Torresmo', 1), (2, 'Alface', NULL), (3, 'Coxinha', 2), (4, 'Espetinho', 2);

SELECT * FROM comida;
SELECT * FROM perigo;
