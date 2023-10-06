
-- Criando as tabelas --------------------------------------------------------------------------------------------------

CREATE TABLE `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_fabrica`),
  INDEX `id_fabrica_idx` (`id_fabrica` ASC) VISIBLE,
);


ALTER TABLE `fabrica_garrafa_pet`.`empresa_de_garraf_pet` 
ADD COLUMN `data_fundacao` INT NOT NULL AFTER `id_fabrica`,
ADD COLUMN `lucro_total` INT NOT NULL AFTER `data_fundacao`,
ADD COLUMN `localizacao` VARCHAR(45) NULL AFTER `lucro_total`,
ADD COLUMN `capacidade_de_producao` INT NOT NULL AFTER `localizacao`,
ADD UNIQUE INDEX `data_fundacao_UNIQUE` (`data_fundacao` ASC) VISIBLE;
;


CREATE TABLE `fabrica_garrafa_pet`.`linha_de_producao` (
  `id_linha` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `capcidade` INT NOT NULL,
  `status` INT NOT NULL,
  `id_fabrica` INT NULL,
  PRIMARY KEY (`id_linha`),
  INDEX `id_fabrica_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `id_fabrica`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `fabrica_garrafa_pet`.`caracteristicas` (
  `id_caracteristicas` INT NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `formato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_caracteristicas`));


CREATE TABLE `fabrica_garrafa_pet`.`produto` (
  `id_produto` INT NOT NULL,
  `id_caracterisiticas` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `id_fabrica_idx` (`id_fabrica` ASC) VISIBLE,
  INDEX `id_caracteristicas_idx` (`id_caracterisiticas` ASC) VISIBLE,
  CONSTRAINT `id_fabrica`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_caracteristicas`
    FOREIGN KEY (`id_caracterisiticas`)
    REFERENCES `fabrica_garrafa_pet`.`caracteristicas` (`id_caracteristicas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `fabrica_garrafa_pet`.`produto` (
  `id_produto` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  `id_caracteristicas` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `id_fabrica_idx` (`id_fabrica` ASC) VISIBLE,
  INDEX `id_caracteristicas_idx` (`id_caracteristicas` ASC) VISIBLE,
  CONSTRAINT `fk_id_fabrica`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_caracteristicas`
    FOREIGN KEY (`id_caracteristicas`)
    REFERENCES `fabrica_garrafa_pet`.`caracteristicas` (`id_caracteristicas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    CREATE TABLE `fabrica_garrafa_pet`.`pedidos` (
  `id_pedidos` INT NOT NULL,
  `data` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `valor_total` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_pedidos`),
  INDEX `fk_id_produto_idx` (`id_produto` ASC) VISIBLE,
  INDEX `fk_id_fabrica_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_id_produto`
    FOREIGN KEY (`id_produto`)
    REFERENCES `fabrica_garrafa_pet`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_fabrica03`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `fabrica_garrafa_pet`.`cliente` (
  `id_cliente` INT NOT NULL,
  `nome_cliente` VARCHAR(45) NOT NULL,
  `endereco_destino` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cliente`));


