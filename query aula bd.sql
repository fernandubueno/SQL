/*comando para selecionar o banco de dados*/
use universidade_u;

show tables;

show create table aluno;

select * from aluno;
select * from telefone;
select * from endereco;
select * from curso;
select * from aluno_curso;
select * from gasto;
select * from projeto_funcionario;
select * from projeto;
select * from funcionario;
select * from disciplina;
select * from professor;

desc aluno;
desc telefone;
desc endereco;
desc projeto_funcionario2;
desc projeto;
desc funcionario;
desc disciplina;
desc professor;

insert into aluno(sexo, idade, data_inscricao_curso, telefone, valor_pago_curso, ativo_sn, endereco, nome) 
values('M', 18, '2023-08-01', '11 98423-6987', 400.50, 1, 'Avenida do Aviador, 3500, Natal - RN', 'Pedro');
    
select nome, idade, endereco from aluno
where idade >= 40 or sexo = 'F';

/*BETWEEN - buscará alunos entre esses valores*/
select * from aluno where idade between 40 and 65;
/*IN - buscará alunos exatamente com essa idade*/
select * from aluno where idade in (18, 65, 55);
/*LIKE - buscará alunos onde tenha a letra O no nome*/
select * from aluno where nome like '%o';

update aluno set ativo_sn = 0 where nome = 'João';
update aluno set ativo_sn = 0, valor_pago_curso = 750 where nome = 'José';    
    
delete from aluno where ativo_sn = 0;

insert into aluno(sexo, idade, data_inscricao_curso, telefone, valor_pago_curso, ativo_sn, endereco, nome) 
values('M', 55, '2018-12-01', '11 2455-0990', 645.22, 0, 'Avenida Paulista, 1500, ap315 - São Paulo - SP', 'João');

insert into aluno(sexo, idade, data_inscricao_curso, telefone, valor_pago_curso, ativo_sn, endereco, nome) 
values('M', 25, '2018-11-05', '11 2455-4563', 750.00, 0, 'Avenida Dom Pedro, 46, Fortaleza - CE', 'José');

alter table aluno add cpf varchar(14);
alter table aluno add email varchar(150) after idade;

alter table aluno modify column cpf varchar(14);

alter table aluno drop column cpf;

update aluno set cpf = '111.111.111-11' where nome = 'João';
update aluno set cpf = '222.222.222-22' where nome = 'Fernanda';
update aluno set cpf = '333.333.333-33' where nome = 'José';
update aluno set cpf = '444.444.444-44' where nome = 'Mariana';
update aluno set cpf = '555.555.555-55' where nome = 'Tereza';
update aluno set cpf = '666.666.666-66' where nome = 'Pedro';

alter table aluno modify cpf varchar(14) primary key;

alter table aluno drop cpf;

alter table aluno add idaluno int primary key auto_increment;

alter table aluno add logradouro varchar(100);
alter table aluno add numero varchar(10);
alter table aluno add complemento varchar(20);
alter table aluno add bairro varchar(100);
alter table aluno add cidade varchar(50);
alter table aluno add estado char(2);

update aluno set logradouro = '', numero = '', complemento = '', bairro = '', cidade = '', estado = '' where idaluno = 1;

alter table aluno drop endereco;

CREATE TABLE TELEFONE (idtelefone int auto_increment PRIMARY KEY,numero varchar(20), tipo char(3));

insert into telefone(numero, tipo) values('11 2455-0990', 'res');
insert into telefone(numero, tipo) values('11 2455-6547', 'res');
insert into telefone(numero, tipo) values('11 2455-4563', 'res');
insert into telefone(numero, tipo) values('11 3547-4563', 'res');
insert into telefone(numero, tipo) values('11 98423-1234', 'res');
insert into telefone(numero, tipo) values('11 98423-6987', 'res');
insert into telefone(numero, tipo) values('11 3333-4444', 'com');
insert into telefone(numero, tipo, fk_idaluno) values('11 2455-0990', 'res', 4);

alter table aluno drop column telefone;

alter table telefone add column fk_idaluno int;

ALTER TABLE TELEFONE ADD CONSTRAINT fk_aluno_telefone FOREIGN KEY (fk_idaluno) REFERENCES ALUNO (idaluno);

