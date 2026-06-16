-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clientes_pedidos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema clientes_pedidos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clientes_pedidos` DEFAULT CHARACTER SET utf8 ;
USE `clientes_pedidos` ;

-- -----------------------------------------------------
-- Table `clientes_pedidos`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes_pedidos`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clientes_pedidos`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes_pedidos`.`pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedidos_clientes_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `clientes_pedidos`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use clientes_pedidos;
show tables;

select * from clientes;

-- Ingresar clientes
insert into clientes(nombre, direccion, telefono)
values
	('Alonso Sanchez', 'Av Libertad 123', '987654321'),
	('Andres Castillo', 'Los Robles 456', '912345678'),
    ('Margoth Aguilar', 'Las Flores 789', '923456789'),
    ('Ana Torres', 'San Martin 321', '934567890'),
    ('Pedro Rojas', 'Copiapo 654', '945678901');
    
select * from clientes;

-- Ingresar pedidos
insert into pedidos (id_cliente, fecha, total)
values
(1,'2026-06-01',15000),
(1,'2026-06-05',22000),

(2,'2026-06-02',18000),
(2,'2026-06-10',12000),

(3,'2026-06-03',30000),
(3,'2026-06-08',25000),

(4,'2026-06-04',17000),

(5,'2026-06-06',45000),
(5,'2026-06-09',11000),
(5,'2026-06-12',20000);

select * from pedidos;

select * from clientes;

-- Clientes y sus pedidos
select
    c.id_cliente,
    c.nombre,
    p.id_pedido,
    p.fecha,
    p.total
from clientes c
inner join pedidos p
on c.id_cliente = p.id_cliente;

-- Pedidos de un cliente especifico
select * from pedidos where id_cliente = 4;

select * from pedidos where id_cliente = 2;

select * from pedidos where id_cliente = 5;


-- Total gastado por cada cliente
select
    c.id_cliente,
    c.nombre,
    sum(p.total) AS total_compras
from clientes c
inner join pedidos p
on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nombre;


-- Eliminar cliente y sus pedidos 
delete from pedidos where id_cliente = 2;

delete from clientes where id_cliente = 2;

select * from clientes;

select * from pedidos;


-- Tres clientes con más pedidos
select
    c.id_cliente,
    c.nombre,
    count(p.id_pedido) as cantidad_pedidos
from clientes c
inner join pedidos p
on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nombre
order by cantidad_pedidos desc
limit 3;

select * from clientes;
