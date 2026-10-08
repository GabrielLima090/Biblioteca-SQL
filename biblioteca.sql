CREATE TABLE leitores (
ID SERIAL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
telefone VARCHAR(20) UNIQUE NOT NULL,
data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias(
ID SERIAL PRIMARY KEY,
nome VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE livros (
    id SERIAL PRIMARY KEY,
    categoria_id INT REFERENCES categorias(id),
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    taxa_diaria DECIMAL(10,2) CHECK (taxa_diaria > 0) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

CREATE TABLE emprestimos (
ID SERIAL PRIMARY KEY,
leitor_id INT REFERENCES leitores(id),
data_emprestimo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status TEXT DEFAULT 'Ativo' CHECK (status IN ('Ativo', 'Devolvido','Atrasado'))
);

CREATE TABLE itens_emprestimos(
ID SERIAL PRIMARY KEY,
emprestimo_id INT REFERENCES emprestimos(id),
livro_id INT REFERENCES livros(id),
quantidade INT CHECK (quantidade > 0) NOT NULL,
valor_diaria DECIMAL(10,2) CHECK (valor_diaria >= 0) NOT NULL
);


CREATE VIEW vw_acervo_ordenado AS
SELECT
l.titulo,
l.isbn,
c.nome,
l.taxa_diaria
FROM livros l
JOIN categorias c ON l.categoria_id = c.ID