insert into telefone(numero, tipo, fk_idaluno) values('11 2455-0990', 'res', 4);
update telefone set fk_idaluno = 1 where numero in('11 2455-6547');
update telefone set fk_idaluno = 2 where numero in('11 2455-4563');
update telefone set fk_idaluno = 3 where numero in('11 3547-4563');
update telefone set fk_idaluno = 4 where numero in('11 98423-1234');
update telefone set fk_idaluno = 5 where numero in('11 98423-6987');

CREATE TABLE ENDERECO (
    idendereco int auto_increment PRIMARY KEY,
    logradouro varchar(100),
    numero varchar(10),
    complemento varchar(20),
    bairro varchar(100),
    cidade varchar(50),
    estado char(2),
    fk_idaluno int
);

ALTER TABLE ENDERECO ADD CONSTRAINT fk_aluno_endereco FOREIGN KEY (fk_idaluno) REFERENCES ALUNO (idaluno);
    
/*migrando os endereços da tabela aluno, para a tabela endereço*/    
INSERT INTO ENDERECO(logradouro, numero, complemento, bairro, cidade, estado, fk_idaluno) SELECT logradouro, numero, complemento, bairro, cidade, estado, idaluno FROM ALUNO;

ALTER TABLE ALUNO DROP COLUMN LOGRADOURO;
ALTER TABLE ALUNO DROP COLUMN NUMERO;
ALTER TABLE ALUNO DROP COLUMN COMPLEMENTO;
ALTER TABLE ALUNO DROP COLUMN BAIRRO;
ALTER TABLE ALUNO DROP COLUMN CIDADE;
ALTER TABLE ALUNO DROP COLUMN ESTADO;

CREATE TABLE CURSO (idcurso int auto_increment PRIMARY KEY, descricao varchar(50));

INSERT INTO curso(descricao) VALUES ('Curso Completo do Desenvolvedor NodeJS e MongoDB');
INSERT INTO curso(descricao) VALUES ('Desenvolvedor Multiplataforma Android e IOS');
INSERT INTO curso(descricao) VALUES ('Desenvolvimento Web com Angular');
INSERT INTO curso(descricao) VALUES ('Desenvolvimento Web Completo 2019');


CREATE TABLE ALUNO_CURSO (id_alunocurso int auto_increment PRIMARY KEY, fk_idaluno int, fk_idcurso int);

ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_aluno_curso FOREIGN KEY (fk_idaluno) REFERENCES ALUNO (idaluno);
 
ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_curso_aluno FOREIGN KEY (fk_idcurso) REFERENCES CURSO (idcurso);
    
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (1,3);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (1,4);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (2,2);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (3,1);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (3,2);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (3,3);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (3,4);
INSERT INTO ALUNO_CURSO(fk_idaluno, fk_idcurso) VALUES (4,1);

ALTER TABLE TELEFONE DROP COLUMN TIPO;
ALTER TABLE TELEFONE ADD tipo enum('res', 'com', 'cel');

UPDATE TELEFONE SET TIPO = 'RES' WHERE idtelefone = 1;
UPDATE TELEFONE SET TIPO = 'cel' WHERE idtelefone = 2;
UPDATE TELEFONE SET TIPO = 'com' WHERE idtelefone = 3;
UPDATE TELEFONE SET TIPO = 'cel' WHERE idtelefone = 4;
UPDATE TELEFONE SET TIPO = 'com' WHERE idtelefone = 5;
UPDATE TELEFONE SET TIPO = 'cel' WHERE idtelefone = 6;
UPDATE TELEFONE SET TIPO = 'res' WHERE idtelefone = 7;

ALTER TABLE telefone MODIFY COLUMN numero VARCHAR(20) NOT NULL;
ALTER TABLE telefone MODIFY COLUMN tipo enum('res', 'com', 'cel') NOT NULL;
ALTER TABLE telefone MODIFY COLUMN fk_idaluno INT NOT NULL;

ALTER TABLE endereco MODIFY COLUMN logradouro varchar(100) not null;
ALTER TABLE endereco MODIFY COLUMN numero varchar(10) not null;
ALTER TABLE endereco MODIFY COLUMN bairro varchar(100) not null;
ALTER TABLE endereco MODIFY COLUMN cidade varchar(50) not null;
ALTER TABLE endereco MODIFY COLUMN estado char(2) not null;
ALTER TABLE endereco MODIFY COLUMN fk_idaluno int NOT NULL;