CREATE TABLE `fabrica_garrafa_pet`.`funcionario` (
  `id_funcionario` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `salario` INT NOT NULL,
  `contrato` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  INDEX `fk_id_fabrica_04_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_id_fabrica_04`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `fabrica_garrafa_pet`.`fornecedor` (
  `id_fornecedor` INT NOT NULL,
  `nome_empresa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_fornecedor`));


  CREATE TABLE `fabrica_garrafa_pet`.`compra` (
  `id_compra` INT NOT NULL,
  `quantidade_compra` INT NOT NULL,
  `data_compra` DATE NOT NULL,
  `valor_compra` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_id_fabrica05_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_id_fabrica05`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `fabrica_garrafa_pet`.`materia_prima` (
  `id_materia` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `quantidade_atual` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_materia`),
  INDEX `fk_id_fornecedor_idx` (`id_fornecedor` ASC) VISIBLE,
  INDEX `fk_id_fabrica06_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_id_fornecedor`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `fabrica_garrafa_pet`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_fabrica06`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `fabrica_garrafa_pet`.`produz` (
  `id_produz` INT NOT NULL,
  `id_materia` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  `id_fabrica` INT NOT NULL,
  PRIMARY KEY (`id_produz`),
  INDEX `fk_id_fornecedor02_idx` (`id_fornecedor` ASC) VISIBLE,
  INDEX `fk_id_materia_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_id_fabrica_07_idx` (`id_fabrica` ASC) VISIBLE,
  CONSTRAINT `fk_id_fornecedor02`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `fabrica_garrafa_pet`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_materia`
    FOREIGN KEY (`id_materia`)
    REFERENCES `fabrica_garrafa_pet`.`materia_prima` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_fabrica_07`
    FOREIGN KEY (`id_fabrica`)
    REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Atualizando as tabelas com o que falta ----------------------------------------------------------------------------------
ALTER TABLE `fabrica_garrafa_pet`.`empresa_de_garraf_pet` 
CHANGE COLUMN `data_fundacao` `data_fundacao` DATE NOT NULL ,
CHANGE COLUMN `localizacao` `localizacao` VARCHAR(45) NOT NULL ;


ALTER TABLE `fabrica_garrafa_pet`.`linha_de_producao` 
DROP FOREIGN KEY `id_fabrica`;
ALTER TABLE `fabrica_garrafa_pet`.`linha_de_producao` 
CHANGE COLUMN `id_fabrica` `id_fabrica` INT NOT NULL ;
ALTER TABLE `fabrica_garrafa_pet`.`linha_de_producao` 
ADD CONSTRAINT `id_fabrica`
  FOREIGN KEY (`id_fabrica`)
  REFERENCES `fabrica_garrafa_pet`.`empresa_de_garraf_pet` (`id_fabrica`);


ALTER TABLE `fabrica_garrafa_pet`.`produto` 
ADD COLUMN `id_linha` INT NOT NULL AFTER `id_caracteristicas`,
ADD COLUMN `id_materia` INT NULL AFTER `id_linha`,
ADD INDEX `fk_id_linha_idx` (`id_linha` ASC) VISIBLE,
ADD INDEX `fk_id_materia02_idx` (`id_materia` ASC) VISIBLE;
;
ALTER TABLE `fabrica_garrafa_pet`.`produto` 
ADD CONSTRAINT `fk_id_linha`
  FOREIGN KEY (`id_linha`)
  REFERENCES `fabrica_garrafa_pet`.`linha_de_producao` (`id_linha`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_id_materia02`
  FOREIGN KEY (`id_materia`)
  REFERENCES `fabrica_garrafa_pet`.`materia_prima` (`id_materia`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


  ALTER TABLE `fabrica_garrafa_pet`.`pedidos` 
ADD COLUMN `id_cliente` INT NOT NULL AFTER `id_fabrica`,
ADD INDEX `fk_id_cliente_idx` (`id_cliente` ASC) VISIBLE;
;
ALTER TABLE `fabrica_garrafa_pet`.`pedidos` 
ADD CONSTRAINT `fk_id_cliente`
  FOREIGN KEY (`id_cliente`)
  REFERENCES `fabrica_garrafa_pet`.`cliente` (`id_cliente`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `fabrica_garrafa_pet`.`fornecedor` 
ADD COLUMN `id_compra` INT NOT NULL AFTER `nome_empresa`,
ADD INDEX `fk_id_compra_idx` (`id_compra` ASC) VISIBLE;
;
ALTER TABLE `fabrica_garrafa_pet`.`fornecedor` 
ADD CONSTRAINT `fk_id_compra`
  FOREIGN KEY (`id_compra`)
  REFERENCES `fabrica_garrafa_pet`.`compra` (`id_compra`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `fabrica_garrafa_pet`.`compra` 
ADD COLUMN `id_materia` INT NOT NULL AFTER `id_fabrica`,
ADD INDEX `fk_id_materia03_idx` (`id_materia` ASC) VISIBLE;
;
ALTER TABLE `fabrica_garrafa_pet`.`compra` 
ADD CONSTRAINT `fk_id_materia03`
  FOREIGN KEY (`id_materia`)
  REFERENCES `fabrica_garrafa_pet`.`materia_prima` (`id_materia`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `fabrica_garrafa_pet`.`produto` 
DROP FOREIGN KEY `fk_id_caracteristicas`,
DROP FOREIGN KEY `fk_id_materia02`;
ALTER TABLE `fabrica_garrafa_pet`.`produto` 
CHANGE COLUMN `id_materia` `id_materia` INT NOT NULL ;
ALTER TABLE `fabrica_garrafa_pet`.`produto` 
ADD CONSTRAINT `fk_id_caracteristicas0`
  FOREIGN KEY (`id_caracteristicas`)
  REFERENCES `fabrica_garrafa_pet`.`caracteristicas` (`id_caracteristicas`),
ADD CONSTRAINT `fk_id_materia02`
  FOREIGN KEY (`id_materia`)
  REFERENCES `fabrica_garrafa_pet`.`materia_prima` (`id_materia`);


ALTER TABLE `fabrica_garrafa_pet`.`fornecedor` 
DROP FOREIGN KEY `fk_id_compra`;
ALTER TABLE `fabrica_garrafa_pet`.`fornecedor` 
DROP INDEX `fk_id_compra_idx` ;
;
ALTER TABLE `fabrica_garrafa_pet`.`funcionario` 
DROP FOREIGN KEY `fk_id_fabrica_04`;
ALTER TABLE `fabrica_garrafa_pet`.`funcionario` 
DROP INDEX `fk_id_fabrica_04_idx` ;
;
ALTER TABLE `fabrica_garrafa_pet`.`linha_de_producao` 
DROP FOREIGN KEY `id_fabrica`;
ALTER TABLE `fabrica_garrafa_pet`.`linha_de_producao` 
DROP INDEX `id_fabrica_idx` ;
;
ALTER TABLE `fabrica_garrafa_pet`.`produto` 
DROP FOREIGN KEY `fk_id_materia02`,
DROP FOREIGN KEY `fk_id_linha`,
DROP FOREIGN KEY `fk_id_fabrica`,
DROP FOREIGN KEY `fk_id_caracteristicas0`;
ALTER TABLE `fabrica_garrafa_pet`.`produto` 
DROP INDEX `fk_id_caracteristicas0_idx` ,
DROP INDEX `fk_id_materia02_idx` ,
DROP INDEX `fk_id_linha_idx` ,
DROP INDEX `id_fabrica_idx` ;
;


ALTER TABLE `fabrica_garrafa_pet`.`compra` 
DROP FOREIGN KEY `fk_id_materia03`,
DROP FOREIGN KEY `fk_id_fabrica05`;
ALTER TABLE `fabrica_garrafa_pet`.`compra` 
DROP INDEX `fk_id_materia03_idx` ,
DROP INDEX `fk_id_fabrica05_idx` ;
;
ALTER TABLE `fabrica_garrafa_pet`.`materia_prima` 
DROP FOREIGN KEY `fk_id_fornecedor`,
DROP FOREIGN KEY `fk_id_fabrica06`;
ALTER TABLE `fabrica_garrafa_pet`.`materia_prima` 
DROP INDEX `fk_id_fabrica06_idx` ,
DROP INDEX `fk_id_fornecedor_idx` ;
;

ALTER TABLE `fabrica_garrafa_pet`.`pedidos` 
DROP FOREIGN KEY `fk_id_produto`,
DROP FOREIGN KEY `fk_id_fabrica03`,
DROP FOREIGN KEY `fk_id_cliente`;
ALTER TABLE `fabrica_garrafa_pet`.`pedidos` 
DROP INDEX `fk_id_cliente_idx` ,
DROP INDEX `fk_id_fabrica_idx` ,
DROP INDEX `fk_id_produto_idx` ;
;
ALTER TABLE `fabrica_garrafa_pet`.`produz` 
DROP FOREIGN KEY `fk_id_materia`,
DROP FOREIGN KEY `fk_id_fornecedor02`,
DROP FOREIGN KEY `fk_id_fabrica_07`;
ALTER TABLE `fabrica_garrafa_pet`.`produz` 
DROP INDEX `fk_id_fabrica_07_idx` ,
DROP INDEX `fk_id_materia_idx` ,
DROP INDEX `fk_id_fornecedor02_idx` ;
;

-- Inserindo dados ------------------------------------------------------------------------------------------

INSERT empresa_de_garraf_pet (id_fabrica, data_fundacao, lucro_total, localizacao, capacidade_de_producao)
VALUES (01,'2002-07-26', 20000000,"rua augusto novaes prado", 30000);


INSERT linha_de_producao (id_linha, tipo, capcidade, status, id_fabrica)
VALUES (01,'separa pigmento', 3000,0, 1),
(02,'mistura pigmento', 3000,1, 1),
(03,'gera garrafa tam 1', 3000,1, 1),
(04,'gera garrafa tam 2', 3000,1, 1),
(05,'gera garrafa tam 3', 3000,0, 1),
(06,'selecao garrafas 1', 3000,0, 1),
(07,'selecao garrafas 2', 3000,1, 1),
(08,'selecao garrafas 3', 3000,0, 1);


INSERT produto (id_produto,id_fabrica,id_caracteristicas,id_linha,id_materia)
VALUES (01,01,04,05,01),
(02,01,01,01,01),
(03,01,03,04,02),
(04,01,02,04,02),
(05,01,01,01,03),
(06,01,04,07,04),
(07,01,02,08,04),
(08,01,02,05,03);

INSERT caracteristicas(id_caracteristicas,cor,formato)
VALUES(01,'AZUL', 'PRIMEIRO')
(02,'ROSA', 'DECIMO'),
(03,'TRANSPARENTE', 'SEGUNDO'),
(04,'AZUL', 'PRIMEIRO'),
(05,'VERMELHO', 'SETIMO'),
(06,'AZUL', 'PRIMEIRO'),
(07,'TRANSPARENTE', 'QUARTO'),
(08,'AZUL', 'SEGUNDO');


INSERT pedidos(id_pedidos, data, quantidade, id_produto, valor_total, id_fabrica, id_cliente)
VALUES (01, '2023-07-14',220, 01, 2200, 01, 01),
(02, '2023-07-14',220, 05, 2200, 01, 01),
(03, '2023-07-15',220, 01, 2200, 01, 01),
(04, '2023-07-14',220, 06, 2200, 01, 01),
(05, '2023-07-14',220, 07, 2200, 01, 02),
(06, '2023-07-15',220, 02, 2200, 01, 02),
(07, '2023-07-14',220, 08, 2200, 01, 02),
(08, '2023-07-16',220, 01, 2200, 01, 02);


INSERT cliente(id_cliente, nome_cliente, endereco_destino)
VALUES(01, 'ANDERSON','CASA NA RUA AMARELA'),
(02, 'LUANA','CASA NA RUA ROSA'),
(03, 'CARLOS','CASA NA RUA VERMELHA'),
(04, 'ICARO','CASA NA RUA VERDE');

INSERT funcionario(id_funcionario, nome, cargo, salario, contrato, id_fabrica)
VALUES  (01, 'ANDERSON', 'GERENTE',12000,01,01),
(02, 'LUANA', 'OPERADOR DE MAQUINA',5000,02,01),
(03, 'CARLOS', 'LIMPEZA',3000,03,01),
(04, 'JOSE', 'EMABLADOR',3000,04,01);

INSERT fornecedor(id_fornecedor,nome_empresa,id_compra)
VALUES (01,'PIGMENTODS LTDA', 01),
(02,'FIBRA LTDA', 02),
(03,'RESINA LTDA', 03),
(04,'PLASTIC LTDA', 04),
(05,'AGUA LTDA', 05);

INSERT compra(id_compra,quantidade_compra,data_compra,valor_compra,id_fabrica,id_materia)
VALUES (01,200,'2023-07-14',2000,01,02),
(02,200,'2023-07-16',2000,01,01),
(03,200,'2023-07-18',2000,01,03),
(04,200,'2023-07-13',2000,01,04),
(05,200,'2023-07-11',2000,01,06);

INSERT materia_prima(id_materia, nome, id_fornecedor, quantidade_atual, id_fabrica)
VALUES (01, 'PLASTICO 01', 01, 2000, 01),
(02, 'PLASTICO 02', 03, 2000, 01),
(03, 'PLASTICO 03', 01, 2000, 01),
(04, 'PLASTICO 04', 02, 2000, 01),
(05, 'PLASTICO 05', 04, 2000, 01);


INSERT produz(id_produz, id_materia, id_fornecedor, id_fabrica)
VALUES (01, 02, 01, 01),
(02, 04, 03, 01),
(03, 03, 01, 01),
(04, 01, 04, 01),
(05, 05, 02, 01);

