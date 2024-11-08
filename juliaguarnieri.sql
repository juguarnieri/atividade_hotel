/*Criação banco de dados:*/

CREATE DATABASE hoteldb;
\c hoteldb;

/*Criação das tabelas*/

CREATE TABLE hospedes (
    id_hospede SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero_quarto INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    preco_diaria DECIMAL(10,2)
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    CONSTRAINT fk_hospede FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    CONSTRAINT fk_quarto FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto),
    CONSTRAINT check_data_fim CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

/*Inserção de dados na tabela hospedes:*/

INSERT INTO hospedes (nome, email) VALUES
('Julia Guarnieri', 'juliaguarnieri@gmail.com'),
('Caio Lacerda', 'caio@gmail.com'),
('Luiza Nicolutti', 'luluni@gmail.com'),
('Bernardo Moraes', 'ber123@gmail.com'),
('Larissa Silva', 'larisi@gmail.com'),
('Luciana Andrade', 'luandra@gmail.com'),
('Marco Aurélio', 'marco@gmail.com'),
('Ricardo Alvez', 'ricalvez@gmail.com'),
('Miguel Rodrigues', 'miguelrodrigues@gmail.com'),
('Lorenzo Rodrigues', 'rodrilore@gmail.com'); 

/*Inserção de dados na tabela quartos:*/

INSERT INTO quartos (numero_quarto, tipo, preco_diaria) VALUES
(15, 'Solteiro', 100.00),
(16, 'Casal', 150.00),
(17, 'Família', 270.00),
(18, 'Solteiro', 120.00),
(19, 'Família', 220.00),
(20, 'Solteiro', 180.00),
(21, 'Casal', 350.00),
(22, 'Família', 470.00),
(23, 'Solteiro', 220.00),
(24, 'Família', 230.00),
(25, 'Solteiro', 300.00), 
(26, 'Solteiro', 150.00);

/*Inserção de dados na tabela reservas:*/

INSERT INTO reservas (id_hospede, id_quarto, data_inicio, data_fim) VALUES
(1, 1, '2023-02-03', '2023-02-10'),
(2, 2, '2023-03-01', '2023-03-18'),
(3, 8, '2023-06-13', '2023-06-15'),
(4, 9, '2023-08-10', '2023-08-16'),
(5, 3, '2024-10-01', '2024-12-01'),
(6, 4, '2024-11-01', NULL),
(7, 5, '2024-11-05', '2024-11-25'),
(8, 6, '2024-11-10', NULL),
(9, 7, '2024-11-12', NULL),
(10, 10, '2024-11-15', '2024-11-22');

/*1. Consulta para listar hóspedes com estadias finalizadas*/

SELECT 
    h.nome AS hospede,
    q.numero_quarto AS quarto,
    r.data_inicio,
    r.data_fim
FROM 
    hospedes h
INNER JOIN 
    reservas r ON h.id_hospede = r.id_hospede
INNER JOIN 
    quartos q ON r.id_quarto = q.id_quarto
WHERE 
    r.data_fim < CURRENT_DATE;

/* 2. Consulta para listar todos os hóspedes, incluindo aqueles com reservas ativas e os que não possuem reserva */

SELECT 
    h.nome AS hospede,
    q.numero_quarto AS quarto,
    r.data_inicio,
    r.data_fim,
    CASE 
        WHEN r.data_fim < CURRENT_DATE THEN 'Finalizada'
        WHEN r.data_inicio <= CURRENT_DATE AND (r.data_fim >= CURRENT_DATE OR r.data_fim IS NULL) THEN 'Hospedado'
        ELSE 'Sem reserva'
    END AS status_estadia
FROM 
    hospedes h
LEFT JOIN 
    reservas r ON h.id_hospede = r.id_hospede
LEFT JOIN 
    quartos q ON r.id_quarto = q.id_quarto;

    