ALTER TABLE aluno ADD CONSTRAINT uc_aluno_cpf UNIQUE(cpf);
ALTER TABLE aluno ADD CONSTRAINT uc_aluno_email UNIQUE(email);

ALTER TABLE endereco ADD CONSTRAINT uc_endereco_fkidaluno UNIQUE(fk_idaluno);

/*calcula quantos registros possuem a tabela aluno*/
SELECT COUNT(*) FROM aluno;
SELECT COUNT(DISTINCT nome) FROM aluno;
/*calcula o valor maximo pago*/
SELECT MAX(valor_pago_curso) FROM aluno;
/*calcula o valor minimo pago*/
SELECT MIN(valor_pago_curso) FROM aluno;
/*calcula a media de todos valores somado e divididos pela quantidade de registros*/
SELECT AVG(valor_pago_curso) FROM aluno;
/*soma todos os valores*/
SELECT SUM(valor_pago_curso) FROM aluno;

/*CEIL - arredonda o valor para cima*/
SELECT CEIL(17.5) AS valor;
/*FLOOR - arredonda o valor para baixo*/
SELECT FLOOR(17.5) AS valor;
/*TRUNCATE - quantidade de números mantidos após a virgula*/
/*no exemplo abaixo será mantido apenas dois digitos*/
SELECT TRUNCATE(17.5589, 2) AS valor;
/*ROUND - realiza o arredondamento dos números*/
/*abaixo será mantida apenas dois dígitos e o terceiro se*/
/* >= 5 arredonda para cima */
/* < 5 arredonda para baixo*/
SELECT ROUND(17.5564, 2) AS valor;
/*EXEMPLOS*/
SELECT nome, CEIL(valor_pago_curso) AS valor FROM aluno WHERE idaluno IN(1,4,5);
SELECT ROUND(AVG(valor_pago_curso), 2) AS média_paga FROM aluno WHERE idaluno IN(1,4,5);

/*Utilizando o Group By*/
SELECT nome, COUNT(*) AS repeticao_nome_agrupamento FROM aluno GROUP BY nome;
SELECT ativo_sn, COUNT(*) AS repeticao_ativo_sn_agrupamento FROM aluno GROUP BY ativo_sn;
SELECT ativo_sn, nome, COUNT(*) AS repeticao_agrupamento FROM aluno GROUP BY ativo_sn, nome;
SELECT ativo_sn, ROUND(AVG(valor_pago_curso), 2) AS media_agrupamento FROM aluno GROUP BY ativo_sn;
SELECT sexo, FLOOR(AVG(idade)) AS media_idade_por_sexo FROM aluno GROUP BY sexo;
SELECT sexo, MIN(idade) AS menor_idade, MAX(idade) AS maior_idade FROM aluno GROUP BY sexo;
SELECT estado, COUNT(*) AS total_por_estado FROM endereco GROUP BY estado;
SELECT tipo, COUNT(*) AS total_por_tipo FROM telefone GROUP BY tipo;


CREATE TABLE GASTO (
    idgasto int auto_increment PRIMARY KEY,
    ano int not null,
    tipo enum('previsto','realizado') not null,
    jan float(10,2),
    fev float(10,2),
    mar float(10,2),
    abr float(10,2),
    mai float(10,2),
    jun float(10,2),
    jul float(10,2),
    ago float(10,2),
    `set` float(10,2),
    `out` float(10,2),
    nov float(10,2),
    dez float(10,2)--
);


insert into gasto(ano, tipo, jan, fev, mar, abr, mai, jun, jul, ago, `set`, `out`, nov, dez)values('2019', 'previsto', 18000, 17000, 19000, 20000, 17000, 18000, 18500, 18500, 1800, 17500, 18000, 17000);
insert into gasto(ano, tipo, jan)values('2019', 'realizado', 18353.20);
update gasto set fev = 17555.55 where idgasto = 2;
update gasto set mar = 19435.73 where idgasto = 2;
update gasto set abr = 22753.12 where idgasto = 2;
update gasto set mai = 16198.12 where idgasto = 2;
update gasto set jun = 17451.88 where idgasto = 2;
update gasto set jul = 18975.40 where idgasto = 2;
update gasto set ago = 19163.84 where idgasto = 2;
update gasto set `set` = 18132.56 where idgasto = 2;
update gasto set `out` = 17667.91 where idgasto = 2;
update gasto set nov = 17936.33 where idgasto = 2;
update gasto set dez = 17125.88 where idgasto = 2;

