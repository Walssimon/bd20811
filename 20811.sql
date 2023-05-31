DROP DATABASE RM20811;

CREATE DATABASE RM20811;

USE RM20811;

CREATE TABLE Clientes (
IDCliente INT NOT NULL PRIMARY KEY,
NomeCliente VARCHAR(100) NOT NULL,
CPFCliente VARCHAR(11) NOT NULL UNIQUE KEY,
EstadoCliente VARCHAR(100) NOT NULL
);

CREATE TABLE Pedidos (
CodigoPedido INT NOT NULL PRIMARY KEY,
DataPedido DATE NOT NULL,
IDCliente INT NOT NULL,

FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
);


CREATE TABLE Produtos (
IDProduto INT NOT NULL PRIMARY KEY,
NomeProduto VARCHAR(100) NOT NULL,
PrecoUnitario DECIMAL(8,2) NOT NULL
);

CREATE TABLE ItensPedidos (
CodigoPedido INT NOT NULL,
IDProduto INT NOT NULL,
QtdeVendida INT NOT NULL,

CONSTRAINT FK_CodigoPedido_Pedido FOREIGN KEY (CodigoPedido) REFERENCES Pedidos(CodigoPedido), 
CONSTRAINT FK_IDProduto_Produto FOREIGN KEY (IDProduto) REFERENCES Produtos(IDProduto) 
);

ALTER TABLE Clientes
ADD CONSTRAINT EstadoCliente CHECK(EstadoCliente = 'SAO PAULO' OR EstadoCliente = 'MINAS GERAIS' OR EstadoCliente = 'RIO DE JANEIRO' OR EstadoCliente ='ESPIRITO SANTO'); 

ALTER TABLE Pedidos
ALTER DataPedido SET DEFAULT CURRENT_DATE();


INSERT INTO Clientes
VALUES (1,'Sonic Ouriço','46581321684','RIO DE JANEIRO'),
(2,'Mario Mario','57468746123','MINAS GERAIS'),
(3,'Riu Das Ruas','84618106345','RIO DE JANEIRO'),
(4,'Villager Nook','16352162841','ESPIRITO SANTO'),
(5,'Steven Craft','65432231681','SAO PAULO');

INSERT INTO Produtos
VALUES (1,'Monitor',1803.80),
(2,'Teclado',500.32),
(3,'Mouse',160.32),
(4,'Caixa de Som',300.63),
(5,'Headset',263.50);

INSERT INTO Pedidos
VALUES (1,DEFAULT,1),
(2,DEFAULT,2),
(3,DEFAULT,3),
(4,DEFAULT,4),
(5,DEFAULT,5);

INSERT INTO ItensPedidos
VALUES (1, 1, 1),
(1,5,1),
(1,2,2),
(2,4,1),
(2,1,2),
(3,5,1),
(3,4,1),
(4,1,1),
(4,2,1),
(4,3,1),
(5,4,2),
(5,5,1);

SELECT
p.CodigoPedido, p.DataPedido, c.NomeCliente 
FROM clientes  c inner join Pedidos p on p.IDCliente = c.IDCliente;

SELECT
ip.CodigoPedido, p.NomeProduto, p.PrecoUnitario , ip.QtdeVendida,
ip.QtdeVendida * p.PrecoUnitario AS Subtotal
FROM ItensPedidos  ip inner join Produtos p on p.IDProduto = ip.IDProduto;

CREATE TEMPORARY TABLE tmp_nota(
CodigoPedido INT NOT NULL PRIMARY KEY,
DataPedido DATE NOT NULL,
NomeCliente VARCHAR(100) NOT NULL
);