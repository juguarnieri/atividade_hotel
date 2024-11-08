/*Criação banco de dados:*/

CREATE DATABASE hoteldb;
\c hoteldb;
Criação das tabelas
CREATE TABLE hospedes (
    id_hospede SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    email VARCHAR(100)
);