/*tirando a média de gastos do últimos 12 meses*/
select truncate(((jan + fev + mar + abr + mai + jun + jul + ago + `set` + `out` + nov + dez)/12), 2) as media from gasto where idgasto = 2;

/*Subquerie de duas queries*/
SELECT
(SELECT jan FROM gasto WHERE idgasto = (SELECT idgasto FROM gasto WHERE ano = 2019 AND tipo = 'previsto')) AS previsto_jan,
(SELECT jan FROM gasto WHERE idgasto = (SELECT idgasto FROM gasto WHERE ano = 2019 AND tipo = 'realizado')) AS realizado_jan;

/*Subtração de duas queries*/
SELECT
(SELECT jan FROM gasto WHERE idgasto = (SELECT idgasto FROM gasto WHERE ano = 2019 AND tipo = 'previsto')) -
(SELECT jan FROM gasto WHERE idgasto = (SELECT idgasto FROM gasto WHERE ano = 2019 AND tipo = 'realizado')) AS resultado_jan;

ALTER TABLE aluno ADD data_nascimento DATE;

UPDATE aluno SET data_nascimento = '1960-05-01' WHERE idaluno = 1;
UPDATE aluno SET data_nascimento = '1980-06-12' WHERE idaluno = 2;
UPDATE aluno SET data_nascimento = '1982-01-07' WHERE idaluno = 3;
UPDATE aluno SET data_nascimento = '1970-03-04' WHERE idaluno = 4;
UPDATE aluno SET data_nascimento = '1985-12-21' WHERE idaluno = 5;
UPDATE aluno SET data_nascimento = '1991-01-21' WHERE idaluno = 6;

ALTER TABLE aluno DROP COLUMN idade;

/*TIMESTAMP (marca temporal) início à partir da meia noite do dia 01/01/1970*/
SELECT timestampdiff(YEAR, '1989-01-06',curdate()) AS idade;

/*calculo das idades da tabela aluno*/
SELECT data_nascimento, curdate() AS data_atual, timestampdiff(YEAR, data_nascimento,curdate()) AS idade FROM aluno;

SELECT idaluno, nome, data_nascimento, curdate() AS data_atual, timestampdiff(YEAR, data_nascimento, curdate()) AS idade FROM aluno;

/*query para identificar os aniversariantes do mês*/
SELECT 
	idaluno, 
    nome, 
    data_nascimento, 
    extract(month from data_nascimento) AS data_nascimento_mes,
    extract(day from data_nascimento) AS data_nascimento_dia,
    curdate() AS data_atual, 
    extract(month from curdate()) AS data_atual_mes,
	extract(day from curdate()) AS data_atual_dia,
    timestampdiff(YEAR, data_nascimento, curdate()) AS idade 
FROM 
	aluno
WHERE
	extract(month from data_nascimento) = extract(month from curdate());

/*criando os campos data_inscricao_curso e valor_pago_curso na tabela aluno_curso*/
ALTER TABLE aluno_curso ADD data_inscricao_curso DATE;
ALTER TABLE aluno_curso ADD valor_pago_curso FLOAT(10,2);

/*REFACTORING - migrando os dados da tabela aluno, para a tabela aluno_curso*/
UPDATE aluno_curso SET data_inscricao_curso = (SELECT data_inscricao_curso FROM aluno WHERE idaluno = 1), valor_pago_curso = (SELECT valor_pago_curso FROM aluno WHERE idaluno = 1) WHERE fk_idaluno = 1;
UPDATE aluno_curso SET data_inscricao_curso = (SELECT data_inscricao_curso FROM aluno WHERE idaluno = 2), valor_pago_curso = (SELECT valor_pago_curso FROM aluno WHERE idaluno = 2) WHERE fk_idaluno = 2;
UPDATE aluno_curso SET data_inscricao_curso = (SELECT data_inscricao_curso FROM aluno WHERE idaluno = 3), valor_pago_curso = (SELECT valor_pago_curso FROM aluno WHERE idaluno = 3) WHERE fk_idaluno = 3;
UPDATE aluno_curso SET data_inscricao_curso = (SELECT data_inscricao_curso FROM aluno WHERE idaluno = 4), valor_pago_curso = (SELECT valor_pago_curso FROM aluno WHERE idaluno = 4) WHERE fk_idaluno = 4;


