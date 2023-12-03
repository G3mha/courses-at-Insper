INSERT INTO clinpag.uf (id_uf,sigla,descricao) VALUES
	 (1,'SP','São Paulo'),
	 (2,'MG','Minas Gerais'),
	 (3,'ES','Espirito Santo');

INSERT INTO clinpag.cidade (id_cidade,nome,id_uf) VALUES
	 (1,'São Paulo',1),
	 (2,'Campinas',1),
	 (3,'Socorro',1),
	 (4,'São Roque de Minas',2),
	 (5,'Delfinópolis',2),
	 (6,'Vitória',3),
	 (7,'Aracruz',3),
	 (8,'Capitólio',2);

INSERT INTO clinpag.clinica (id_clinica,nome_fantasia,cep,whatsapp,ativo,cnpj,id_cidade) VALUES
	 (1,'Rei do Bisturi','01500-000',NULL,'1',NULL,1),
	 (2,'Clínica do Coração','02200-000','(11) 90123-4567','1','48.954.239/0001-27',1),
	 (3,'Especialidades Chapadão','37928-000','(37) 98825-7000','1','58.351.201/0001-13',4),
	 (4,'Hospital Santa Rita',NULL,'(27) 33333-4444','0','37.802.267/0001-02',6),
	 (5,'Vila da Saúde','13051-005',NULL,'0',NULL,2),
	 (6,'Saúde TOP',NULL,'(11) 9876-1212','0','05.970.104/0001-42',1),
	 (7,'Clinipaz','13030-600','(19) 9765-1919','1','83.355.985/0001-03',2),
	 (8,'Hospital NS',NULL,'(37) 90023-3201','0',NULL,4);

INSERT INTO clinpag.medico (id_medico,nome,sobrenome,cpf,crm,id_uf_crm) VALUES
	 (1,'Pedro','Silva','123.456.789-12',12345,1),
	 (2,'Maria','Ferreira','321.654.987-12',543212,2),
	 (3,'Ana','Oliveira','987.456.123-12',345671,1),
	 (4,'José','Santos','456.123.789-12',234561,1),
	 (5,'Lucas','Alves','665.544.333-22',567892,1),
	 (6,'Luiz','Souza','778.899.001-23',67890,3),
	 (7,'Ricardo','Pereira','889.977.888-77',77777,3),
	 (8,'Gabriel','Gomes','998.877.666-55',88888,2),
	 (9,'Matheus','Moreira','443.322.111-23',99999,1),
	 (10,'Leonardo','Morais','665.544.332-21',1111234,3);
INSERT INTO clinpag.medico (id_medico,nome,sobrenome,cpf,crm,id_uf_crm) VALUES
	 (11,'Laura','Pereira','554.433.221-10',2112231,1),
	 (12,'Isabela','Carvalho','443.322.111-11',313222,3),
	 (13,'Gustavo','Simões','332.211.099-99',414,2),
	 (14,'Lucas','Barbosa','221.109.988-88',515120,2),
	 (15,'Vinicius','Fernandes','110.999.877-77',616,1);

INSERT INTO clinpag.paciente (id_paciente,nome,sobrenome,data_nascimento,cpf,id_cidade) VALUES
	 (1,'Joana','Rocha','1980-05-15','123.456.789-01',4),
	 (2,'Pedro','Silva','1995-10-10','856.123.458-02',7),
	 (3,'Marcelo','Santos','1988-03-25','432.156.987-03',2),
	 (4,'Laura','Fernandes','2002-12-30','963.258.147-04',5),
	 (5,'Miguel','Alves','2010-11-05','741.963.258-05',3),
	 (6,'Sofia','Pereira','2005-07-15','852.741.369-06',1),
	 (7,'Gustavo','Oliveira','1990-06-20','369.852.741-07',8),
	 (8,'Gabriel','Gonçalves','1998-01-30','258.963.741-08',6),
	 (9,'Emilly','Gomes','2003-09-15','963.369.852-09',2),
	 (10,'Leonardo','Duarte','1995-04-10','741.258.963-10',7);
