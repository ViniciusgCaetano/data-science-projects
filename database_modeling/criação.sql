-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema agencia_financiamento
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `agencia_financiamento` ;

-- -----------------------------------------------------
-- Schema agencia_financiamento
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agencia_financiamento` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
SHOW WARNINGS;
USE `agencia_financiamento` ;

-- -----------------------------------------------------
-- Table `area_pesquisa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `area_pesquisa` (
  `idAreap` INT NOT NULL,
  `nomAreap` VARCHAR(45) NULL,
  `dscAreap` TEXT NULL,
  `indRelevAreap` INT NULL,
  PRIMARY KEY (`idAreap`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `UF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UF` (
  `idUF` INT NOT NULL,
  `dscUF` VARCHAR(45) NULL,
  PRIMARY KEY (`idUF`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidade` (
  `idCidde` INT NOT NULL,
  `dscCidde` VARCHAR(45) NULL,
  `idUF` INT NOT NULL,
  PRIMARY KEY (`idCidde`),
  INDEX `fk_cidade_UF1_idx` (`idUF` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_UF1`
    FOREIGN KEY (`idUF`)
    REFERENCES `UF` (`idUF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bairro` (
  `idBairro` INT NOT NULL,
  `dscBairro` VARCHAR(45) NULL,
  `idCidde` INT NOT NULL,
  PRIMARY KEY (`idBairro`),
  INDEX `fk_bairro_cidade1_idx` (`idCidde` ASC) VISIBLE,
  CONSTRAINT `fk_bairro_cidade1`
    FOREIGN KEY (`idCidde`)
    REFERENCES `cidade` (`idCidde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `logradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logradouro` (
  `idLogr` INT NOT NULL,
  `dscLogr` VARCHAR(200) NULL,
  `idBairro` INT NOT NULL,
  `numCepLogr` VARCHAR(11) NULL,
  `dscTipoLogr` VARCHAR(45) NULL,
  PRIMARY KEY (`idLogr`),
  INDEX `fk_logradouro_bairro1_idx` (`idBairro` ASC) VISIBLE,
  CONSTRAINT `fk_logradouro_bairro1`
    FOREIGN KEY (`idBairro`)
    REFERENCES `bairro` (`idBairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `instituição`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instituição` (
  `idInsto` INT NOT NULL,
  `numCnpjInsto` VARCHAR(20) NULL,
  `dscNfantInsto` VARCHAR(45) NULL,
  `nomRazaoInsto` TEXT(10) NULL,
  `dscEmailInsto` VARCHAR(45) NULL,
  `nomNcontInsto` VARCHAR(45) NULL,
  `numFoneInsto` VARCHAR(15) NULL,
  `dscComplInsto` VARCHAR(45) NULL,
  `idLogr` INT NOT NULL,
  `numLogrInsto` INT NULL,
  PRIMARY KEY (`idInsto`),
  INDEX `fk_insituição_logradouro1_idx` (`idLogr` ASC) VISIBLE,
  CONSTRAINT `fk_insituição_logradouro1`
    FOREIGN KEY (`idLogr`)
    REFERENCES `logradouro` (`idLogr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto` (
  `idProj` INT NOT NULL,
  `dscProj` TEXT NULL,
  `datInicioProj` DATE NULL,
  `datFimProj` DATE NULL,
  `idAreap` INT NOT NULL,
  `idInsto` INT NOT NULL,
  PRIMARY KEY (`idProj`),
  INDEX `fk_projeto_area_pesquisa_idx` (`idAreap` ASC) VISIBLE,
  INDEX `fk_projeto_insituição1_idx` (`idInsto` ASC) VISIBLE,
  CONSTRAINT `fk_projeto_area_pesquisa`
    FOREIGN KEY (`idAreap`)
    REFERENCES `area_pesquisa` (`idAreap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projeto_insituição1`
    FOREIGN KEY (`idInsto`)
    REFERENCES `instituição` (`idInsto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pesquisador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesquisador` (
  `idPsqdr` INT NOT NULL,
  `numCpfPsqdr` VARCHAR(14) NULL,
  `nomPsqdr` VARCHAR(45) NULL,
  `indSexPsqdr` CHAR NULL,
  `datNascPsqdr` DATE NULL,
  `indGrauPsqdr` INT NULL,
  `idInsto` INT NOT NULL,
  `dscComplPesq` VARCHAR(45) NULL,
  `idLogr` INT NOT NULL,
  `numLogrPsqdr` INT NULL,
  `numRGPsqdr` VARCHAR(15) NULL,
  PRIMARY KEY (`idPsqdr`),
  INDEX `fk_pesquisador_insituição1_idx` (`idInsto` ASC) VISIBLE,
  INDEX `fk_pesquisador_logradouro1_idx` (`idLogr` ASC) VISIBLE,
  CONSTRAINT `fk_pesquisador_insituição1`
    FOREIGN KEY (`idInsto`)
    REFERENCES `instituição` (`idInsto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pesquisador_logradouro1`
    FOREIGN KEY (`idLogr`)
    REFERENCES `logradouro` (`idLogr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `assessor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assessor` (
  `idAsses` INT NOT NULL,
  `numRgAsses` VARCHAR(15) NULL,
  `numCpfAsses` VARCHAR(15) NULL,
  `nomAsses` VARCHAR(45) NULL,
  `IndSexoAsses` CHAR NULL,
  `datNascAsses` DATE NULL,
  `idcGrauAsses` INT NULL,
  `idInsto` INT NOT NULL,
  `dscComplAsses` VARCHAR(45) NULL,
  `idLogr` INT NOT NULL,
  `numLogrAsses` VARCHAR(45) NULL,
  INDEX `fk_asessor_insituição1_idx` (`idInsto` ASC) VISIBLE,
  PRIMARY KEY (`idAsses`),
  INDEX `fk_assessor_logradouro1_idx` (`idLogr` ASC) VISIBLE,
  CONSTRAINT `fk_asessor_insituição1`
    FOREIGN KEY (`idInsto`)
    REFERENCES `instituição` (`idInsto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessor_logradouro1`
    FOREIGN KEY (`idLogr`)
    REFERENCES `logradouro` (`idLogr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `pesquisador_projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesquisador_projeto` (
  `idPsqdr` INT NOT NULL,
  `idProj` INT NOT NULL,
  `idPsqpr` INT NOT NULL,
  PRIMARY KEY (`idPsqpr`),
  INDEX `fk_pesquisador_projeto_pesquisador1_idx` (`idPsqdr` ASC) VISIBLE,
  INDEX `fk_pesquisador_projeto_projeto1_idx` (`idProj` ASC) VISIBLE,
  CONSTRAINT `fk_pesquisador_projeto_pesquisador1`
    FOREIGN KEY (`idPsqdr`)
    REFERENCES `pesquisador` (`idPsqdr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pesquisador_projeto_projeto1`
    FOREIGN KEY (`idProj`)
    REFERENCES `projeto` (`idProj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `assessor_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assessor_area` (
  `idAssar` INT NOT NULL,
  `idAreap` INT NOT NULL,
  `idAsses` INT NOT NULL,
  PRIMARY KEY (`idAssar`),
  INDEX `fk_assessor_area_area_pesquisa1_idx` (`idAreap` ASC) VISIBLE,
  INDEX `fk_assessor_area_assessor1_idx` (`idAsses` ASC) VISIBLE,
  CONSTRAINT `fk_assessor_area_area_pesquisa1`
    FOREIGN KEY (`idAreap`)
    REFERENCES `area_pesquisa` (`idAreap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessor_area_assessor1`
    FOREIGN KEY (`idAsses`)
    REFERENCES `assessor` (`idAsses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `result_avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `result_avaliacao` (
  `idRsult` INT NOT NULL,
  `datEnvioRsult` DATE NULL,
  `datRespRsult` DATE NULL,
  `indRespRsult` VARCHAR(1) NULL,
  `dscJustRsult` TEXT(100) NULL,
  `idAsses` INT NOT NULL,
  `idProj` INT NOT NULL,
  PRIMARY KEY (`idRsult`),
  INDEX `fk_result_avaliacao_assessor1_idx` (`idAsses` ASC) VISIBLE,
  INDEX `fk_result_avaliacao_projeto1_idx` (`idProj` ASC) VISIBLE,
  CONSTRAINT `fk_result_avaliacao_assessor1`
    FOREIGN KEY (`idAsses`)
    REFERENCES `assessor` (`idAsses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_result_avaliacao_projeto1`
    FOREIGN KEY (`idProj`)
    REFERENCES `projeto` (`idProj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


insert into UF (idUF, dscUF) values (32, 'Espírito Santo');
insert into UF (idUF, dscUF) values (35, 'São Paulo');
insert into UF (idUF, dscUF) values (22, 'Piauí');
insert into UF (idUF, dscUF) values (28, 'Sergipe');
insert into UF (idUF, dscUF) values (16, 'Amapá');

insert into cidade (idCidde, dscCidde, idUf) values (1600105, 'Amapá', 16);
insert into cidade (idCidde, dscCidde, idUf) values (1600204, 'Calçoene', 16);
insert into cidade (idCidde, dscCidde, idUf) values (1600212, 'Cutias', 16);
insert into cidade (idCidde, dscCidde, idUf) values (1600238, 'Ferreira Gomes', 16);
insert into cidade (idCidde, dscCidde, idUf) values (1600253, 'Itaubal', 16);
insert into cidade (idCidde, dscCidde, idUf) values (2200053, 'Acauã', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2200103, 'Agricolândia', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2200202, 'Água Branca', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2200251, 'Alagoinha do Piauí', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2200277, 'Alegrete do Piauí', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2200301, 'Alto Longá', 22);
insert into cidade (idCidde, dscCidde, idUf) values (2800209, 'Aquidabã', 28);
insert into cidade (idCidde, dscCidde, idUf) values (2800308, 'Aracaju', 28);
insert into cidade (idCidde, dscCidde, idUf) values (2800407, 'Arauá', 28);
insert into cidade (idCidde, dscCidde, idUf) values (2800506, 'Areia Branca', 28);
insert into cidade (idCidde, dscCidde, idUf) values (2800605, 'Barra dos Coqueiros', 28);
insert into cidade (idCidde, dscCidde, idUf) values (3201209, 'Cachoeiro de Itapemirim', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3201308, 'Cariacica', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3201407, 'Castelo', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3201506, 'Colatina', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3201605, 'Conceição da Barra', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3201704, 'Conceição do Castelo', 32);
insert into cidade (idCidde, dscCidde, idUf) values (3541505, 'Presidente Venceslau', 35);
insert into cidade (idCidde, dscCidde, idUf) values (3541604, 'Promissão', 35);
insert into cidade (idCidde, dscCidde, idUf) values (3541653, 'Quadra', 35);
insert into cidade (idCidde, dscCidde, idUf) values (3541703, 'Quatá', 35);
insert into cidade (idCidde, dscCidde, idUf) values (3541802, 'Queiroz', 35);
insert into cidade (idCidde, dscCidde, idUf) values (3541901, 'Queluz', 35);


insert into bairro (idBairro, dscBairro, idCidde) values ('1', 'Alcinópolis', '2800506');
insert into bairro (idBairro, dscBairro, idCidde) values ('2', 'Estrela Velha', '3201209');
insert into bairro (idBairro, dscBairro, idCidde) values ('3', 'Santo Antônio do Içá', '3201407');
insert into bairro (idBairro, dscBairro, idCidde) values ('4', 'Lagoa Seca', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('5', 'Nova Glória', '3201704');
insert into bairro (idBairro, dscBairro, idCidde) values ('6', 'Franciscópolis', '2200103');
insert into bairro (idBairro, dscBairro, idCidde) values ('7', 'São Brás', '2200251');
insert into bairro (idBairro, dscBairro, idCidde) values ('8', 'São João da Ponta', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('9', 'Santa Luzia do Norte', '1600204');
insert into bairro (idBairro, dscBairro, idCidde) values ('10', 'Congonhas', '3201209');
insert into bairro (idBairro, dscBairro, idCidde) values ('11', 'Castanheiras', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('12', 'Porto de Pedras', '2200277');
insert into bairro (idBairro, dscBairro, idCidde) values ('13', 'Macururé', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('14', 'Mulungu', '3201407');
insert into bairro (idBairro, dscBairro, idCidde) values ('15', 'Ibiaí', '3201407');
insert into bairro (idBairro, dscBairro, idCidde) values ('16', 'Portão', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('17', 'Antônio Carlos', '2200202');
insert into bairro (idBairro, dscBairro, idCidde) values ('18', 'Ubaí', '1600105');
insert into bairro (idBairro, dscBairro, idCidde) values ('19', 'Miracema', '3541703');
insert into bairro (idBairro, dscBairro, idCidde) values ('20', 'Maripá', '1600204');
insert into bairro (idBairro, dscBairro, idCidde) values ('21', 'Pitangui', '1600238');
insert into bairro (idBairro, dscBairro, idCidde) values ('22', 'Oscar Bressane', '3541703');
insert into bairro (idBairro, dscBairro, idCidde) values ('23', 'Nilópolis', '3201308');
insert into bairro (idBairro, dscBairro, idCidde) values ('24', 'Acaraú', '3201605');
insert into bairro (idBairro, dscBairro, idCidde) values ('25', 'Paraíso', '3201704');
insert into bairro (idBairro, dscBairro, idCidde) values ('26', 'Porto Estrela', '2800407');
insert into bairro (idBairro, dscBairro, idCidde) values ('27', 'Eldorado do Sul', '3541604');
insert into bairro (idBairro, dscBairro, idCidde) values ('28', 'Lajedão', '2200301');
insert into bairro (idBairro, dscBairro, idCidde) values ('29', 'Iacanga', '1600204');
insert into bairro (idBairro, dscBairro, idCidde) values ('30', 'Passa Quatro', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('31', 'Nazário', '2200251');
insert into bairro (idBairro, dscBairro, idCidde) values ('32', 'Aparecida de Goiânia', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('33', 'Serra Dourada', '3541505');
insert into bairro (idBairro, dscBairro, idCidde) values ('34', 'Ipueiras', '2800308');
insert into bairro (idBairro, dscBairro, idCidde) values ('35', 'Riachão das Neves', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('36', 'Soure', '3541604');
insert into bairro (idBairro, dscBairro, idCidde) values ('37', 'São Félix de Minas', '2200301');
insert into bairro (idBairro, dscBairro, idCidde) values ('38', 'Érico Cardoso', '1600238');
insert into bairro (idBairro, dscBairro, idCidde) values ('39', 'Oriximiná', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('40', 'Sales Oliveira', '3541505');
insert into bairro (idBairro, dscBairro, idCidde) values ('41', 'Teixeirópolis', '2800407');
insert into bairro (idBairro, dscBairro, idCidde) values ('42', 'Bom Jesus', '1600238');
insert into bairro (idBairro, dscBairro, idCidde) values ('43', 'Cacaulândia', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('44', 'São João Batista', '2200202');
insert into bairro (idBairro, dscBairro, idCidde) values ('45', 'Quixadá', '1600253');
insert into bairro (idBairro, dscBairro, idCidde) values ('46', 'Nova Friburgo', '3201605');
insert into bairro (idBairro, dscBairro, idCidde) values ('47', 'Carrancas', '1600105');
insert into bairro (idBairro, dscBairro, idCidde) values ('48', 'Rio Negrinho', '1600105');
insert into bairro (idBairro, dscBairro, idCidde) values ('49', 'São José do Inhacorá', '3201308');
insert into bairro (idBairro, dscBairro, idCidde) values ('50', 'Marechal Deodoro', '1600253');
insert into bairro (idBairro, dscBairro, idCidde) values ('51', 'Pariconha', '1600212');
insert into bairro (idBairro, dscBairro, idCidde) values ('52', 'Cachoeira da Prata', '1600204');
insert into bairro (idBairro, dscBairro, idCidde) values ('53', 'Floresta do Piauí', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('54', 'Nova Colinas', '2200202');
insert into bairro (idBairro, dscBairro, idCidde) values ('55', 'Rincão', '2800308');
insert into bairro (idBairro, dscBairro, idCidde) values ('56', 'Jesúpolis', '1600212');
insert into bairro (idBairro, dscBairro, idCidde) values ('57', 'Novo Horizonte do Sul', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('58', 'Afrânio', '2800209');
insert into bairro (idBairro, dscBairro, idCidde) values ('59', 'Tubarão', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('60', 'Solidão', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('61', 'Altinho', '3541802');
insert into bairro (idBairro, dscBairro, idCidde) values ('62', 'Farol', '2200103');
insert into bairro (idBairro, dscBairro, idCidde) values ('63', 'Belém do Piauí', '3541703');
insert into bairro (idBairro, dscBairro, idCidde) values ('64', 'Bela Vista do Piauí', '3201308');
insert into bairro (idBairro, dscBairro, idCidde) values ('65', 'Colinas do Tocantins', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('66', 'Rialma', '2800407');
insert into bairro (idBairro, dscBairro, idCidde) values ('67', 'Diamante D''Oeste', '2800407');
insert into bairro (idBairro, dscBairro, idCidde) values ('68', 'Porto Ferreira', '2800605');
insert into bairro (idBairro, dscBairro, idCidde) values ('69', 'Embu-Guaçu', '2200053');
insert into bairro (idBairro, dscBairro, idCidde) values ('70', 'Buriti Bravo', '3201407');
insert into bairro (idBairro, dscBairro, idCidde) values ('71', 'Mendes Pimentel', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('72', 'Serra Caiada', '2800407');
insert into bairro (idBairro, dscBairro, idCidde) values ('73', 'Uruará', '3201605');
insert into bairro (idBairro, dscBairro, idCidde) values ('74', 'Cambuci', '2200053');
insert into bairro (idBairro, dscBairro, idCidde) values ('75', 'Grossos', '2800209');
insert into bairro (idBairro, dscBairro, idCidde) values ('76', 'Coronel Pacheco', '2200251');
insert into bairro (idBairro, dscBairro, idCidde) values ('77', 'Ilicínea', '3201308');
insert into bairro (idBairro, dscBairro, idCidde) values ('78', 'Ipaporanga', '2200277');
insert into bairro (idBairro, dscBairro, idCidde) values ('79', 'Salto Veloso', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('80', 'Aracruz', '3541703');
insert into bairro (idBairro, dscBairro, idCidde) values ('81', 'Cachoeira Paulista', '2800308');
insert into bairro (idBairro, dscBairro, idCidde) values ('82', 'Dores do Turvo', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('83', 'São Gonçalo do Pará', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('84', 'Presidente Dutra', '2800308');
insert into bairro (idBairro, dscBairro, idCidde) values ('85', 'Correntes', '3201605');
insert into bairro (idBairro, dscBairro, idCidde) values ('86', 'Capitão Enéas', '2200301');
insert into bairro (idBairro, dscBairro, idCidde) values ('87', 'São Sebastião do Caí', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('88', 'José Gonçalves de Minas', '2200277');
insert into bairro (idBairro, dscBairro, idCidde) values ('89', 'Lupionópolis', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('90', 'Bom Jesus do Tocantins', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('91', 'Urubici', '3201704');
insert into bairro (idBairro, dscBairro, idCidde) values ('92', 'Santa Rosa de Lima', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('93', 'Umbuzeiro', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('94', 'Setubinha', '3541901');
insert into bairro (idBairro, dscBairro, idCidde) values ('95', 'Cerrito', '3541653');
insert into bairro (idBairro, dscBairro, idCidde) values ('96', 'Pilar', '1600238');
insert into bairro (idBairro, dscBairro, idCidde) values ('97', 'Cafarnaum', '2200053');
insert into bairro (idBairro, dscBairro, idCidde) values ('98', 'Tabuleiro', '3201605');
insert into bairro (idBairro, dscBairro, idCidde) values ('99', 'Presidente Juscelino', '3201506');
insert into bairro (idBairro, dscBairro, idCidde) values ('100', 'General Salgado', '3541802');


insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (1, 'QUADRA', '83', '71570202', 'QUADRA 04 CONJUNTO B LOTE 06');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (2, 'RUA', '27', '45280000', 'RUA CASTRO ALVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (3, 'RUA', '88', '61600070', 'RUA JOSÉ DA ROCHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (4, 'RUA', '72', '65715000', 'RUA JOSEANE SALES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (5, 'RUA', '84', '85601610', 'RUA TENENTE CAMARGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (6, 'RUA', '27', '35460000', 'RUA GOVERNADOR VALADARES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (7, 'RUA', '9', '63010010', 'RUA INTERVENTOR ERIVANO CRUZ 75');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (8, 'RUA', '9', '48410000', 'RUA JOVELINO PEREIRA DOS SANTOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (9, 'RUA', '17', '36600000', 'RUA DONA ANA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (10, 'RUA', '98', '86455000', 'RUA 21 DE SETEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (11, 'PRAÇA', '51', '58497000', 'PRAÇA JOÃO PESSOA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (12, 'RUA', '60', '22221060', 'RUA MINISTRO TAVARES DE LIRA 128');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (13, 'RUA', '44', '59510000', 'RUA BALTAZAR DA ROCHA BEZERRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (14, 'PRAÇA', '66', '16800000', 'PRAÇA PAPA JOÃO XXIII');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (15, 'RUA', '24', '58765000', 'RUA VIRGILIO DE ARAÚJO SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (16, 'RUA', '73', '39100000', 'RUA SÃO FRANCISCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (17, 'RUA', '6', '78550112', 'RUA DAS GREVILEAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (18, 'PRAÇA', '85', '72405025', 'PRAÇA 02');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (19, 'RUA', '69', '59900000', 'RUA RESPÍCIO JOSÉ DO NASCIMENTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (20, 'RUA', '67', '5002000', 'RUA DR. COSTA JÚNIOR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (21, 'RUA', '20', '35595000', 'RUA VIGÁRIO PARREIRAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (22, 'RUA', '5', '23070170', 'RUA DOM PEDRITO 1 - XVIII R.A.');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (23, 'RUA', '55', '83601223', 'RUA FRANCISCO XAVIER DE ALMEIDA GARRET');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (24, 'RUA', '85', '78200000', 'RUA MARECHAL DEODORO 720');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (25, 'RUA', '96', '26900000', 'RUA CALMÉRIO RODRIGUES FERREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (26, 'RUA', '49', '59190000', 'RUA GETULIO VARGAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (27, 'RUA', '64', '98920000', 'RUA URUGUAI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (28, 'RUA', '34', '15500010', 'RUA SÃO PAULO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (29, 'RUA', '9', '76805866', 'RUA JACY PARANA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (30, 'RUA', '45', '29350000', 'RUA ÁTILA VIVÁCQUA VIEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (31, 'PRAÇA', '85', '89010150', 'PRAÇA VICTOR KONDER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (32, 'RUA', '79', '35740000', 'RUA QUINTILIANO JOSÉ DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (33, 'RUA', '11', '35970000', 'RUA PADRE CRUZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (34, 'RUA', '73', '46800000', 'RUA CORINTO SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (35, 'RUA', '46', '35300275', 'RUA ANTÔNIO CIMINI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (36, 'RUA', '91', '25915000', 'RUA MÁRIO DE BRITO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (37, 'RUA', '60', '85807440', 'RUA JUSCELINO KUBTSCHEK DE OLIVEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (38, 'RUA', '71', '86300000', 'RUA DOS EXPEDICIONARIOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (39, 'RUA', '15', '63200000', 'RUA CEL. JOSE DANTAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (40, 'RUA', '97', '55180000', 'RUA VEREADOR PEDRO DOCA FILHO S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (41, 'RUA', '20', '95250000', 'RUA WALDEMAR MANSUETO GRAZZIOTIN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (42, 'RUA', '30', '36120000', 'RUA GOVERNADOR VALADARES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (43, 'PRAÇA', '81', '49270000', 'PRAÇA DA BANDEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (44, 'PRAÇA', '64', '47240000', 'PRAÇA PEDRO PEREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (45, 'RUA', '57', '79700000', 'RUA IPIRANGA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (46, 'RUA', '36', '84035350', 'RUA SAINT HILAIRE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (47, 'RUA', '64', '56220000', 'RUA TEODÓZIO LEANDRO HORAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (48, 'RUA', '52', '29130013', 'RUA ASPÁZIA DIAS VAREJÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (49, 'PRAÇA', '17', '58660000', 'PRAÇA JOÃO PESSOA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (50, 'RUA', '89', '15800300', 'RUA TERESINA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (51, 'TRAVESSA', '17', '89820000', 'TV ERNESTO CARMELLI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (52, 'PRAÇA', '77', '55315000', 'PRAÇA AGAMENON MAGALHÃES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (53, 'RUA', '53', '69680000', 'RUA SAO FRANCISCO S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (54, 'RUA', '32', '13280000', 'RUA DAS FORMIGAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (55, 'RUA', '59', '98870000', 'RUA CORONEL BRAULIO DE OLIVEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (56, 'RUA', '11', '24435001', 'RUA DR. FRANCISCO PORTELA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (57, 'RUA', '89', '78330000', 'RUA INGRID EGGERTT');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (58, 'RUA', '19', '26255140', 'RUA CEL. BERNARDINO DE MELLO 2585');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (59, 'RUA', '33', '14740000', 'RUA JOSÉ BORELLI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (60, 'RUA', '55', '64330000', 'RUA FRANCISCA DE ARAGAO PAIVA S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (61, 'RUA', '57', '99830000', 'RUA JOSÉ SPONCHIADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (62, 'RUA', '76', '65850000', 'RUA DOS ARCANJOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (63, 'RUA', '54', '45930000', 'RUA OSCAR TEIXEIRA DE SIQUEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (64, 'RODOVIA', '9', '28230000', 'ROD. AFONSO CELSO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (65, 'RUA', '88', '88750000', 'RUA BERNARDO LOCKS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (66, 'RUA', '35', '77960000', 'RUA ANTONIO SOUSA GOMES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (67, 'RUA', '10', '24020206', 'RUA VISCONDE DE SEPETIBA 987 - 3 ANDAR - FUNDOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (68, 'TRAVESSA', '83', '65970000', 'TRAVESSA BOA VISTA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (69, 'RUA', '74', '75250000', 'RUA 10 ESQ. C/ RUA 11-A S/N CONJ. UIRAPURU ED. FORUM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (70, 'RODOVIA', '70', '84300000', 'RODOVIA PR 340');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (71, 'RUA', '51', '95180000', 'RUA THOMAS EDSON');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (72, 'RUA', '75', '35500008', 'RUA PERNAMBUCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (73, 'RUA', '8', '89885000', 'RUA LA SALLE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (74, 'RUA', '85', '65990000', 'RUA COELHO PAREDE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (75, 'RUA', '22', '14010130', 'RUA CERQUEIRA CÉSAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (76, 'RUA', '100', '35995000', 'RUA GETÚLIO VARGAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (77, 'RUA', '53', '44850000', 'RUA MARIO CHIARINI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (78, 'RUA', '95', '21870210', 'RUA FIGUEIREDO CAMARGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (79, 'RUA', '83', '5625020', 'RUA IBIAPABA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (80, 'RODOVIA', '29', '44600000', 'RODOVIA BA 052');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (81, 'RUA', '53', '64945000', 'RUA LEONIDAS MELO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (82, 'RUA', '84', '35570000', 'RUA SILVIANO BRANDÃO 156 - CENTRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (83, 'PRAÇA', '58', '57910000', 'PRAÇA BOM JESUS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (84, 'RUA', '37', '96600000', 'RUA JULIO DE CASTILHOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (85, 'RUA', '32', '29460000', 'RUA CARLOS XAVIER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (86, 'RUA', '64', '65268000', 'RUA CÉSAR RONALDO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (87, 'RUA', '56', '79400000', 'RUA GENERAL MENDES DE MORAES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (88, 'RUA', '8', '14400840', 'RUA FRANCISCO JORGE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (89, 'RUA', '47', '64255000', 'RUA JOAO BENICIO DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (90, 'RUA', '68', '21615280', 'RUA FERNÃO DIAS  S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (91, 'RUA', '23', '7180250', 'RUA CARIRI AÇU');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (92, 'RUA', '41', '38380000', 'RUA 10');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (93, 'RUA', '45', '99680000', 'RUA CANTIDIO RODRIGUES DE ALMEIDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (94, 'RUA', '14', '55415000', 'RUA EDSON DE LIRA PAULA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (95, 'RUA', '13', '64190000', 'RUA SAO JOSE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (96, 'RUA', '9', '64410000', 'RUA MARIA DO CARMO ALVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (97, 'RUA', '18', '11410150', 'RUA WASHINGTON');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (98, 'RUA', '61', '9310110', 'RUA RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (99, 'RUA', '19', '99560000', 'RUA JOÃO TESSER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (100, 'RUA', '49', '75610000', 'RUA ADEMAR LUIZ DE MIRANDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (101, 'QUADRA', '46', '77020020', 'QUADRA 104 SUL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (102, 'RUA', '39', '55850000', 'RUA DEOCLIDES DE ANDRADE LIMA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (103, 'RUA', '48', '64607470', 'RUA PORFÍRIO BISPO DE SOUSA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (104, 'RUA', '48', '37524000', 'RUA PREFEITO JOSÉ NACÁCIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (105, 'RUA', '46', '37890000', 'RUA APARECIDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (106, 'RUA', '60', '56509330', 'RUA ORLANDO BISPO DE QUEIROZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (107, 'RUA', '47', '17890000', 'RUA PORTO ALEGRE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (108, 'RUA', '38', '62960000', 'RUA MAIA ALARCON');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (109, 'RUA', '36', '18460000', 'RUA CORONEL FRUTUOSO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (110, 'RUA', '74', '5050000', 'RUA MONTEIRO DE MELO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (111, 'RUA', '63', '36400000', 'RUA BRASIL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (112, 'RUA', '11', '55280000', 'RUA JOAO GALINDO - S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (113, 'RUA', '75', '21920257', 'RUA ORCADAS 435 - SALA 12 - XX RA (ENTR TB P/ RUA ENEIDA DE MORAES)');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (114, 'RUA', '54', '36420000', 'RUA OLGA ROBERTA PEREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (115, 'RUA', '61', '94020110', 'RUA IRMÃO GERALDO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (116, 'RUA', '84', '49770000', 'RUA ÁLVARO GARCEZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (117, 'RUA', '56', '69640000', 'RUA RUI BARBOSA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (118, 'RUA', '20', '56380000', 'RUA PREFEITO RAIMUNDO COIMBRA FILHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (119, 'RUA', '46', '86220000', 'RUA DEPUTADO FRANCISCO ESCORSIN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (120, 'RUA', '61', '84172560', 'RUA RAIMUNDO FEIJÓ GAIÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (121, 'RUA', '74', '99150000', 'RUA IRINEU FERLIN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (122, 'RUA', '60', '37660000', 'RUA BUENO DE PAIVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (123, 'PRAÇA', '21', '37750000', 'PRAÇA ANTÔNIO CARLOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (124, 'RUA', '78', '59460000', 'RUA ANTÔNIO DE OLIVEIRA AZEVEDO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (125, 'RUA', '81', '63150000', 'RUA MANOEL MORAES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (126, 'RUA', '44', '16010680', 'RUA BRIGADEIRO LUIZ ANTONIO 46');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (127, 'RUA', '66', '45810000', 'RUA DA JAQUEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (128, 'RUA', '3', '37500180', 'RUA ANTONIO SIMAO MAUAD');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (129, 'RUA', '72', '7760000', 'RUA ARNALDO ROJEK');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (130, 'PRAÇA', '12', '44245000', 'PRAÇA MANOEL LEONCIO RIBEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (131, 'RUA', '56', '84470000', 'RUA JOSÉ ADAMOWICZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (132, 'RUA', '4', '62500000', 'RUA TENENTE JOSÉ VICENTE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (133, 'RUA', '4', '88870000', 'RUA ANTONIO DA SILVA CASCAES 520 CENTRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (134, 'RUA', '40', '39400081', 'RUA JOÃO SOUTO 764');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (135, 'RUA', '75', '95780000', 'RUA DR. BRUNO DE ANDRADE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (136, 'RUA', '16', '12500210', 'RUA MARECHAL DEODORO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (137, 'PRAÇA', '8', '64400000', 'PRAÇA AVELINO DE CASTRO NETO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (138, 'RUA', '83', '59670000', 'RUA JOAO FRANCISCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (139, 'RUA', '32', '20221161', 'RUA SACADURA CABRAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (140, 'RUA', '80', '65725000', 'RUA DAS LARANJEIRAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (141, 'RUA', '6', '8500340', 'RUA ANTONIO TREVISANI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (142, 'RUA', '4', '6900000', 'RUA CORONEL LUIZ TENORIO DE BRITO N 530');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (143, 'RUA', '71', '59504000', 'RUA FRANCISCO RODRIGUES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (144, 'RUA', '65', '35240000', 'RUA MANOEL SOBREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (145, 'RUA', '92', '13490000', 'RUA SETE DE SETEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (146, 'RUA', '42', '64940000', 'RUA RUI BARBOSA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (147, 'RUA', '66', '18230000', 'RUA SADAMITA IWASSAKI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (148, 'RUA', '32', '55870000', 'RUA BARÃO DE LUCENA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (149, 'RUA', '83', '62748000', 'RUA JOSE SARAIVA SOBRINHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (150, 'RUA', '31', '27660000', 'RUA JOÃO CARVALHO DA ROCHA S/N - FORUM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (151, 'RUA', '45', '35300275', 'RUA ANTONIO CIMINI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (152, 'RUA', '61', '79150000', 'RUA APPA ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (153, 'RUA', '25', '68660000', 'RUA PADRE SÁTIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (154, 'RUA', '27', '83323320', 'RUA ÁFRICA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (155, 'RUA', '10', '93010030', 'RUA BRASIL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (156, 'RUA', '99', '58414025', 'RUA RIO GRANDE DO SUL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (157, 'RUA', '38', '86140000', 'RUA ONZE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (158, 'RUA', '24', '69195000', 'RUA EMANUEL MAFRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (159, 'RUA', '29', '97502410', 'RUA JÚLIO DE CASTILHOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (160, 'RUA', '83', '19880000', 'RUA SÃO PAULO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (161, 'RUA', '59', '19500000', 'RUA JOSÉ TEODORO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (162, 'RUA', '51', '38160000', 'RUA JERÔNIMO CARNEIRO 584');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (163, 'RUA', '51', '48280000', 'RUA QUINTINO BOCAIUVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (164, 'RUA', '50', '79037106', 'RUA DELEGADO JOSÉ ALFREDO HARDMAN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (165, 'RUA', '37', '86160000', 'RUA HORÁCIO PAGANO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (166, 'PRAÇA', '22', '35521000', 'PRAÇA JOSÉ DE FREITAS MARQUES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (167, 'RUA', '6', '38440072', 'RUA DR. AFRÂNIO / N. 124');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (168, 'RUA', '49', '64607470', 'RUA PORFIRIO BISPO DE SOUSA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (169, 'RUA', '21', '7110000', 'RUA LUIZ FACCINI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (170, 'RUA', '2', '86015650', 'RUA GOV. PARIGOT DE SOUZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (171, 'PRAÇA', '15', '50020500', 'PRAÇA DAS CINCO PONTAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (172, 'RUA', '21', '87780000', 'RUA PROJETADA SN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (173, 'RUA', '58', '99900000', 'RUA AFONSO TAGLIARI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (174, 'RUA', '35', '56870000', 'RUA PADRE IBIAPINA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (175, 'RUA', '67', '19260000', 'RUA ANTONIO SERAFIM DE SOUZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (176, 'RUA', '87', '58320000', 'RUA PRES. JOAO PESSOA S/N (ANEXO FORUM)');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (177, 'RUA', '26', '58187000', 'RUA OTÁVIO HENRIQUES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (178, 'RUA', '81', '24800205', 'RUA DESEMBARGADOR FERREIRA PINTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (179, 'RUA', '39', '77720000', 'RUA C QUADRA 52');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (180, 'RUA', '8', '35588000', 'RUA VEREADOR JOÃO VELOSO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (181, 'RUA', '43', '39680000', 'RUA GOVERNADOR VALADARES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (182, 'RUA', '1', '47600000', 'RUA DOS ESCOTEIROS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (183, 'RUA', '46', '79037106', 'RUA DELEGADO JOSÉ ALFREDO HARDMAN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (184, 'RUA', '29', '95703080', 'RUA GAL. GOES MONTEIRO N. 91 - SALA 1');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (185, 'RUA', '18', '24440440', 'RUA FELICIANO SODRE 153 2 ANDAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (186, 'RUA', '36', '87550000', 'RUA MANOEL RIBAS 1251');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (187, 'RUA', '73', '56820000', 'RUA JOSÉ MARTINS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (188, 'RUA', '49', '57620000', 'RUA JURACY TENÓRIO CAVALCANTE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (189, 'PRAÇA', '26', '46880000', 'PRAÇA BERNARDO DE BRITO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (190, 'RUA', '42', '84550000', 'RUA ADOLFO STADLER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (191, 'RUA', '96', '65420000', 'RUA PROFESSOR MIGUEL MESQUITA  S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (192, 'RUA', '64', '68230000', 'RUA SÃO BENEDITO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (193, 'RUA', '15', '38430000', 'RUA OLEGARIO MACIEL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (194, 'RUA', '19', '36700000', 'RUA PADRE JÚLIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (195, 'RUA', '27', '68948000', 'RUA A-3 N 605');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (196, 'RUA', '41', '77650000', 'RUA OSVALDO VASCONCELOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (197, 'RUA', '49', '29933530', 'RUA CORONEL CONSTANTINO CUNHA 1262');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (198, 'RUA', '20', '9424150', 'RUA OVÍDIO ABRANTES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (199, 'RUA', '51', '83450000', 'RUA LUIZ CARLOS GUIMARÃES POLLI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (200, 'RUA', '87', '8410160', 'RUA SERRA DO MAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (201, 'RUA', '8', '24020200', 'RUA VISCONDE DE SEPETIBA 987 FUNDOS 3 ANDAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (202, 'RUA', '77', '49015110', 'RUA ITABAIANA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (203, 'RUA', '96', '35330000', 'RUA CORONEL ANTONIO FERNANDES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (204, 'RUA', '18', '84130000', 'RUA BARÃO DO RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (205, 'RUA', '4', '36680000', 'RUA CAPITÃO BRAZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (206, 'RUA', '82', '33900450', 'RUA MARIO ALEXANDRINO DA ROCHA ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (207, 'PRAÇA', '27', '25880000', 'PRAÇA BARÃO DE AYURUOCA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (208, 'RUA', '6', '84570000', 'RUA OLAVO BILAC');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (209, 'RUA', '54', '86270000', 'RUA PAULO NADER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (210, 'RUA', '49', '65490000', 'RUA MAGALHÃES DE ALMEIDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (211, 'RUA', '67', '98700000', 'RUA TIRADENTES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (212, 'RUA', '95', '58890000', 'RUA PADRE AYRES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (213, 'RUA', '76', '96270000', 'RUA QUINZE DE NOVEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (214, 'RUA', '27', '36520000', 'RUA ZENON DRUMOND');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (215, 'RUA', '47', '29640000', 'RUA MARECHAL FLORIANO PEIXOTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (216, 'PRAÇA', '13', '18040295', 'PRAÇA DA MAÇONARIA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (217, 'RUA', '61', '75580000', 'RUA ALVINO MARQUES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (218, 'RUA', '67', '55170000', 'RUA DOM LUIZ DE BRITO 200');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (219, 'RUA', '97', '37540000', 'RUA BARÃO DO RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (220, 'RUA', '53', '76450000', 'RUA I');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (221, 'PRAÇA', '54', '12850000', 'PRAÇA RUBIÃO JÚNIOR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (222, 'RUA', '8', '48660000', 'RUA CEL. JOÃO SÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (223, 'RUA', '54', '59335000', 'RUA FRANCISCO CÍCERO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (224, 'RUA', '14', '12800000', 'RUA JOSÉ MENOTTI BERNARDINI DE CARVALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (225, 'RUA', '91', '78820000', 'RUA JURUCÊ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (226, 'RUA', '46', '76680000', 'RUA 45 ESQ. C. RUA 56 E RUA 04 ED. DO FORUM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (227, 'PRAÇA', '32', '35116000', 'PRAÇA BENEDITO VALADARES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (228, 'PRAÇA', '27', '11680000', 'PRAÇA 13 DE MAIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (229, 'RUA', '16', '75080850', 'RUA AUGUSTO DE LIMA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (230, 'RUA', '9', '68640000', 'RUA HERMENEGILDO ALVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (231, 'RUA', '82', '37640000', 'RUA TIRADENTES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (232, 'RUA', '97', '65630200', 'RUA DRA. LIZETE DE OLIVEIRA FARIAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (233, 'RUA', '34', '94410030', 'RUA CEL. MARIO ANTUNES DA VEIGA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (234, 'RUA', '73', '15910000', 'RUA JEREMIAS DE PAULA EDUARDO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (235, 'RUA', '93', '87560000', 'RUA CRISTÓVÃO COLOMBO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (236, 'COMPLEXO', '7', '76801470', 'COMPLEXO RIO MADEIRA (CPA) AV. FARQUAR 2986');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (237, 'RUA', '5', '58135000', 'RUA CÍCERO GALDINO SOBRINHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (238, 'RUA', '3', '78700100', 'RUA FERNANDO CORREA DA COSTA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (239, 'RUA', '49', '93600000', 'RUA THEODOMIRO PORTO DA FONSECA 130 - TÉRREO - SALA 02');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (240, 'RUA', '93', '65225000', 'RUA HUMBERTO DE CAMPOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (241, 'RUA', '69', '65284000', 'RUA CAPITAO MAGALHAES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (242, 'RUA', '78', '28650000', 'RUA LUCIANO DE SOUZA TURQUE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (243, 'PRAÇA', '61', '35537000', 'PRAÇA FRANCISCO SALES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (244, 'RUA', '38', '75600000', 'RUA MINAS GERAIS 265');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (245, 'RUA', '59', '15025510', 'RUA LAFAIETE SPÍNOLA DE CASTRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (246, 'RUA', '57', '69470000', 'RUA DANIEL SEVALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (247, 'RUA', '21', '64995000', 'RUA TANCREDO NEVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (248, 'RUA', '41', '69660000', 'RUA CÍCERO TUCHAUA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (249, 'RUA', '61', '59940000', 'RUA JOSÉ FERNANDES DE QUEIROZ E SÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (250, 'RUA', '88', '97560000', 'RUA DR ACAUAN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (251, 'RUA', '4', '78470000', 'RUA DR. MURTINHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (252, 'COMPLEXO', '8', '76805866', 'C P A  COMPLEXO RIO MADEIRA CURVO 2  AV. FARQUAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (253, 'RUA', '72', '80220902', 'RUA JOAO PAROLIN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (254, 'RUA', '65', '68371030', 'RUA CORONEL JOSÉ PORFÍRIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (255, 'RUA', '33', '13970050', 'RUA PRUDENTE DE MORAES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (256, 'RUA', '66', '68810000', 'RUA SILAS PINHEIRO S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (257, 'RUA', '26', '14540000', 'RUA CAPITÃO VITORIANO MACHADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (258, 'RUA', '63', '79980000', 'RUA TUPINAMBÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (259, 'RUA', '16', '39660000', 'RUA JOSINA ANTUNES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (260, 'RUA', '33', '94940190', 'RUA MANATÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (261, 'RUA', '67', '67030160', 'RUA JOSÉ MARCELINO DE OLIVEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (262, 'RUA', '22', '18530000', 'RUA LARA CAMPOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (263, 'RUA', '47', '58540000', 'RUA ANTONIO BATISTA GONÇALVES - 281');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (264, 'RUA', '72', '59810000', 'RUA DAMIÃO MONTEIRO DE SOUZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (265, 'RUA', '53', '55495000', 'RUA MARECHAL RONDON');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (266, 'RUA', '59', '64000080', 'RUA 24 DE JANEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (267, 'RUA', '21', '95940000', 'RUA GENERAL DALTRO FILHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (268, 'RUA', '86', '78840000', 'RUA JOÃO PESSOA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (269, 'RUA', '26', '73840000', 'RUA DAS LARANJEIRAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (270, 'RUA', '88', '68633000', 'RUA GONÇALVES DIAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (271, 'RUA', '17', '85555000', 'RUA CAPITÃO PAULO DE ARAÚJO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (272, 'TRAVESSA', '6', '97300000', 'TRAVESSA PAUL HARRIS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (273, 'RUA', '3', '86015650', 'RUA GOVERNADOR  PARIGOT DE SOUZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (274, 'RUA', '68', '36730000', 'RUA CAPITÃO JOSÉ BIFANO N 271');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (275, 'PRAÇA', '57', '57540000', 'PRAÇA CEL JOSÉ MALTA DE SÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (276, 'RUA', '76', '87501200', 'RUA DES. ANTONIO F. F. DA COSTA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (277, 'RUA', '47', '57230000', 'RUA C');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (278, 'RUA', '56', '29050480', 'RUA VITÓRIO NUNES DA MOTTA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (279, 'RUA', '47', '79037106', 'RUA DELEGADO JOSÉ ALFREDO HARDMAN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (280, 'RUA', '95', '26551190', 'RUA CAPITAO TELES 520');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (281, 'ESTRADA', '23', '25750226', 'ESTRADA UNIAO E INDUSTRIA 11860 SALA 4');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (282, 'RUA', '87', '13700000', 'RUA LUIZ PIZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (283, 'RUA', '5', '44500000', 'RUA BENJAMIN CONSTANT');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (284, 'RUA', '57', '84150000', 'RUA VEREADOR PEDRO VAGNER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (285, 'RUA', '34', '76470000', 'RUA MARECHAL HUMBERTO CASTELO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (286, 'RUA', '63', '9310110', 'RUA RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (287, 'RUA', '45', '46140000', 'RUA JOSÉ MARIA TANAJURA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (288, 'RUA', '76', '78635000', 'RUA 06');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (289, 'RUA', '42', '18320970', 'RUA MAJOR AUGUSTO FRANCISCO RIOS CARNEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (290, 'RUA', '31', '58840000', 'RUA PROFESSORA MARIA CLAUDETE BANDEIRA DE SOUSA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (291, 'RUA', '14', '69960000', 'RUA CORNELIO DE OLIVEIRA LIMA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (292, 'RUA', '91', '65550000', 'RUA CÔNEGO NESTOR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (293, 'RUA', '85', '86845000', 'RUA AMAZONAS 1000');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (294, 'RUA', '16', '89560000', 'RUA ANTONIO PINTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (295, 'RUA', '99', '21870210', 'RUA FIGUEIREDO CAMARGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (296, 'RUA', '64', '12245912', 'RUA PAULO SETUBAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (297, 'RUA', '80', '36830000', 'RUA FIORAVANTE PADULA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (298, 'RUA', '13', '24440440', 'RUA DR. FELICIANO SODRÉ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (299, 'RUA', '86', '26423290', 'RUA JOAO BATISTA EVANGELISTA S/N - CENTRO DE ENGENHEIRO PEDREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (300, 'RUA', '48', '58680000', 'RUA SOLON DE LUCENA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (301, 'RUA', '18', '69930000', 'RUA CORONEL BRANDÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (302, 'RUA', '28', '45570000', 'RUA BORGES DE BARROS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (303, 'RUA', '90', '55390000', 'RUA SERGIO ALVES DE MELO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (304, 'RUA', '18', '58713000', 'RUA MONSENHOR VALERIANO PEREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (305, 'RUA', '59', '69350000', 'RUA ANTONIO DOURADO DE SANTANA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (306, 'RUA', '59', '35860000', 'RUA DANIEL DE CARVALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (307, 'RUA', '94', '78280000', 'RUA GERMANO GREVE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (308, 'RUA', '44', '75815000', 'RUA JOÃO VIEIRA MACHADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (309, 'RUA', '81', '78390000', 'RUA SÃO BENEDITO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (310, 'PRAÇA', '47', '39864000', 'PRAÇA GETULIO VARGAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (311, 'RUA', '41', '85770000', 'RUA PEDRO AMÉRICO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (312, 'RUA', '66', '64300000', 'RUA CÍCERO PORTELA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (313, 'RUA', '45', '76290000', 'RUA 20');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (314, 'RUA', '40', '29770000', 'RUA FLORIANO RUBIM S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (315, 'TRAVESSA', '77', '66087490', 'TV PIRAJA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (316, 'RUA', '60', '65393000', 'RUA NIVEL MÉDIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (317, 'RUA', '25', '75870000', 'RUA 28');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (318, 'RUA', '13', '89770000', 'RUA SÉTIMO CASAROTTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (319, 'RUA', '99', '85303130', 'RUA BARÃO DO RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (320, 'RUA', '76', '37970000', 'RUA DA BANDEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (321, 'RUA', '41', '63540000', 'RUA IRACI BEZERRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (322, 'QUADRA', '84', '73035070', 'QUADRA 07 AREA RESERVADA 01');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (323, 'RUA', '7', '63290000', 'RUA SANTO ANTONIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (324, 'RUA', '62', '12245460', 'RUA PAULO SETÚBAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (325, 'PRAÇA', '77', '35610000', 'PRAÇA GETÚLIO VARGAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (326, 'RUA', '33', '45585000', 'RUA PORTO SEGURO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (327, 'RUA', '33', '20221161', 'RUA SACADURA CABRAL 226 FUNDOS SOBRADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (328, 'RUA', '4', '86015650', 'RUA GOV. PARIGOT DE SOUZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (329, 'RUA', '55', '21870210', 'RUA FIGUEIREDO CAMARGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (330, 'RUA', '100', '58414025', 'RUA RIO GRANDE DO SUL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (331, 'PRAÇA', '10', '39930000', 'PRAÇA POLÍBIO RUAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (332, 'RUA', '15', '24435001', 'RUA DOUTOR FRANCISCO PORTELA 2.775');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (333, 'RUA', '32', '76485000', 'RUA SÃO JOÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (334, 'RUA', '28', '83323320', 'RUA ÁFRICA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (335, 'RUA', '43', '42700000', 'RUA SILVANDIR F. CHAVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (336, 'RUA', '100', '9920140', 'RUA JOÃO DE ALMEIDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (337, 'RUA', '14', '63210000', 'RUA CAPITAO MIGUEL DANTAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (338, 'RUA', '68', '28660000', 'RUA NILO PEÇANHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (339, 'RUA', '1', '62980000', 'RUA ULISSES HOLANDA CAMPELO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (340, 'RUA', '77', '87501200', 'RUA DES. ANTONIO F. F. DA COSTA - 3585 - FORUM ELEITORAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (341, 'RUA', '57', '37440000', 'RUA MAJOR PENHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (342, 'RUA', '89', '63400000', 'RUA CEL JOAO CANDIDO 578 FORUM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (343, 'RUA', '63', '22460000', 'RUA JARDIM BOTANICO 1060');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (344, 'RODOVIA', '52', '86350000', 'RODOVIA ANTONIO DA SILVA MACHADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (345, 'RUA', '32', '64540000', 'RUA JOSÉ DO RÊGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (346, 'RUA', '6', '58200000', 'RUA ALMEIDA BARRETO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (347, 'RUA', '31', '25953240', 'RUA ALICE QUINTELA MAURICI REGADAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (348, 'RUA', '99', '9911180', 'RUA PROFESSORA VITALINA CAIAFA ESQUIVEL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (349, 'TRAVESSA', '29', '63900129', 'TV TIRADENTES 452 - CALCADÃO MANOEL RODRIGUES DA FONSECA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (350, 'RUA', '45', '14801350', 'RUA ITÁLIA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (351, 'RUA', '64', '83570000', 'RUA EXPEDICIONARIO PEDRO PAULIN S/NR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (352, 'RUA', '7', '88140000', 'RUA PEDRO MANSUR ELIAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (353, 'RUA', '12', '85615000', 'RUA IGNACIO FELIPE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (354, 'PRAÇA', '70', '37476000', 'PRAÇA SANTO ANTÔNIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (355, 'RUA', '64', '64120000', 'RUA ANFRÍSIO LOBÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (356, 'PRAÇA', '13', '46200000', 'PRAÇA SANTO ANTÔNIO - S/N - FÓRUM DES. JAYME BULHÕES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (357, 'RUA', '92', '55590000', 'RUA CEL. JOÃO DE SOUZA LEÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (358, 'RUA', '66', '59215000', 'RUA PADRE NORMANDO PIGNATARO DELGADO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (359, 'RUA', '28', '96790000', 'RUA CEL. ARAÚJO RIBEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (360, 'RODOVIA', '91', '62160000', 'RODOVIA CE 364');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (361, 'RUA', '94', '11750000', 'RUA DOS PESCADORES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (362, 'RUA', '18', '62170000', 'RUA VICENTE GOMES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (363, 'RUA', '45', '36955000', 'RUA ARTUR LOBATO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (364, 'RUA', '42', '42700000', 'RUA SILVANDIR F. CHAVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (365, 'RUA', '86', '68685000', 'RUA 13 DE MAIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (366, 'RUA', '90', '45170000', 'RUA CASTELO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (367, 'RUA', '31', '69460000', 'RUA PADRE VICENTE NOGUEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (368, 'RUA', '2', '39430000', 'RUA 31 DE DEZEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (369, 'RUA', '84', '6233060', 'RUA GENERAL LABATUT');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (370, 'RUA', '30', '84240000', 'RUA MINERVINA DE FREITAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (371, 'RUA', '52', '86390000', 'RUA JOAQUIM RODRIGUES FERREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (372, 'RUA', '58', '65380000', 'RUA NOVA BRASILIA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (373, 'RUA', '73', '21221250', 'RUA ÁPIA 257 - SALAS 201/202/206');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (374, 'TRAVESSA', '71', '66087490', 'TRAVESSA PIRAJÁ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (375, 'RUA', '26', '55860000', 'RUA JOÃO RIBEIRO DO EGITO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (376, 'RUA', '45', '59965000', 'RUA PADRE ERISBERTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (377, 'PRAÇA', '1', '55385000', 'PRAÇA JOAQUIM NABUCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (378, 'RUA', '39', '63750000', 'RUA JESUITA ADEODATO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (379, 'RUA', '50', '65570000', 'RUA 7 DE SETEMBRO S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (380, 'RUA', '39', '84400000', 'RUA OSÓRIO GUIMARÃES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (381, 'RUA', '71', '57265000', 'RUA PEDRO CAVALCANTE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (382, 'RUA', '24', '36900000', 'RUA AMARAL FRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (383, 'PRAÇA', '18', '37170000', 'PRAÇA CORONEL NEVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (384, 'RUA', '9', '56163000', 'RUA CORONEL JAMBO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (385, 'RUA', '14', '24425000', 'RUA OLIVEIRA BOTELHO S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (386, 'RUA', '37', '38500000', 'RUA TITO FULGÊNCIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (387, 'RUA', '78', '35490000', 'RUA LAGOA DOURADA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (388, 'RUA', '83', '35800000', 'RUA ARTHUR COUTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (389, 'RUA', '72', '95300000', 'RUA DR. JORGE MOOJEN');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (390, 'PRAÇA', '5', '13930000', 'PRAÇA BARÃO DO RIO BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (391, 'ESTRADA', '92', '23860000', 'ESTRADA SÃO JOÃO MARCOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (392, 'RUA', '84', '68740000', 'RUA GILBERTO MENEZES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (393, 'PRAÇA', '12', '36212000', 'PRAÇA SANTANA N. 120 - TÉRREO (PALÁCIO DOS TRÊS PODERES)');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (394, 'RUA', '67', '84530000', 'RUA JOÃO NEGRÃO JUNIOR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (395, 'RUA', '80', '78325000', 'RUA 15 DE NOVEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (396, 'RUA', '13', '76880000', 'RUA BARRETOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (397, 'RUA', '25', '28940000', 'RUA FRANCISCO COELHO PEREIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (398, 'RUA', '34', '13860000', 'RUA CARLOS GOMES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (399, 'RUA', '96', '8461420', 'RUA ÁLVARO DA COSTA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (400, 'RUA', '23', '58328000', 'RUA FERNANDO CABRAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (401, 'RUA', '48', '75803018', 'RUA DO HIPODROMO ESQ. COM ELIONOR FRANÇA N. 590');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (402, 'RUA', '28', '64520000', 'RUA ABDON PORTELA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (403, 'RUA', '74', '44150000', 'RUA ISALTINA CAMPOS - S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (404, 'RUA', '98', '63640000', 'RUA JOÃO FACUNDES BONFIM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (405, 'RUA', '4', '13631062', 'RUA JOSÉ BONIFÁCIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (406, 'RUA', '96', '68710000', 'RUA CANTÍDIO GUIMARÃES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (407, 'TRAVESSA', '14', '26255240', 'TRAVESSA VILA IBOTY 34');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (408, 'RUA', '42', '57312630', 'RUA GERVÁSIO DE OLIVEIRA LIMA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (409, 'RUA', '24', '45450000', 'RUA MANOEL LIBÂNIO DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (410, 'PRAÇA', '26', '39730000', 'PRAÇA DA MATRIZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (411, 'RUA', '79', '13013900', 'RUA REGENTE FEIJÓ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (412, 'RUA', '67', '26130525', 'RUA URUGUAI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (413, 'RUA', '25', '28390000', 'RUA PREFEITO SINVAL AUGUSTO FERREIRA DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (414, 'RODOVIA', '69', '68445000', 'ROD. MOURA CARVALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (415, 'RUA', '92', '16300000', 'RUA SÃO FRANCISCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (416, 'RUA', '63', '27310020', 'RUA ARGEMIRO DE PAULA COUTINHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (417, 'PRAÇA', '17', '42850000', 'PRAÇA DOS TRÊS PODERES SN LESSA RIBEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (418, 'RUA', '67', '65975000', 'RUA SÃO SEBASTIÃO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (419, 'RUA', '27', '95840000', 'RUA DOS BOMBEIROS VOLUNTÁRIOS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (420, 'RUA', '94', '58960000', 'RUA MAE UMBELINA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (421, 'RUA', '68', '1126030', 'RUA ANTONIO CORUJA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (422, 'RUA', '98', '58414025', 'RUA RIO GRANDE DO SUL S/N - COMPLEXO JUDICIARIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (423, 'RUA', '48', '29933530', 'RUA CORONEL CONSTANTINO CUNHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (424, 'RUA', '72', '13800051', 'RUA TREZE DE MAIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (425, 'RUA', '5', '97610000', 'RUA PINHEIRO ROCHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (426, 'RUA', '67', '45810000', 'RUA DA JAQUEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (427, 'RUA', '31', '29800000', 'RUA DEOLINDO DAZÍLIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (428, 'RUA', '97', '12970000', 'RUA BENEDITO VIEIRA DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (429, 'RUA', '46', '59760000', 'RUA ANTONIO JOAQUIM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (430, 'RUA', '66', '33600000', 'RUA CORONEL CÂNDIDO VIANA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (431, 'RUA', '48', '95960000', 'RUA SETE DE SETEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (432, 'RUA', '62', '64000080', 'RUA 24 DE JANEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (433, 'RUA', '80', '56640000', 'RUA ANTÔNIO JOSÉ DE MOURA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (434, 'RUA', '64', '84220000', 'RUA JOSE DOMINGOS BRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (435, 'RUA', '12', '58020500', 'RUA ODON BEZERRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (436, 'RUA', '69', '3119000', 'RUA MADRE DE DEUS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (437, 'RUA', '68', '47200000', 'RUA RUY RIBEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (438, 'RUA', '97', '58900000', 'RUA VALDENEZ PEREIRA DE SOUZA S/N - ANEXO AO FORUM FERREIRA JUNIOR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (439, 'RUA', '35', '58398000', 'RUA JULITA GARCIA SERAFIM');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (440, 'RUA', '79', '55460000', 'RUA JOSÉ LUIZ DA SILVEIRA BARROS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (441, 'RUA', '76', '3645000', 'RUA JORGE AUGUSTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (442, 'RUA', '82', '55715000', 'RUA SEBASTIÃO DA ROCHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (443, 'RUA', '84', '18304130', 'RUA RAFAEL MACHADO NETO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (444, 'RUA', '2', '19200000', 'RUA CASTRO ALVES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (445, 'RUA', '50', '29176055', 'RUA DOMINGOS MARTINS N. 87');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (446, 'RUA', '2', '76963804', 'RUA ANISIO SERRAO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (447, 'RUA', '23', '69700000', 'RUA PADRE BAUZOLA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (448, 'RUA', '94', '8030460', 'RUA JAGUAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (449, 'RUA', '36', '95680000', 'RUA DONA CARLINDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (450, 'RUA', '28', '29600000', 'RUA ANÁLIA VIEIRA DE SOUZA N 275');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (451, 'RUA', '86', '58390000', 'RUA MARIA CÂNDIDA DE SENA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (452, 'RUA', '29', '11740000', 'RUA PROFA. DINORAH CRUZ');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (453, 'PRAÇA', '16', '50020500', 'PRAÇA DAS CINCO PONTAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (454, 'RUA', '16', '97340000', 'RUA OSVALDO ARANHA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (455, 'RUA', '93', '89665000', 'RUA NARCISO BARISON');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (456, 'RUA', '42', '58580000', 'RUA RAUL DA COSTA LEAO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (457, 'RUA', '13', '73950000', 'RUA FRANCISCO MOTA LIMA  ESQ/ COM RUA 02');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (458, 'RUA', '37', '64850000', 'RUA DOM PEDRO I');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (459, 'RUA', '57', '64700000', 'RUA SÉRGIO FERREIRA DE CARVALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (460, 'RUA', '43', '29380000', 'RUA FENIANO MITLEG');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (461, 'RUA', '99', '88770000', 'RUA ANTONIO BITTENCOURT CAPANEMA S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (462, 'RUA', '24', '37564000', 'RUA FRANCISCO ÁLVARO SOBREIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (463, 'RUA', '43', '16010680', 'RUA BRIGADEIRO LUIZ ANTONIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (464, 'RUA', '35', '84035350', 'RUA SAINT HILAIRE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (465, 'RUA', '4', '23515040', 'RUA MARTINHO DE CAMPOS S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (466, 'RUA', '49', '13610220', 'RUA DR. ARMANDO DE SALLES OLIVEIRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (467, 'RUA', '69', '44640000', 'RUA DR. PEDRO PAULO MASCARENHAS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (468, 'RUA', '12', '55240000', 'RUA FREI BERNARDO SCHENEIDER');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (469, 'RUA', '33', '69870000', 'RUA WALTER LINS S/N');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (470, 'RUA', '93', '21870210', 'RUA FIGUEIREDO CAMARGO 1133 - SALA 205');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (471, 'RUA', '31', '13220090', 'RUA MARIA APARECIDA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (472, 'RUA', '41', '95080190', 'RUA GARIBALDI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (473, 'RUA', '88', '37177000', 'RUA DONA LEOPOLDINA MAIA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (474, 'RUA', '70', '62970000', 'RUA CEL. SIMPLICIO BEZERRA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (475, 'RUA', '58', '28970000', 'RUA BENTO LISBOA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (476, 'RUA', '26', '14010130', 'RUA CERQUEIRA CÉSAR');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (477, 'RUA', '64', '26130525', 'RUA URUGUAI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (478, 'RUA', '21', '58700330', 'RUA VIDAL DE NEGREIROS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (479, 'RUA', '71', '85903160', 'RUA MIRALDO PEDRO ZIBETTI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (480, 'PRAÇA', '29', '27511380', 'PRAÇA MARECHAL JOSÉ PESSOA 95 - EDIFÍCIO DO FÓRUM ANTIGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (481, 'RUA', '27', '35420000', 'RUA ANTÔNIO OLINTO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (482, 'RUA', '70', '83414010', 'RUA PADRE FRANCISCO CAMARGO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (483, 'ESTRADA', '99', '65763000', 'ESTRADA DE ACESSO AO MIL REIS');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (484, 'RUA', '16', '84350000', 'RUA VIENA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (485, 'RUA', '60', '95670000', 'RUA AUGUSTO DAROS 100');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (486, 'RUA', '95', '18170000', 'RUA DOUTOR CAMPOS SALES');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (487, 'RUA', '45', '58155000', 'RUA VENÂNCIO MARTINS SAMPAIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (488, 'RUA', '28', '13330120', 'RUA TREZE DE MAIO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (489, 'RUA', '35', '48850000', 'RUA XV DE NOVEMBRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (490, 'RUA', '9', '37140000', 'RUA JOÃO DUARTE');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (491, 'RUA', '61', '12245460', 'RUA PAULO SETÚBAL');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (492, 'RUA', '31', '44900000', 'RUA FORTALEZA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (493, 'RUA', '2', '35950000', 'RUA MONSENHOR BICALHO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (494, 'RUA', '83', '78600000', 'RUA JOSE NOBREGA DA SILVA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (495, 'RUA', '70', '59196000', 'RUA JOÃO PESSOA');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (496, 'RUA', '24', '95860000', 'RUA MARGARIDA RIBEIRO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (497, 'RUA', '90', '88350140', 'RUA HUMBERTO MATTIOLLI');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (498, 'RUA', '36', '77760000', 'RUA 07');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (499, 'CONJUNTO', '88', '49970000', 'CONJUNTO ALBANO FRANCO');
insert into logradouro (idLogr, dscTipoLogr, idBairro, numCepLogr, dscLogr) values (500, 'RUA', '29', '28637000', 'RUA JOÃO AMÂNCIO');
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (1, 'A Viabilidade, As Oportunidades E Os Desafios Do Turismo Náutico No Litoral Norte Da Paraíba', '2016-03-03', '2016-12-12', 3, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (2, 'Desenvolvimento De Um Abafador De Ruído Concha Controlado Eletronicamente', '2016-04-01', '2016-12-15', 9, 10202048);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (3, 'Iluminação A Led – Eficiência Energética E Tecnologia Social', '2016-04-01', '2016-12-31', 9, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (4, 'Gênero E Democracia Paritária: O Estudo Da Participação Feminina Nos Cargos De Gestão E Coordenação Do Ifpb', '2016-04-01', '2016-12-31', 8, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (5, 'Profetas Das Chuvas: Plantas Utilizadas Como Bioindicadores De Chuva Por Populações Quilombolas E Assentamentos Rurais Do Município De Catolé Do Rocha-Pb.', '2016-03-01', '2016-12-20', 4, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (6, 'A Arte Pré-Histórica No Cariri Ocidental Da Paraíba', '2016-03-03', '2016-12-12', 3, 10102043);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (7, 'Gerenciamento De Resíduos De Construção Civil Em Obras De Edificações Na Cidade De Guarabira', '2016-04-01', '2016-12-31', 1, 40602006);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (8, 'A Língua Inglesa Em Rótulos De Produtos Comerciais Em Guarabira - Pb: Uma Leitura Do Visual Ao Verbal', '2016-04-01', '2016-08-31', 9, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (9, 'Estrangeirismos No Comércio De Guarabira - Pb: Ocorrência E Significado Das Palavras Em Estabelecimentos Comerciais E Na Publicidade Impressa', '2016-04-01', '2016-08-30', 4, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (10, 'Caracterização Do Óleo De Syagrus Cearensis (Coco Catolé) E Avaliação De Sua Atividade Fotoprotetora', '2016-04-01', '2016-12-31', 7, 40403009);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (11, 'Multiletramentos: Aprendizado De Língua Espanhola Através Das Redes Sociais E Whatsapp No Ifpb De Catolé Do Rocha', '2016-04-01', '2016-12-01', 4, 10202005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (12, 'Mídias Digitais, Ficção Científica E Ensino: A Utilização Do Podcast Como Ferramenta Para O Ensino De Física E Ciências', '2016-03-08', '2016-11-30', 2, 40403009);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (13, 'Diagnóstico Da Situação Das Lâmpadas Fluorescentes Pós-Consumo Na Cidade De Itabaiana - Pb.', '2016-05-01', '2016-12-31', 6, 40403009);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (14, 'Bromelia Karatas: Síndromes De Dispersão Ocorrentes Em Brejos De Altitude', '2016-05-02', '2016-10-31', 1, 10202005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (15, 'Intellicar - Sistema Distribuído De Diagnóstico, Socialização De Informações E Controle Automatizado De Velocidade Máxima Permitida Para Carros Inteligentes', '2016-05-17', '2016-12-28', 1, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (16, 'Impactos E Desafios Da Convivência Com O Semiárido No Estado Da Paraíba: O Caso Do Município De Esperança/Pb', '2015-12-18', '2016-12-30', 7, 10202048);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (17, 'Distúrbios Musculoesqueléticos Em Instrumentistas De Corda: Um Estudo De Caso No Sertão Paraibano ', '2016-05-01', '2016-12-31', 2, 10202005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (18, 'Projeto E Desenvolvimento De Um Robô Autônomo', '2016-05-01', '2016-12-31', 7, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (19, 'Levantamento Da Entomofauna No Ifpb- Campus Campina Grande, Pb, Utilizando Armadilhas Com Garrafa Pet', '2016-05-01', '2016-12-30', 4, 10102043);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (20, 'Capacidade Para O Trabalho Em Docentes', '2016-05-01', '2016-12-31', 8, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (21, 'Caracterizações E Sentidos Do Cuidado Na Velhice', '2016-05-01', '2017-01-01', 8, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (22, 'Sistemas De Seguimento Solar', '2016-05-01', '2017-01-01', 3, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (23, 'Avaliação Da Exposição Ao Ruído Em Docentes', '2016-05-01', '2016-12-31', 9, 40602006);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (24, 'Utilização Da Robótica No Processo De Aprendizagem', '2016-05-01', '2017-01-01', 7, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (25, 'Convivência Com A Semiaridez A Partir De Tecnologias De Armazenamento De Água In Situ Através De Plantas Xerófilas Cultivadas No Seridó Paraibano.', '2016-05-01', '2016-12-31', 6, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (26, 'Prova Sinalizada Como Um Princípio De Igualdade E Justiça Aos Surdos Em Ambientes Educacionais Inclusivos.', '2016-05-17', '2017-02-21', 8, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (27, 'Desenvolvimento De Um Sistema Híbrido Para A Geração De Energia Fotovoltaica E Aquecimento D''água Associado A Um Panorama Sustentável', '2016-05-17', '2016-12-17', 3, 40403009);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (28, 'Cine Educação: Gestão E Sociedade', '2016-05-17', '2016-12-30', 4, 10202005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (29, 'Inovação Tecnológica Na Desinfecção De Água Utilizando Energia Solar: Sistema Integrado Sodis - Sis', '2016-05-17', '2016-12-30', 8, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (30, 'A Viabilidade, As Oportunidades E Os Desafios Do Turismo Náutico No Litoral Norte Da Paraíba', '2016-03-03', '2016-12-12', 9, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (31, 'Desenvolvimento De Um Abafador De Ruído Concha Controlado Eletronicamente', '2016-04-01', '2016-12-15', 4, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (32, 'Iluminação A Led – Eficiência Energética E Tecnologia Social', '2016-04-01', '2016-12-31', 3, 10202048);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (33, 'Gênero E Democracia Paritária: O Estudo Da Participação Feminina Nos Cargos De Gestão E Coordenação Do Ifpb', '2016-04-01', '2016-12-31', 7, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (34, 'Profetas Das Chuvas: Plantas Utilizadas Como Bioindicadores De Chuva Por Populações Quilombolas E Assentamentos Rurais Do Município De Catolé Do Rocha-Pb.', '2016-03-01', '2016-12-20', 8, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (35, 'A Arte Pré-Histórica No Cariri Ocidental Da Paraíba', '2016-03-03', '2016-12-12', 9, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (36, 'Gerenciamento De Resíduos De Construção Civil Em Obras De Edificações Na Cidade De Guarabira', '2016-04-01', '2016-12-31', 8, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (37, 'A Língua Inglesa Em Rótulos De Produtos Comerciais Em Guarabira - Pb: Uma Leitura Do Visual Ao Verbal', '2016-04-01', '2016-08-31', 9, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (38, 'Estrangeirismos No Comércio De Guarabira - Pb: Ocorrência E Significado Das Palavras Em Estabelecimentos Comerciais E Na Publicidade Impressa', '2016-04-01', '2016-08-30', 6, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (39, 'Caracterização Do Óleo De Syagrus Cearensis (Coco Catolé) E Avaliação De Sua Atividade Fotoprotetora', '2016-04-01', '2016-12-31', 1, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (40, 'Multiletramentos: Aprendizado De Língua Espanhola Através Das Redes Sociais E Whatsapp No Ifpb De Catolé Do Rocha', '2016-04-01', '2016-12-01', 5, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (41, 'Mídias Digitais, Ficção Científica E Ensino: A Utilização Do Podcast Como Ferramenta Para O Ensino De Física E Ciências', '2016-03-08', '2016-11-30', 6, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (42, 'Diagnóstico Da Situação Das Lâmpadas Fluorescentes Pós-Consumo Na Cidade De Itabaiana - Pb.', '2016-05-01', '2016-12-31', 8, 30401020);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (43, 'Bromelia Karatas: Síndromes De Dispersão Ocorrentes Em Brejos De Altitude', '2016-05-02', '2016-10-31', 2, 40602006);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (44, 'Intellicar - Sistema Distribuído De Diagnóstico, Socialização De Informações E Controle Automatizado De Velocidade Máxima Permitida Para Carros Inteligentes', '2016-05-17', '2016-12-28', 2, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (45, 'Impactos E Desafios Da Convivência Com O Semiárido No Estado Da Paraíba: O Caso Do Município De Esperança/Pb', '2015-12-18', '2016-12-30', 4, 40404005);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (46, 'Distúrbios Musculoesqueléticos Em Instrumentistas De Corda: Um Estudo De Caso No Sertão Paraibano ', '2016-05-01', '2016-12-31', 9, 10202048);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (47, 'Projeto E Desenvolvimento De Um Robô Autônomo', '2016-05-01', '2016-12-31', 6, 40402002);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (48, 'Levantamento Da Entomofauna No Ifpb- Campus Campina Grande, Pb, Utilizando Armadilhas Com Garrafa Pet', '2016-05-01', '2016-12-30', 6, 30402026);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (49, 'Capacidade Para O Trabalho Em Docentes', '2016-05-01', '2016-12-31', 4, 10201068);
insert into projeto (idProj, dscProj, datInicioProj, DatFimProj, idInsto, idAreap) values (50, 'Caracterizações E Sentidos Do Cuidado Na Velhice', '2016-05-01', '2017-01-01', 1, 40402002);


insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (1, '842.540.084-81', 'Tatiane Betina Rezende', 'F', 4, 7, 292, '353', '17.035.203-1', '1990-03-24');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (2, '775.336.312-34', 'Pietro Theo dos Santos', 'M', 2, 7, 107, '77', '21.353.072-7', '1998-03-13');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (3, '578.838.621-70', 'Josefa Melissa Rodrigues', 'F', 3, 2, 176, '7', '34.777.861-6', '1997-06-09');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (4, '629.509.890-80', 'Eduardo Gustavo Nicolas Farias', 'M', 4, 3, 422, '9', '12.980.418-6', '1995-03-22');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (5, '982.721.179-08', 'Sophie Lara Lima', 'F', 3, 7, 483, '01', '42.735.720-2', '1990-03-05');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (6, '188.598.730-70', 'Eduarda Brbara Emily Pereira', 'F', 4, 3, 433, '87', '28.664.578-6', '1990-06-08');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (7, '346.277.056-03', 'Carolina Cludia Almeida', 'F', 3, 4, 341, '8', '47.396.365-6', '1990-05-16');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (8, '552.175.479-28', 'Bruna Louise Gabriela Moura', 'F', 1, 4, 218, '4098', '26.682.259-9', '1990-04-23');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (9, '696.779.848-02', 'Mariana Sarah Luiza da Rocha', 'F', 1, 1, 55, '80', '46.214.601-7', '1990-03-11');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (10, '078.732.276-85', 'Aparecida Evelyn Emily Dias', 'F', 4, 9, 427, '739', '45.045.089-2', '1990-03-21');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (11, '938.719.166-41', 'Elo Isabel Silvana da Paz', 'F', 1, 7, 118, '3733', '23.452.642-7', '1990-01-21');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (12, '952.891.601-59', 'Isis Valentina Moraes', 'F', 3, 1, 470, '6816', '40.408.153-8', '1990-04-18');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (13, '778.024.560-88', 'Lus Antonio Teixeira', 'M', 4, 3, 262, '734', '43.083.204-7', '1990-04-23');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (14, '231.374.432-96', 'Thales Ruan Heitor da Cruz', 'M', 4, 3, 147, '157', '46.916.818-3', '1990-06-02');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (15, '270.812.480-39', 'Luna Andreia Souza', 'F', 1, 4, 339, '84707', '23.240.572-4', '1990-04-24');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (16, '088.612.327-52', 'Daniela Renata Drumond', 'F', 3, 1, 417, '062', '11.739.761-1', '1990-02-07');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (17, '024.244.277-39', 'Renan Ryan Figueiredo', 'M', 1, 6, 301, '04087', '18.878.854-2', '1990-04-20');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (18, '593.165.502-62', 'Vinicius Victor Vieira', 'M', 4, 2, 282, '56', '37.331.699-9', '1990-06-02');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (19, '839.062.521-08', 'Dbora Emilly Luiza Almada', 'F', 3, 3, 474, '81510', '42.036.423-7', '1990-06-11');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (20, '197.809.418-35', 'Enzo Mateus Kau Barbosa', 'M', 1, 7, 270, '385', '23.929.635-7', '1990-06-10');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (21, '739.712.691-09', 'Caleb Hugo Felipe Nascimento', 'M', 3, 9, 362, '95778', '16.747.220-3', '1990-04-02');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (22, '414.452.103-63', 'Bento Marcos Vinicius Marcelo Silva', 'M', 2, 9, 124, '70926', '23.194.151-1', '1990-04-09');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (23, '349.352.986-42', 'Francisco Tiago Hugo Pires', 'M', 4, 9, 115, '7987', '38.455.843-4', '1990-04-03');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (24, '552.560.821-91', 'Natlia Alice da Mota', 'F', 1, 2, 357, '692', '38.853.859-4', '1990-06-05');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (25, '858.016.055-33', 'Enzo Francisco Mrcio Lopes', 'M', 2, 9, 122, '33999', '20.835.201-6', '1990-01-01');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (26, '659.853.163-27', 'Marcos Matheus Arago', 'M', 3, 9, 403, '3', '47.222.158-9', '1990-04-16');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (27, '743.905.141-64', 'Pietro Geraldo Galvo', 'M', 4, 1, 159, '94', '26.868.552-6', '1990-01-12');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (28, '124.774.625-98', 'Caleb Luan Nogueira', 'M', 3, 9, 98, '28', '43.481.375-8', '1990-04-09');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (29, '168.577.443-19', 'Lara Renata Bernardes', 'F', 3, 9, 360, '5785', '42.569.816-6', '1990-03-09');
insert into pesquisador (idPsqdr, numCpfPsqdr, nomPsqdr, indSexPsqdr, indGrauPsqdr, idInsto, idLogr, numLogrPsqdr, numRGPsqdr, datNascpsqdr) values (30, '044.410.453-44', 'Patrcia Lorena Moreira', 'F', 2, 4, 196, '8159', '50.845.368-9', '1990-03-11');

insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (1, '49.486.357-2', '180.031.565-13', 'F', '1948-04-09', 1, 5, 260, 770, 'Isadora Mariah Rafaela Gomes');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (2, '27.598.035-2', '815.541.831-62', 'M', '1947-06-10', 3, 1, 389, 984, 'Guilherme Manuel Juan Barros');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (3, '17.094.231-4', '232.607.471-84', 'M', '1970-01-24', 2, 9, 179, 189, 'Caleb João Assis');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (4, '22.867.137-1', '503.515.503-05', 'F', '1974-02-17', 2, 9, 342, 243, 'Lívia Andrea da Cunha');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (5, '13.984.870-8', '602.685.229-87', 'M', '1993-01-04', 2, 9, 438, 982, 'Heitor Leonardo Erick Rocha');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (6, '47.144.035-8', '483.043.126-11', 'F', '1963-05-04', 1, 3, 136, 698, 'Aline Mariah Mendes');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (7, '50.311.017-6', '766.534.614-67', 'M', '1952-03-12', 3, 1, 262, 291, 'Carlos Eduardo Márcio Benício da Mota');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (8, '42.472.235-5', '070.390.134-60', 'M', '1958-02-22', 1, 3, 441, 827, 'Renato José Galvão');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (9, '24.809.334-4', '280.718.536-31', 'M', '2002-02-13', 4, 4, 482, 754, 'Antonio Bernardo Corte Real');
insert into assessor (idAsses, numRgAsses, numCpfAsses, IndSexoAsses, datNascAsses, idcGrauAsses, idInsto, idLogr, numLogrAsses, nomAsses) values (10, '39.718.344-6', '764.970.905-17', 'M', '1979-02-24', 1, 2, 109, 821, 'Osvaldo Ricardo Sérgio Araújo');

insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (10202048, 'ALGEBRA ', 'Cálculos com números', 5);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (10202005, 'TEORIA DOS NÚMEROS ', 'Entender como os números se relacionam um com os outros', 3);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (10102043, 'LINGUAGEM FORMAIS E AUTÔMATOS', 'Processos de entendimento de máquinas', 2);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (30401020, 'ASTROFÍSICA ESTELAR', 'Comportamento das estrelas', 6);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (10201068, 'MOVIMENTO DA TERRA ', 'Conhecimento sobre transalção espacial', 3);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (30402026, 'ÓTICA', 'Trabalhos sobre a luz', 2);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (40404005, 'ELETROQUÍMICA ', 'Esforços sobre a energia elética aliada a química', 1);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (40402002, 'SISMOLOGIA', 'Entender os abalos sísmicos', 1);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (40403009, 'ANATOMIA ', 'Entender as estruturas do corpo humano', 4);
insert into area_pesquisa (idAreap, nomAreap, dscAreap, indRelevAreap) values (40602006, 'TOXICOLOGIA ', 'Entender as substâncias nocivas ao ser humano', 3);

insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (1, '80.788.685/0001-79', 'Ifes ', 'Ifes @gov.edu.br', 'Ifes ', 84589104733, 100, 96, 'Galpão 7');
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (2, '57.906.568/0001-61', 'Ufes', 'Ufes@gov.edu.br', 'Ufes', 49835684864, 210, 465, null);
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (3, '76.836.165/0001-21', 'Ifam', 'Ifam@gov.edu.br', 'Ifam', 77401384970, 29, 29, null);
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (4, '95.496.601/0001-90', 'Ufam', 'Ufam@gov.edu.br', 'Ufam', 48615224125, 96, 210, 'Portão 1');
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (5, '74.690.247/0001-25', 'Ifse', 'Ifse@gov.edu.br', 'Ifse', 24012337617, 410, 100, null);
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (6, '26.605.926/0001-74', 'Ufse', 'Ufse@gov.edu.br', 'Ufse', 86831127429, 392, 410, 'Conjunto 7');
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (7, '52.265.775/0001-58', 'Ifsp', 'Ifsp@gov.edu.br', 'Ifsp', 56866728143, 465, 210, 'Bloco 7');
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (8, '73.740.422/0001-82', 'Ufsp', 'Ufsp@gov.edu.br', 'Ufsp', 16713915513, 112, 165, null);
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (9, '89.181.665/0001-70', 'Ifpi', 'Ifpi@gov.edu.br', 'Ifpi', 92681862045, 165, 386, 'Terreo 4');
insert into instituição (idInsto, numCnpjInsto, dscNFantInsto, dscEmailInsto, nomNcontInsto, numFoneInsto, idLogr, numLogrInsto, dscComplInsto) values (10, '16.920.551/0001-56', 'Ufpi', 'Ufpi@gov.edu.br', 'Ufpi', 83939673333, 386, 210, null);

insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (1, '2021-07-29', 'R', '2022-04-30', 'Muito dispendioso', 12, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (2, '2021-07-15', 'A', '2022-01-14', '', 26, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (3, '2021-07-23', 'A', '2022-03-07', '', 23, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (4, '2021-04-23', 'R', '2021-12-30', 'Falta de objetividade', 14, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (5, '2021-07-16', 'A', '2022-05-20', '', 15, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (6, '2021-06-06', 'A', '2022-05-20', '', 27, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (7, '2021-08-09', 'R', '2021-11-24', 'Potencial baixo', 15, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (8, '2021-07-27', 'R', '2022-02-23', 'Muito dispendioso', 6, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (9, '2021-06-05', 'R', '2021-12-05', 'Muito dispendioso', 10, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (10, '2021-08-29', 'R', '2022-06-03', 'Muito dispendioso', 11, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (11, '2021-08-22', 'R', '2022-03-01', 'Muito dispendioso', 20, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (12, '2021-08-28', 'A', '2021-12-12', '', 12, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (13, '2021-07-25', 'R', '2022-05-10', 'Falta de objetividade', 10, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (14, '2021-06-12', 'R', '2021-12-17', 'Assunto de pouco interesse', 25, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (15, '2021-05-12', 'R', '2022-02-13', 'Potencial baixo', 4, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (16, '2021-08-10', 'R', '2021-12-25', 'Muito dispendioso', 8, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (17, '2021-07-30', 'R', '2022-04-26', 'Potencial baixo', 24, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (18, '2021-08-05', 'A', '2022-04-04', '', 7, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (19, '2021-04-29', 'A', '2022-02-13', '', 10, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (20, '2021-08-23', 'R', '2022-03-05', 'Assunto de pouco interesse', 3, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (21, '2021-07-05', 'A', '2022-02-10', '', 28, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (22, '2021-04-06', 'R', '2022-04-14', 'Baixa prioridade', 24, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (23, '2021-05-27', 'R', '2021-12-13', 'Muito dispendioso', 28, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (24, '2021-05-02', 'A', '2022-01-19', '', 4, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (25, '2021-07-27', 'A', '2022-02-21', '', 28, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (26, '2021-06-06', 'R', '2022-03-28', 'Falta de objetividade', 2, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (27, '2021-08-12', 'A', '2022-04-02', '', 27, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (28, '2021-07-05', 'A', '2022-06-07', '', 22, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (29, '2021-08-23', 'R', '2022-04-14', 'Assunto de pouco interesse', 14, 1);
insert into result_avaliacao (idRsult, datEnvioRsult, indRespRsult, datRespRsult, dscJustRsult, idProj, idAsses) values (30, '2021-04-12', 'R', '2022-04-11', 'Assunto de pouco interesse', 16, 1);

insert into assessor_area (idAssar, idAreap, idAsses) values (1, 10102043, 8);
insert into assessor_area (idAssar, idAreap, idAsses) values (2, 40403009, 2);
insert into assessor_area (idAssar, idAreap, idAsses) values (3, 40403009, 5);
insert into assessor_area (idAssar, idAreap, idAsses) values (4, 40402002, 2);
insert into assessor_area (idAssar, idAreap, idAsses) values (5, 40402002, 3);
insert into assessor_area (idAssar, idAreap, idAsses) values (6, 40403009, 1);
insert into assessor_area (idAssar, idAreap, idAsses) values (7, 10201068, 6);
insert into assessor_area (idAssar, idAreap, idAsses) values (8, 10201068, 4);
insert into assessor_area (idAssar, idAreap, idAsses) values (9, 30402026, 9);
insert into assessor_area (idAssar, idAreap, idAsses) values (10, 30402026, 2);
insert into assessor_area (idAssar, idAreap, idAsses) values (11, 40602006, 4);
insert into assessor_area (idAssar, idAreap, idAsses) values (12, 40402002, 10);
insert into assessor_area (idAssar, idAreap, idAsses) values (13, 10102043, 1);
insert into assessor_area (idAssar, idAreap, idAsses) values (14, 40404005, 6);
insert into assessor_area (idAssar, idAreap, idAsses) values (15, 40403009, 4);
insert into assessor_area (idAssar, idAreap, idAsses) values (16, 30402026, 8);
insert into assessor_area (idAssar, idAreap, idAsses) values (17, 10201068, 9);
insert into assessor_area (idAssar, idAreap, idAsses) values (18, 40403009, 6);
insert into assessor_area (idAssar, idAreap, idAsses) values (19, 10202005, 5);
insert into assessor_area (idAssar, idAreap, idAsses) values (20, 40404005, 9);
insert into assessor_area (idAssar, idAreap, idAsses) values (21, 40403009, 5);
insert into assessor_area (idAssar, idAreap, idAsses) values (22, 10202048, 9);
insert into assessor_area (idAssar, idAreap, idAsses) values (23, 40402002, 2);
insert into assessor_area (idAssar, idAreap, idAsses) values (24, 10201068, 7);
insert into assessor_area (idAssar, idAreap, idAsses) values (25, 10201068, 3);
insert into assessor_area (idAssar, idAreap, idAsses) values (26, '30401020', 5);

insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (1, 15, 21);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (2, 3, 18);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (3, 4, 15);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (4, 25, 27);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (5, 25, 11);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (6, 6, 16);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (7, 21, 26);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (8, 3, 8);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (9, 10, 10);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (10, 10, 23);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (11, 15, 1);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (12, 21, 19);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (13, 5, 23);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (14, 2, 27);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (15, 9, 23);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (16, 23, 11);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (17, 8, 10);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (18, 2, 27);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (19, 22, 19);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (20, 26, 20);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (21, 25, 29);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (22, 6, 13);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (23, 14, 11);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (24, 30, 10);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (25, 29, 26);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (26, 4, 21);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (27, 14, 12);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (28, 12, 22);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (29, 15, 6);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (30, 8, 17);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (31, 20, 6);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (32, 24, 12);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (33, 30, 28);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (34, 9, 9);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (35, 3, 25);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (36, 10, 21);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (37, 28, 6);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (38, 3, 15);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (39, 16, 23);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (40, 19, 24);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (41, 22, 18);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (42, 20, 22);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (43, 16, 8);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (44, 30, 14);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (45, 22, 4);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (46, 21, 26);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (47, 1, 1);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (48, 1, 11);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (49, 19, 18);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (50, 9, 5);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (51, 1, 28);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (52, 3, 8);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (53, 3, 28);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (54, 8, 17);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (55, 9, 14);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (56, 28, 26);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (57, 3, 9);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (58, 22, 8);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (59, 17, 9);
insert into pesquisador_projeto (idPsqpr, idProj, idPsqdr) values (60, 3, 11);



UPDATE result_avaliacao re
SET re.idAsses = (SELECT assa.idAsses
			FROM assessor_area assa
            WHERE assa.idAreap = (SELECT proj.idAreap FROM projeto proj WHERE re.idProj = proj.idProj)
            order by rand()
            LIMIT 1);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
