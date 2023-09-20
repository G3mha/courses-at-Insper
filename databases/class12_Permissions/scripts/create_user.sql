CREATE USER 'joao'@'localhost' IDENTIFIED BY 'abc123';
GRANT SELECT ON musica.* TO 'joao'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'ana'@'localhost' IDENTIFIED BY '456456';
GRANT SELECT ON tranqueira.* TO 'ana'@'localhost';
GRANT INSERT ON tranqueira.perigo TO 'ana'@'localhost';
REVOKE SELECT ON tranqueira.* FROM 'ana'@'localhost';
REVOKE INSERT ON tranqueira.perigo FROM 'ana'@'localhost';

CREATE USER 'joao'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON tranqueira.* TO 'joao'@'%';

CREATE USER 'u_ingest_multa'@'%' IDENTIFIED BY 'e7854285319f1c83fcd1';