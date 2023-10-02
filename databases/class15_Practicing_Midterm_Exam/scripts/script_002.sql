INSERT INTO `cartracking`.`cliente` (`nome`, `cpf`, `endereço`) VALUES ('Ana Maria', '833.852.810-24', 'Rua das Amoreiras, 781');
INSERT INTO `cartracking`.`cliente` (`nome`, `cpf`, `endereço`) VALUES ('Francisco Pereira', '722.870.980-20', 'Av. Paulista, 225');
INSERT INTO `cartracking`.`cliente` (`nome`, `cnpj`, `endereço`) VALUES ('Os Tartarugas Fast and Furious', '12.361.842/0001-58', 'Rua Santa Ifigênia, 800');
INSERT INTO `cartracking`.`cliente` (`nome`, `cnpj`, `endereço`) VALUES ('Universo dos Transportes de Luxo', '31.780.614/0001-67', 'Travessa das Mochilas, 1762');
INSERT INTO `cartracking`.`cliente` (`nome`, `cnpj`, `endereço`) VALUES ('Agromil', '97.861.127/0001-37', 'Av Campo Grande, 1818');

INSERT INTO cartracking.servico (servico,descricao,preco_base,disponivel_venda)
	VALUES ('SIMPLETRACK','Tracking menos frequente',19.9,1);
INSERT INTO cartracking.servico (servico,descricao,preco_base,disponivel_venda)
	VALUES ('FULLTRACK','Tracking mais frequente',39.8,1);
INSERT INTO cartracking.servico (servico,descricao,preco_base,disponivel_venda)
	VALUES ('BRUTTOX','Escolta Armada',1999.99,0);
INSERT INTO cartracking.servico (servico,descricao,preco_base,disponivel_venda)
	VALUES ('MOTORLOCK','Lock remoto do veículo',49.9,1);


INSERT INTO cartracking.marca (marca)
	VALUES ('Volkswagen');
INSERT INTO cartracking.marca (marca)
	VALUES ('Toyota');
INSERT INTO cartracking.marca (marca)
	VALUES ('Hyundai');
INSERT INTO cartracking.marca (marca)
	VALUES ('Jeep');
INSERT INTO cartracking.marca (marca)
	VALUES ('Renault');
INSERT INTO cartracking.marca (marca)
	VALUES ('Honda');
INSERT INTO cartracking.marca (marca)
	VALUES ('Nissan');
INSERT INTO cartracking.marca (marca)
	VALUES ('Peugeot');

INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Jetta',1);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Leaf',7);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Taos',1);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('HB20',3);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('RAV4',2);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Sentra',7);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Kicks',7);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Civic',6);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('HR-V',6);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Creta',3);
INSERT INTO cartracking.modelo (modelo,idmarca)
	VALUES ('Corolla',2);

INSERT INTO cartracking.tipo (descricao)
	VALUES ('LITE');
INSERT INTO cartracking.tipo (descricao)
	VALUES ('PRECISION');
INSERT INTO cartracking.tipo (descricao)
	VALUES ('SPACEFULL');

    
    
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2005,4,11,0);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2018,5,1,0);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2015,4,5,0);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2018,5,7,1);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (1999,1,8,0);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2022,5,7,0);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2019,4,6,1);
INSERT INTO cartracking.automovel (ano,idcliente,idmodelo,travado)
	VALUES (2023,5,1,0);

INSERT INTO cartracking.rastreador (idautomovel,idtipo,ativo) VALUES
	 (1,1,1),
	 (2,2,0),
	 (3,1,1),
	 (8,1,1),
	 (7,1,1),
	 (6,2,1),
	 (NULL,2,1),
	 (6,1,0),
	 (1,2,0),
	 (NULL,2,1);
INSERT INTO cartracking.rastreador (idautomovel,idtipo,ativo) VALUES
	 (NULL,2,1);
    
INSERT INTO cartracking.automovel_has_servico (idautomovel,idservico,ativo) VALUES
	 (1,2,1),
	 (8,4,1),
	 (1,4,1),
	 (8,1,0),
	 (7,2,1),
	 (6,4,1),
	 (5,2,1),
	 (5,4,1),
	 (4,1,1),
	 (3,4,1);
INSERT INTO cartracking.automovel_has_servico (idautomovel,idservico,ativo) VALUES
	 (3,1,1),
	 (4,4,1),
	 (4,2,0),
	 (8,2,1),
	 (2,1,1),
	 (2,4,0);

INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-46.56376,-23.51799,705.0,85.42,1,85.7,29.1,'2023-01-01 19:47:55');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-46.56907,-23.51799,712.0,87.0,1,89.2,29.2,'2023-01-01 19:52:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-47.04609,-22.71835,652.0,89.91,1,87.5,29.1,'2023-01-02 19:57:03');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-47.12901,-22.52341,642.0,95.4,1,90.2,30.5,'2023-01-02 02:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-47.15799,-22.11923,637.0,72.9,1,90.1,30.3,'2023-01-02 03:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-54.75013,-20.42616,591.0,95.4,2,99.5,45.1,'2013-05-17 15:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-55.23157,-21.65487,584.0,98.7,2,102.8,48.7,'2013-05-17 16:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-55.56489,-22.13285,576.0,96.1,2,115.8,46.5,'2013-05-17 17:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-63.00327,-5.69254,47.0,145.7,3,82.53,28.91,'2015-08-22 07:30:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-40.65498,-9.51254,1200.0,92.45,4,88.6,49.75,'2014-06-05 09:30:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-41.54564,-9.54689,1213.0,88.4,4,87.5,48.2,'2014-06-06 09:30:02');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-41.56485,-10.78781,1248.0,98.7,4,82.8,33.4,'2014-06-07 09:30:01');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-42.09981,-11.11891,900.0,102.18,4,89.49,50.5,'2014-06-08 09:30:03');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-75.65464,-12.89799,0.0,77.5,5,74.13,25.9,'2023-02-02 11:45:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-72.08521,-13.46708,3399.0,88.7,5,89.92,33.4,'2023-02-06 11:45:01');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-72.08521,-13.46708,3399.0,0.0,5,19.4,19.3,'2023-02-05 11:45:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-63.23911,-18.27962,400.0,45.13,5,82.74,36.1,'2023-02-04 11:45:02');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-63.23788,-18.13235,400.0,33.86,5,80.1,41.7,'2023-02-08 11:45:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-63.65456,-18.32556,402.0,0.0,5,25.8,28.4,'2023-02-07 11:45:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-46.56378,-23.51788,704.0,0.0,8,60.5,18.49,'2022-12-22 16:00:00');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-46.56378,-23.51788,704.0,0.0,8,22.1,19.54,'2022-12-23 16:00:01');
INSERT INTO cartracking.evento (latitude,longitude,altitude,velocidade,idrastreador,temperatura_motor,temperatura_externa,`data`)
	VALUES (-47.56549,-23.65654,651.0,40.41,8,82.74,17.8,'2022-12-24 16:00:02');