INSERT INTO clinpag.paciente (id_paciente,nome,sobrenome,data_nascimento,cpf,id_cidade) VALUES
	 (11,'Henrique','Pereira','1992-07-25','258.741.963-11',3),
	 (12,'Lorena','Silva','1999-11-15','963.741.258-12',5),
	 (13,'Arthur','Santos','1997-03-10','741.258.963-13',1),
	 (14,'Giovanna','Oliveira','2001-02-25','963.741.258-14',1),
	 (15,'Matheus','Lima','1990-06-15','258.741.369-15',1),
	 (16,'Marina','Pereira','1998-09-30','369.741.852-16',1),
	 (17,'Miguel','Fernandes','2005-12-25','852.369.741-17',2),
	 (18,'Laura','Barbosa','2002-01-10','369.852.741-18',2),
	 (19,'Enzo','Carvalho','2010-07-05','741.852.369-19',3),
	 (20,'Sophia','Rocha','2003-03-20','369.741.258-20',1);

INSERT INTO clinpag.especialidade (id_especialidade,nome,descricao) VALUES
	 (1,'Dermatologia','Especialidade médica focada no diagnóstico e tratamento de doenças relacionadas à pele, cabelo e unhas.'),
	 (2,'Pediatria','Especialidade médica dedicada ao cuidado de bebês, crianças e adolescentes.'),
	 (3,'Medicina Interna','Especialidade médica focada em doenças e condições do adulto, cuidados com os órgãos, prevenção de doenças.'),
	 (4,'Medicina de Família','Especialidade médica focada na atenção à saúde abrangente para pessoas de todas as idades.'),
	 (5,'Obstetrícia e Ginecologia','Especialidade médica focada na gravidez, parto e saúde reprodutiva da mulher.'),
	 (6,'Cirurgia','Especialidade médica focada em procedimentos cirúrgicos operatórios incluindo cirurgia geral e especialidades cirúrgicas.'),
	 (7,'Psiquiatria','Especialidade médica dedicada ao diagnóstico e tratamento de transtornos mentais.'),
	 (8,'Radiologia','Especialidade médica focada em técnicas de imagem médica para diagnóstico e tratamento de doenças dentro do corpo.'),
	 (9,'Oftalmologia','Especialidade médica que lida com exame, diagnóstico, tratamento e gerenciamento de distúrbios e doenças do sistema visual e estruturas associadas.'),
	 (10,'Medicina de Emergência','Especialidade médica focada no cuidado de doenças agudas e estabilização de trauma envolvendo emergências médicas.');

INSERT INTO clinpag.medico_atende_clinica (id_medico,id_clinica,id_especialidade,ativo) VALUES
	 (1,6,2,1),
	 (1,6,7,0),
	 (1,8,10,0),
	 (2,1,9,1),
	 (2,2,9,0),
	 (2,5,4,1),
	 (2,6,9,1),
	 (2,8,6,1),
	 (2,8,10,1),
	 (4,1,7,1);
INSERT INTO clinpag.medico_atende_clinica (id_medico,id_clinica,id_especialidade,ativo) VALUES
	 (8,1,9,0),
	 (8,5,2,1),
	 (8,7,2,1),
	 (10,6,6,1),
	 (10,8,6,1),
	 (11,2,2,0),
	 (13,7,2,1),
	 (13,7,4,1),
	 (15,6,2,1),
	 (15,6,6,1);

