CRAETE DATABSE telos

SELECT * FROM sys.databases

USE telos

CREATE TABLE books(
	book_id INT PRIMARY KEY IDENTITY(1,1),
	title VARCHAR(255) NOT NULL,
	author VARCHAR(255) NOT NULL,
	genre VARCHAR(255) NOT NULL,
	published_year INT 
);

ALTER TABLE books ALTER COLUMN published_year INT NOT NULL;

SELECT * FROM books

/* Bando de dados de livros iniciais já existentes */
INSERT INTO books (title, author, genre, published_year) 
VALUES
('Dom Casmurro', 'Machado de Assis', 'Clássico', 1899),
('O Hobbit', 'J.R.R. Tolkien', 'Fantasia', 1937),
('1984', 'George Orwell', 'Distopia', 1949),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Infantil', 1943),
('Cem Anos de Solidão', 'Gabriel García Márquez', 'Realismo Mágico', 1967),
('A Hora da Estrela', 'Clarice Lispector', 'Clássico', 1977),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Fantasia', 1997),
('O Código Da Vinci', 'Dan Brown', 'Suspense', 2003),
('O Alquimista', 'Paulo Coelho', 'Ficção', 1988),
('Ensaio sobre a Cegueira', 'José Saramago', 'Ficção', 1995);

/* Livros adcionados ao banco de dados */
INSERT INTO books (title, author, genre, published_year) 
VALUES 
('O Processo', 'Franz Kafka', 'Ficção', 1925),
('A Revolução dos Bichos', 'George Orwell', 'Sátira', 1945),
('O Silmarillion', 'J.R.R. Tolkien', 'Fantasia', 1977),
('Admirável Mundo Novo', 'Aldous Huxley', 'Distopia', 1932),
('Grande Sertão: Veredas', 'Guimarães Rosa', 'Regionalismo', 1956),
('Fahrenheit 451', 'Ray Bradbury', 'Ficção Científica', 1953),
('Crime e Castigo', 'Fiódor Dostoiévski', 'Realismo', 1866),
('O Nome da Rosa', 'Umberto Eco', 'Mistério', 1980),
('A Metamorfose', 'Franz Kafka', 'Ficção', 1915),
('Vidas Secas', 'Graciliano Ramos', 'Regionalismo', 1938); /* Livro irá ser apagado para ser acrescentado com o valor errado para que modificações sejam feitas*/

/* Apagando dados do id 20 (Vidas Secas) para acrescentar com ano de publicação errado*/
DELETE FROM Books WHERE book_id = 20;

/* Inserindo livro com ano de publicação errado para o banco de dados */
INSERT INTO books (title, author, genre, published_year) 
VALUES ('Vidas Secas', 'Graciliano Ramos', 'Regionalismo', 1935);

/* Atualizando informação de livro existente com erro no ano de publicação */
UPDATE books SET published_year = 1938 where book_id = 21;

/* Excluindo livro do catálogo */
DELETE FROM Books WHERE book_id = 10;

/* Buscando livros no catálogo por title, author, genre e published_year */
SELECT * FROM Books WHERE title = 'O Processo';
SELECT * FROM Books WHERE genre = 'Ficção';
SELECT * FROM Books WHERE author = 'J.R.R. Tolkien';
SELECT * FROM Books WHERE  published_year = 1932;

CREATE TABLE users(
	user_id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL
);

SELECT * FROM users

/* Bando de dados de users iniciais já existentes */
INSERT INTO users (name, email)
VALUES 
('Bruno Oliveira', 'bruno.o@email.com'),
('Carla Souza', 'carla.souza@email.com'),
('Diego Santos', 'diego.santos@email.com'),
('Elena Pereira', 'elena.p@email.com'),
('Fabio Lima', 'fabio.lima@email.com'),
('Gisele Costa', 'gisele.c@email.com'),
('Henrique Rocha', 'h.rocha@email.com'),
('Isabela Martins', 'isabela.m@email.com'),
('João Ferreira', 'joao.f@email.com');

/* Users adicionados ao banco de dados */
INSERT INTO users (name, email) 
VALUES 
('Lucas Mendes', 'lucas.mendes@provedor.com'),
('Mariana Lima', 'mari.lima@servidor.net'),
('Ricardo Alves', 'ricardo.alves@webmail.com'),
('Beatrizz Ramos', 'beatriz.ramos@empresa.org'); /* Nome Beatriz escrito com duas letras Z precisando de correção */