/*tentativa de criar outra query*/
/*INSERT INTO aluno_curso(data_inscricao_curso, valor_pago_curso) SELECT data_inscricao_curso, valor_pago_curso FROM aluno WHERE idaluno = fk_idaluno;

INSERT INTO aluno_curso (data_inscricao_curso, valor_pago_curso)
SELECT a.data_inscricao_curso, a.valor_pago_curso
FROM aluno a
JOIN aluno_curso b ON a.idaluno = b.fk_idaluno;

INSERT INTO aluno_curso (fk_idaluno, data_inscricao_curso, valor_pago_curso)
SELECT a.idaluno, a.data_inscricao_curso, a.valor_pago_curso
FROM aluno a
JOIN aluno_curso b ON a.idaluno = b.fk_idaluno;
*/

/*removendo os campos criados na tabela aluno*/
ALTER TABLE aluno DROP COLUMN data_inscricao_curso;
ALTER TABLE aluno DROP COLUMN valor_pago_curso;

/* Constraint DEFAULT - faz com que sempre que um registro for inserido na tabela, o registro virá com aquele valor configurado */
/* no exemplo abaixo, sempre que um novo aluno for inserido, ele já virá com o registro 1 (ativo) */
ALTER TABLE aluno MODIFY COLUMN ativo_sn INT DEFAULT 1;

/* com o DEFAULT 1, o campo ativo_sn não é mais um campo obrigatório na inserção de dados */
INSERT INTO aluno(sexo, email, nome, cpf, data_nascimento)
VALUES('M', 'jorge@teste.com.br', 'Jorge', '444.111.111.15', '1989-01-06');

/* alterando o campo data_inscricao_curso para receber a data e hora atual do sistema */
ALTER TABLE aluno_curso MODIFY COLUMN data_inscricao_curso DATETIME DEFAULT current_timestamp;

alter table aluno_curso drop column id_alunocurso;

/* Chave Primária Composta */
alter table aluno_curso add constraint pk_aluno_curso primary key(fk_idaluno, fk_idcurso, data_inscricao_curso);

CREATE TABLE PROJETO_FUNCIONARIO (
    codigo_projeto int,
    matricula_funcionario int,
    nome_projeto varchar(100) not null,
    nome_funcionario varchar(50) not null,
    funcao_funcionario varchar(50) not null,
    telefone_funcionario varchar(20),
    data_criacao_projeto datetime default current_timestamp,
    horas_estimadas int not null,
    horas_realizadas int
);

alter table projeto_funcionario add constraint pk_projeto_funcionario primary key(codigo_projeto, matricula_funcionario);

/* alterar nome da coluna */
alter table projeto_funcionario change column nomefuncionario nome_funcionario varchar(50) not null;

insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (1, 100, 'Matricula Online', 'Bianca', 'Analista de Atendimento', 200);

insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (1, 110, 'Matricula Online', 'Fátima', 'Gerente de Atendimento', 100);

insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (1, 127, 'Matricula Online', 'Miguel', 'Analista Programados Senior', 500);

insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (2, 221, 'Economia de Papel', 'Laura', 'Analista de Qualidade', 200);

insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (3, 153, 'Notas Online', 'Carlos', 'Analista Administrativo', 150);

/*---NROMALIZAÇÃO - 2ª Forma normal---*/
CREATE TABLE projeto(
idcodigo INT auto_increment,
data_criacao datetime default current_timestamp,
nome varchar(100) not null,
constraint pk_projeto primary key(idcodigo));

create table funcionario(
idmatricula int auto_increment,
nome varchar(50) not null,
funcao varchar(50) not null,
telefone varchar(20),
constraint pk_funcionario primary key(idmatricula));

create table projeto_funcionario2(
fk_idcodigo int,
fk_idmatricula int,
horas_estimadas int not null,
horas_realizadas int,
constraint pk_projeto_funcionario primary key(fk_idcodigo, fk_idmatricula));