INSERT INTO clinpag.consulta (id_consulta,id_paciente,data_hora,valor,id_medico,id_clinica,id_especialidade) VALUES
	 (1,6,'2023-08-15 11:00:00',250.00,2,1,9),
	 (2,13,'2023-08-15 17:00:00',300.00,1,6,7),
	 (3,13,'2023-09-05 13:00:00',150.00,1,6,2),
	 (4,6,'2023-10-05 12:00:00',80.00,10,6,6),
	 (5,6,'2023-10-06 14:00:00',150.00,1,6,7),
	 (6,15,'2023-08-15 15:00:00',270.00,11,2,2),
	 (7,20,'2023-08-15 16:00:00',200.00,15,6,6),
	 (8,7,'2023-08-15 12:00:00',150.00,10,8,6),
	 (9,7,'2023-08-16 15:00:00',170.00,10,8,6),
	 (10,10,'2023-08-16 08:00:00',625.00,1,8,10);
INSERT INTO clinpag.consulta (id_consulta,id_paciente,data_hora,valor,id_medico,id_clinica,id_especialidade) VALUES
	 (11,7,'2023-08-16 09:00:00',600.00,2,1,9),
	 (12,10,'2023-08-15 15:30:00',605.00,10,6,6),
	 (13,6,'2023-08-12 15:00:00',400.00,2,1,9),
	 (14,7,'2023-08-09 08:00:00',500.00,10,8,6),
	 (15,7,'2023-08-15 08:00:00',100.00,1,8,10),
	 (16,2,'2023-08-15 15:00:00',150.00,2,8,10),
	 (17,12,'2023-09-05 17:00:00',258.00,2,8,10),
	 (18,1,'2023-08-25 16:00:00',120.00,2,8,10),
	 (19,2,'2023-08-15 15:00:00',110.00,10,8,6),
	 (20,14,'2023-08-15 16:00:00',900.00,4,1,7);
INSERT INTO clinpag.consulta (id_consulta,id_paciente,data_hora,valor,id_medico,id_clinica,id_especialidade) VALUES
	 (21,12,'2023-08-15 17:00:00',375.00,2,8,10),
	 (22,1,'2023-08-13 08:00:00',350.00,10,8,6),
	 (23,1,'2023-08-15 19:00:00',354.00,10,8,6),
	 (24,1,'2023-08-02 15:00:00',248.00,1,8,10),
	 (25,2,'2023-10-15 15:00:00',275.00,1,8,10),
	 (26,6,'2023-08-02 14:00:00',450.00,2,1,9),
	 (27,12,'2023-08-03 15:00:00',85.00,2,8,6),
	 (28,2,'2023-08-04 15:00:00',900.00,1,6,2),
	 (29,10,'2023-08-22 08:00:00',940.00,1,6,7),
	 (30,2,'2023-08-25 16:00:00',980.00,1,6,2);
INSERT INTO clinpag.consulta (id_consulta,id_paciente,data_hora,valor,id_medico,id_clinica,id_especialidade) VALUES
	 (31,10,'2023-08-16 09:00:00',850.00,1,6,7),
	 (32,15,'2023-08-15 11:00:00',300.00,2,1,9),
	 (33,2,'2023-09-05 13:00:00',280.00,2,2,9),
	 (34,10,'2022-08-15 16:00:00',1500.00,2,2,9),
	 (35,2,'2023-09-05 13:00:00',1350.00,2,2,9),
	 (36,2,'2023-08-15 15:30:00',1450.00,2,2,9),
	 (37,2,'2023-08-19 16:00:00',1800.00,2,2,9),
	 (38,14,'2023-08-15 13:00:00',270.00,4,1,7),
	 (39,10,'2023-08-29 09:30:00',1490.00,2,2,9),
	 (40,10,'2023-08-30 09:30:00',1430.00,2,2,9);
INSERT INTO clinpag.consulta (id_consulta,id_paciente,data_hora,valor,id_medico,id_clinica,id_especialidade) VALUES
	 (41,15,'2023-09-13 17:00:00',45.00,8,7,2),
	 (42,16,'2023-09-12 17:00:00',60.00,8,7,2),
	 (43,20,'2022-07-05 17:00:00',30.00,8,7,2),
	 (44,18,'2023-08-19 16:00:00',45.00,8,1,9),
	 (45,15,'2023-08-21 09:30:00',30.00,8,1,9);