/* Atualizando informação de nome existente com erro de digitação */
UPDATE users SET name = 'Beatriz Ramos' WHERE user_id = 13;

/* Excluindo user da tabela */
DELETE FROM users WHERE user_id = 2;

/* Buscando users na tabela por name e email */
SELECT * FROM users WHERE name = 'Bruno Oliveira';
SELECT * FROM users WHERE email = 'joao.f@email.com';


CREATE TABLE loans(
	loan_id INT PRIMARY KEY IDENTITY(1,1),
	book_id INT NOT NULL,
	user_id INT NOT NULL,
	loan_date DATE NOT NULL,
	return_date DATE NULL,
	
	FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

SELECT * FROM loans

/* Registro de empréstimo de livros para o user_id 1 */
INSERT INTO Loans (book_id, user_id, loan_date, return_date)
VALUES (1, 1, '2026-01-12', NULL);
INSERT INTO Loans (book_id, user_id, loan_date, return_date)
VALUES (2, 1, '2026-01-12', NULL);
INSERT INTO Loans (book_id, user_id, loan_date, return_date)
VALUES (3, 1, '2026-01-12', NULL);

/* Registro de empréstimo de livros para o user_id 13 */
INSERT INTO Loans (book_id, user_id, loan_date, return_date)
VALUES (21, 13, '2026-01-12', NULL);

/* Registro de empréstimo de livros para o user_id 11 */
INSERT INTO Loans (book_id, user_id, loan_date, return_date)
VALUES (11, 13, '2026-01-12', NULL);

/* Registro de devolução de livros para o user_id 11 */
UPDATE Loans SET return_date = '2026-01-13' WHERE loan_id = 5;

/* Verificação de disponibilidade de livros*/
SELECT * FROM Loans WHERE book_id = 3 AND return_date IS NULL; /* Neste caso, o livro foi emprestado, mas não se tem data do seu retorno */
SELECT * FROM Loans WHERE book_id = 4 AND return_date IS NULL; /* Neste caso, o livro está disponivel, pois não há data de empréstimo */
SELECT * FROM Loans WHERE book_id = 11 /* Neste caso, verificamos a disponibilidade de um livro específico para ver sua saída e seu retorno */

/* Relatório de livros emprestados e devolvidos. */
SELECT 
    B.title AS 'Livro', 
    U.name AS 'Usuário', 
    L.loan_date AS 'Data de Empréstimo',
    L.return_date AS 'Data de Devolução'
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
JOIN Users U ON L.user_id = U.user_id;

/* Gerar relatórios de livros atualmente emprestados. */
SELECT 
    B.title AS 'Livro', 
    U.name AS 'Usuário', 
    L.loan_date AS 'Data de Saída',
    L.return_date As 'Data de retorno'
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
JOIN Users U ON L.user_id = U.user_id
WHERE L.return_date IS NULL;

/* Como encontrar usuários com mais de 2 empréstimos (ou mais, modificando o número) */
SELECT Users.name
FROM Users
WHERE (SELECT COUNT(*) FROM Loans WHERE Loans.user_id =
Users.user_id) > 2;

/* Function para calcular o número total de empréstimos por usuário */
CREATE FUNCTION TotalLoans (@user_id INT)
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) FROM Loans WHERE user_id = @user_id);
END;

/* Gerar relatórios de usuários com quantidade de empréstimos */
SELECT 
    name AS Nome_Usuario, 
    email AS Email, 
    dbo.TotalLoans(user_id) AS Qtd_Emprestimos
FROM Users;

/* Gerar relatórios de usuário especifico com quantidade de empréstimos  */
SELECT 
    name AS Nome_Usuario, 
    email AS Email, 
    dbo.TotalLoans(user_id) AS TotalDeEmprestimos
FROM Users
WHERE user_id = 1;

/* Gerar relatórios de usuários com mais empréstimos */
SELECT Users.name
FROM Users
WHERE (
    SELECT COUNT(*) 
    FROM Loans 
    WHERE Loans.user_id = Users.user_id
) > 2;