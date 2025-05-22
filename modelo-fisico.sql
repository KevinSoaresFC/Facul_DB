create database db_sistema_faculdade;

use db_sistema_faculdade;

show databases;

show tables;


CREATE TABLE tbl_cursos (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tempo_curso INT NOT NULL,
    coordenador VARCHAR(100),
    nome_curso VARCHAR(100),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_alunos (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    data_nascimento DATE,
    cpf CHAR(11),
    telefone VARCHAR(15),
    email VARCHAR(150),
    id_cursos INT NOT NULL,
    
    FOREIGN KEY (id_cursos) REFERENCES tbl_cursos(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_endereco (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    estado CHAR(2),
    cidade VARCHAR(100),
    bairro VARCHAR(100),
    rua VARCHAR(100),
    cep CHAR(8),
    id_alunos INT NOT NULL,
    FOREIGN KEY (id_alunos) REFERENCES tbl_alunos(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_professores (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_materias (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    carga_horaria INT NOT NULL,
    nome_materia VARCHAR(100),
    id_cursos INT NOT NULL,
    FOREIGN KEY (id_cursos) REFERENCES tbl_cursos(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_salas (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    semestre VARCHAR(10),
    id_professores INT NOT NULL,
    id_materias INT NOT NULL,
    FOREIGN KEY (id_professores) REFERENCES tbl_professores(id),
    FOREIGN KEY (id_materias) REFERENCES tbl_materias(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_matricula (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    situacao_matricula VARCHAR(45),
    data_entrada DATE,
    forma_ingresso VARCHAR(45),
    turma VARCHAR(45),
    id_turmas INT NOT NULL,
    id_alunos INT NOT NULL,
    FOREIGN KEY (id_alunos) REFERENCES tbl_alunos(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_nota (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nota_parcial1 DECIMAL(5,2),
    nota_parcial2 DECIMAL(5,2),
    nota_final DECIMAL(5,2),
    id_matricula INT NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES tbl_matricula(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_mensalidade (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2),
    vencimento DECIMAL(10,2),
    situacao TINYINT,
    id_aluno INT NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES tbl_alunos(id),
    
    UNIQUE INDEX (id)
);

CREATE TABLE tbl_pagamento (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    forma_pagamento VARCHAR(30),
    quantia_paga DECIMAL(10,2),
    data_pagamento DATE,
    id_mensalidade INT NOT NULL,
    FOREIGN KEY (id_mensalidade) REFERENCES tbl_mensalidade(id),
    
    UNIQUE INDEX (id)
);

select * from tbl_cursos;
select * from tbl_professores;
select * from tbl_alunos;
select * from tbl_nota;
select * from tbl_matricula;
select * from tbl_materias;
select * from tbl_salas;
select * from tbl_endereco;
select * from tbl_mensalidade;
select * from tbl_pagamento;
describe tbl_salas;
describe tbl_materias;
describe tbl_matricula;
describe tbl_nota;
describe tbl_mensalidade;



INSERT INTO tbl_professores (nome, email, telefone) VALUES
('Carlos Silva', 'carlos.silva@faculdade.edu', 11987654321),
('Maria Souza', 'maria.souza@faculdade.edu', 11996543210),
('João Pereira', 'joao.pereira@faculdade.edu', 11995432123);



INSERT INTO tbl_cursos (id, tempo_curso, coordenador, nome_curso) VALUES
(1, 4, 'Prof. Ana Lima', 'Engenharia de Software'),
(2, 3, 'Prof. João Silva', 'Análise e Desenvolvimento de Sistemas'),
(3, 5, 'Prof. Carla Mendes', 'Ciência da Computação');


INSERT INTO tbl_materias (id, carga_horaria, nome_materia, id_cursos) VALUES
(1, '60', 'Programação ', 1),
(2, '80', 'Banco de Dados', 2),
(3, '40', 'Redes de Computadores', 3);


-- Inserção na tabela salas
INSERT INTO tbl_salas (id, semestre, id_professores, id_materias) VALUES
(1, '2024.1', 1, 1),
(2, '2024.2', 2, 2),
(3, '2025.1', 3, 3);


INSERT INTO tbl_alunos (id, nome, data_nascimento, cpf, telefone, email, id_cursos) VALUES
(1, 'João Pedro', '2000-01-15', '12345678901', '11999990000', 'joao.pedro@email.com', 1),
(2, 'Maria Clara', '2001-06-23', '98765432100', '11988880000', 'maria.clara@email.com', 2),
(3, 'Lucas Lima', '1999-11-05', '45678912300', '11977770000', 'lucas.lima@email.com', 3);


INSERT INTO tbl_endereco (id, estado, cidade, bairro, cep, id_alunos) VALUES
(1, 'SP', 'São Paulo', 'Centro', '01000000', 1),
(2, 'RJ', 'Rio de Janeiro', 'Copacabana', '22000000', 2),
(3, 'MG', 'Belo Horizonte', 'Savassi', '30140000', 3);


INSERT INTO tbl_matricula (id, situacao_matricula, forma_ingresso, data_entrada, id_turmas, id_alunos) VALUES
(1, 'ativa', 'Vestibular', '2024-02-01', 1, 1),
(2, 'ativa', 'Transferência', '2024-02-01', 2, 2),
(3, 'trancada', 'ENEM', '2024-03-01', 3, 3);


INSERT INTO tbl_nota (id, nota_parcial1, nota_parcial2, nota_final, id_matricula) VALUES
(1, 7.5, 8.0, 7.8, 1),
(2, 6.0, 7.0, 6.5, 2),
(3, 9.0, 9.5, 9.3, 3);


INSERT INTO tbl_mensalidade (id, valor, vencimento, situacao, id_aluno) VALUES
(1, 1200.00, 10.00, 1, 1),
(2, 1100.50, 15.00, 0, 2),
(3, 1300.00, 5.00, 1, 3);


INSERT INTO tbl_pagamento (id, forma_pagamento, quantia_paga, data_pagamento, id_mensalidade) VALUES
(1, 'Cartão de Crédito', 1200.00, '2024-02-10', 1),
(2, 'Boleto', 1100.50, '2024-03-15', 2),
(3, 'Pix', 1300.00, '2024-04-05', 3);

