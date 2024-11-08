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