alter table projeto_funcionario2 add constraint foreign key (fk_idcodigo) references projeto(idcodigo);
alter table projeto_funcionario2 add constraint foreign key (fk_idmatricula) references funcionario(idmatricula);

/*duplicando um registro na tabela projeto funcionario*/
insert into projeto_funcionario(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values (2, 100, 'Economia de Papel', 'Bianca', 'Analista de Atendimento', 150);

select * from projeto_funcionario2;
select idcodigo, data_criacao, nome from projeto;
select idmatricula, nome, funcao, telefone from funcionario;

/*usando o distinct pois há um registro de funcionario duplicado*/
insert into funcionario(idmatricula, nome, funcao, telefone ) select distinct matricula_funcionario, nome_funcionario, funcao_funcionario, telefone_funcionario from projeto_funcionario;

/*ajustando o campo de data de criação dos projetos*/
update projeto_funcionario set data_criacao_projeto = '2024-03-31 20:40:52' where codigo_projeto = 2;
update projeto_funcionario set data_criacao_projeto = '2024-04-05 13:35:00' where codigo_projeto = 3;

/*migrando os dados da tabela projeto_funcionario para projeto*/
insert into projeto(idcodigo, data_criacao, nome) select distinct codigo_projeto, data_criacao_projeto, nome_projeto from projeto_funcionario;

/*migrando os dados da tabela projeto_funcionario para projeto_funcionario2*/
insert into projeto_funcionario2(fk_idcodigo, fk_idmatricula, horas_estimadas, horas_realizadas) select codigo_projeto, matricula_funcionario, horas_estimadas, horas_realizadas from projeto_funcionario;
/*após migrados todos os dados e realizada as normalizações, será apagada a tabela antiga projeto_funcionario e renomeada a nova tabela projeto_funcionario2*/
drop table projeto_funcionario;
rename table projeto_funcionario2 to projeto_funcionario;

/*NORMALIZAÇÃO - 3ª FORMA NORMAL*/
CREATE TABLE DISCIPLINA (
    iddisciplina int auto_increment,
    descricao varchar(50) not null,
    carga_horaria int,
    codigo_professor int,
    nome_professor varchar(50),
    email_professor varchar(50),
    fk_idcurso int,
    CONSTRAINT pk_iddisciplina PRIMARY KEY (iddisciplina)
);
 
ALTER TABLE DISCIPLINA ADD CONSTRAINT fk_curso_disciplina
    FOREIGN KEY (fk_idcurso)
    REFERENCES CURSO (idcurso);

/*Curso Completo do Desenvolvedor NodeJS e MongoDB*/
INSERT INTO disciplina(descricao, carga_horaria, codigo_professor, nome_professor, email_professor, fk_idcurso)
values('NodeJS', 7, 100, 'Jorge', 'jorge@teste.com.br', 1);
INSERT INTO disciplina(descricao, carga_horaria, codigo_professor, nome_professor, email_professor, fk_idcurso)
values('Express', 2, 120, 'Pedro', 'pedro@teste.com.br', 1);
INSERT INTO disciplina(descricao, carga_horaria, codigo_professor, nome_professor, email_professor, fk_idcurso)
values('MongoDB', 5, 130, 'Julia', 'julia@teste.com.br', 1);
INSERT INTO disciplina(descricao, carga_horaria, codigo_professor, nome_professor, email_professor, fk_idcurso)
values('MongoDB', 7, 100, 'Jorge', 'jorge1010@teste.com.br', 1);

CREATE TABLE PROFESSOR (
    idprofessor int auto_increment,
    nome varchar(50) not null,
    email varchar(100),
    CONSTRAINT pk_professor PRIMARY KEY(idprofessor)
);

SELECT codigo_professor, nome_professor, email_professor FROM disciplina;

INSERT INTO professor(idprofessor, nome, email)
values(100, 'Jorge', 'jorge@teste.com.br');
INSERT INTO professor(idprofessor, nome, email)
values(120, 'Pedro', 'pedro@teste.com.br');
INSERT INTO professor(idprofessor, nome, email)
values(130, 'Julia', 'julia@teste.com.br');

/*Este comando redefine completamente o modo SQL, desativando todos os modos especiais. 
Ou seja, ele limpa todas as configurações de modo que poderiam estar ativas, 
deixando o servidor sem nenhuma das restrições de comportamento padrão que esses modos podem impor. 
Isto é, após executar este comando, nenhuma regra específica será aplicada às suas consultas SQL; 
elas serão processadas sem restrições adicionais de modo SQL, 
como checagem de chaves estrangeiras para tabelas InnoDB, tratamento de valores NULL, etc.*/
SET sql_mode = '';

/*Restaurar o MYSQL para o padrão de fábrica (reverter comando anterior)*/
SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

/*Desativar apenas ONLY_FULL_GROUP_BY*/
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

/*Realizando o select para pegar registros repetidos e calcular quantos são repetidos*/
SELECT codigo_professor, count(*) as repeticoes, nome_professor, email_professor FROM disciplina GROUP BY codigo_professor;

ALTER TABLE disciplina DROP COLUMN nome_professor;
ALTER TABLE disciplina DROP COLUMN email_professor;

ALTER TABLE disciplina RENAME COLUMN codigo_professor to fk_idprofessor;

/*-----------------------------------------------------------------------------------------------------------------------------------------*/
/*criando uma referência unária na tabela*/
/*adicionando o campo para relacionar os funcionários a um supervisor*/
ALTER TABLE disciplina ADD CONSTRAINT fk_disciplina_professor FOREIGN KEY (fk_idprofessor) REFERENCES professor (idprofessor);

ALTER TABLE funcionario ADD COLUMN fk_idmatricula_supervisor int;

ALTER TABLE funcionario ADD CONSTRAINT fk_funcionario_supervisor FOREIGN KEY(fk_idmatricula_supervisor) REFERENCES funcionario(idmatricula);

INSERT INTO funcionario(nome, funcao) VALUES('Pedro', 'Gerente de TI');
INSERT INTO funcionario(nome, funcao) VALUES('João', 'Analista Financeiro');

UPDATE funcionario SET fk_idmatricula_supervisor = 110 WHERE idmatricula = 100;
UPDATE funcionario SET fk_idmatricula_supervisor = 222 WHERE idmatricula = 127;
UPDATE funcionario SET fk_idmatricula_supervisor = 110 WHERE idmatricula in (153, 221, 223);

/*Truncate é um remoção de dados da tabela, porém limpando a integridade referencial*/
/*diferente do delete, as primary keys serão zeradas usando o truncate, porém com o delete, as primary darão continuidade no número que parou*/
TRUNCATE TABLE ALUNO;

/*Esse comando desabilita a integridade referencial que permite usar o TRUNCATE em tabelas referência*/
SET foreign_key_checks = 0;

/*AUTO_INCREMENT - comando usado para alterar a sequência do auto_increment*/
/*esse comando ajuste a chave primária para o valor 300, caso esteja abaixo desse número, porém caso já tenha passado de 300, esse comando não terá resultado*/
ALTER TABLE telefone auto_increment = 300;
/*abaixo um exemplo da lógica usada pelo auto_increment, por esse motivo o ajuste sempre resultará para o último número + 1*/
SELECT MAX(idtelefone) + 1 FROM telefone;

/*Alterando a ordem das colunas, o comando abaixo é um exemplo, onde o ddl colunas será substituído pelo comando de criação da tabela*/
ALTER TABLE aluno MODIFY ddl_coluna FIRST;
/*No exemplo abaixo, utilizei o show create table para coletar a criação do atributo idaluno, e substituí pelo ddl coluna*/
ALTER TABLE aluno MODIFY `idaluno` int NOT NULL AUTO_INCREMENT FIRST;
/*outra possibilidade é usar o comando after, como no exemplo abaixo*/
ALTER TABLE aluno MODIFY  `nome` varchar(25) DEFAULT NULL AFTER idaluno;

/*LEFT JOIN - realizando dois joins à esquerda, priorizando os dados da tabela curso*/
SELECT * FROM curso LEFT JOIN disciplina ON (curso.idcurso = disciplina.fk_idcurso) LEFT JOIN professor ON (disciplina.fk_idprofessor = professor.idprofessor);

/*RIGHT JOIN - realizando um join à direita, priorizando os dados da tabela disciplina, e adicionando apelidos para as tabelas*/
SELECT * FROM curso c RIGHT JOIN disciplina d ON (c.idcurso = d.fk_idcurso);

/*Inner Join - selecionando somente os dados que estejam nas duas tabelas*/
SELECT * FROM disciplina d INNER JOIN professor p ON (d.fk_idprofessor = p.idprofessor);

/*UNION e UNION ALL*/
/* a clausula UNION funciona como um distinct, e se houver resultados repetidos, a clausula union não retornará os resultados duplicados*/
SELECT 'morango' as C1
UNION
SELECT 'uva'
UNION
SELECT 'morango'
UNION
SELECT 'abacaxi';

/*além disso as clausulas precisam ter o mesmo número de colunas*/
SELECT 100, 500
UNION ALL
SELECT 100,300
UNION ALL
SELECT 500, 700;

/*Dependendo do SGBD, se a ordem for alterada, ou seja, as colunas não forem do mesmo tipo, haverá erro*/
SELECT 100, 200, 'abacaxi'
UNION ALL
SELECT 500, 'uva', 700;

/*o FULL OUTER JOIN não é suportado por todos os SGBDs, porém ele é uma mescla do left e do right join*/
SELECT * FROM disciplina d FULL OUTER JOIN professor p ON (d.fk_idprofessor = p.idprofessor);
/*abaixo está o comando feito acima, porém com o right e o left join, lembrando que o comando UNION faz o DISTINCT*/
SELECT * FROM disciplina d RIGHT JOIN professor p ON (d.fk_idprofessor = p.idprofessor) UNION 
SELECT * FROM disciplina d LEFT JOIN professor p ON (d.fk_idprofessor = p.idprofessor);

/*STORED PROCEDURES - são procedimentos armazenados no banco de dados que podem ser chamados a qualquer momento*/

/*listar procedures do Banco de Dados*/
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE Db = 'universidade_guarulhos';

/*o uso do comando delimiter, serve para que ao criar a procedure, o bd não pare a cada ";" indicaremos que o fim dela está no "$$"*/
delimiter $$
CREATE PROCEDURE proc_oi()
BEGIN
SELECT 'Oi, você acabou de executar um procedimento que está armazenado no BD' AS msg;
END
$$
delimiter ;

/*CALL - comando usado para chamar a procedure*/
CALL proc_oi();

/*mostrar o conteúdo de criação da procedure*/
SHOW CREATE PROCEDURE proc_oi;

/*Para alterar a procedure, pode-se usar o ALTER PROCEDURE*/
/*porém se for alterar a lógica da procedure, é necessário remover (DROP) e criar (CREATE) a procedure novamente*/

/*Procedure (de entrada) com parâmetros*/
/*o comando delimiter irá definir que a procedure irá finalizar com o $$ e não com ;*/
delimiter $$
CREATE PROCEDURE proc_media_ponderada(
	IN nome VARCHAR(100),
    IN p1 FLOAT(3,1),
    IN p2 FLOAT(3,1),
	IN p3 FLOAT(3,1),
    IN p4 FLOAT(3,1)
)
COMMENT 'Efetua o cálculo de média ponderada: ((p1*2)+(p2*2)+(p3*3)+(p4*3)) / 10'
BEGIN
	SELECT nome, round((((p1*2)+(p2*2)+(p3*3)+(p4*3)) / 10), 1) AS 'média_ponderada';
END
$$
delimiter ;

/*comando para executar a procedure criada acima*/
CALL `universidade_guarulhos`.`proc_media_ponderada`('Fernando', 6, 7, 10, 8);
CALL `universidade_guarulhos`.`proc_media_ponderada`('João', 8, 7, 5, 9);
CALL `universidade_guarulhos`.`proc_media_ponderada`('Maria', 6.5, 4.2, 9.9, 8.7);

/*Procedure (de saída) com parâmetros*/
delimiter $$
CREATE PROCEDURE proc_resumo(OUT total_professores INT, OUT total_alunos INT)
COMMENT 'Resumo do total de alunos e professores'
BEGIN
	/*total de professores*/
	SELECT COUNT(*) INTO total_professores FROM professor;
    
    /*total de alunos*/
    SELECT COUNT(*) INTO total_alunos FROM aluno;
END
$$
delimiter ;

/*Comando para chamar e selecionar a procedure*/
CALL proc_resumo(@x, @y);
SELECT @x as total_professores, @y as total_alunos;

