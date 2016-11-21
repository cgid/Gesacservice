-- MySQL Script generated by MySQL Workbench
-- 08/01/16 15:03:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SisCentralRel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SisCentralRel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SisCentralRel` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `SisCentralRel` ;

-- -----------------------------------------------------
-- Table `SisCentralRel`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Perfil` (
  `id_perfil` INT NOT NULL AUTO_INCREMENT,
  `descricao_perfil` VARCHAR(100) NOT NULL,
  `realizar_chamado` BOOLEAN NOT NULL,
  `gerenciar_usuarios` BOOLEAN NOT NULL,
  `gerenciar_servicos` BOOLEAN NOT NULL,
  PRIMARY KEY (`id_perfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `Perfil_cod_perfil` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_Usuario_Perfil_idx` (`Perfil_cod_perfil` ASC),
  CONSTRAINT `fk_Usuario_Perfil`
    FOREIGN KEY (`Perfil_cod_perfil`)
    REFERENCES `SisCentralRel`.`Perfil` (`id_perfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Servico` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `dt_criacao_servico` DATETIME NOT NULL,
  `descricao` VARCHAR(300) NOT NULL,
  `Dt_encerramento` DATETIME NULL,
  `Intervalo_ligacoes` INT NULL,
  `Usuario_cod_usuario` INT NOT NULL,
  PRIMARY KEY (`id_servico`),
  INDEX `fk_Servico_Usuario1_idx` (`Usuario_cod_usuario` ASC),
  CONSTRAINT `fk_Servico_Usuario1`
    FOREIGN KEY (`Usuario_cod_usuario`)
    REFERENCES `SisCentralRel`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`PID`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`PID` (
  `cod_pid` INT NOT NULL,
  `cod_gesac` INT NULL,
  `cod_tc` INT NULL,
  `cod_cd` INT NULL,
  `nome_estabelecimento` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_pid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Solicitacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Solicitacoes` (
  `id_solicitacao` INT NOT NULL AUTO_INCREMENT,
  `Qtde_tentativas` INT NULL,
  `Dt_ult_tentativa` DATETIME NOT NULL,
  `em_chamado` TINYINT(1) NULL,
  `contato_ok` TINYINT(1) NULL,
  `Servico_cod_servico` INT NOT NULL,
  `PID_cod_pid` INT NOT NULL,
  PRIMARY KEY (`id_solicitacao`, `Servico_cod_servico`, `PID_cod_pid`),
  INDEX `fk_Solicitacoes_Servico1_idx` (`Servico_cod_servico` ASC),
  INDEX `fk_Solicitacoes_PID1_idx` (`PID_cod_pid` ASC),
  CONSTRAINT `fk_Solicitacoes_Servico1`
    FOREIGN KEY (`Servico_cod_servico`)
    REFERENCES `SisCentralRel`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitacoes_PID1`
    FOREIGN KEY (`PID_cod_pid`)
    REFERENCES `SisCentralRel`.`PID` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`chamado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`chamado` (
  `id_chamado` INT NOT NULL AUTO_INCREMENT,
  `dt_chamado` DATETIME NOT NULL,
  `observacao` VARCHAR(500) NULL,
  `Usuario_cod_usuario` INT NOT NULL,
  `Solicitacoes_id_solicitacao` INT NOT NULL,
  PRIMARY KEY (`id_chamado`),
  INDEX `fk_chamado_Usuario1_idx` (`Usuario_cod_usuario` ASC),
  INDEX `fk_chamado_Solicitacoes1_idx` (`Solicitacoes_id_solicitacao` ASC),
  CONSTRAINT `fk_chamado_Usuario1`
    FOREIGN KEY (`Usuario_cod_usuario`)
    REFERENCES `SisCentralRel`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chamado_Solicitacoes1`
    FOREIGN KEY (`Solicitacoes_id_solicitacao`)
    REFERENCES `SisCentralRel`.`Solicitacoes` (`id_solicitacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Municipio` (
  `cod_IBGE` INT NOT NULL,
  `nome_municipio` VARCHAR(100) NULL,
  `UF` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_IBGE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NULL,
  `numero` VARCHAR(100) NULL,
  `bairro` VARCHAR(100) NULL,
  `cep` VARCHAR(100) NULL,
  `complemento` VARCHAR(100) NULL,
  `Municipio_cod_IBGE` INT NOT NULL,
  `PID_cod_pid` INT NOT NULL,
  `valido` TINYINT(1) NULL,
  `dt_atualizacao` DATETIME NULL,
  PRIMARY KEY (`id_endereco`, `Municipio_cod_IBGE`, `PID_cod_pid`),
  INDEX `fk_Endereco_Municipio1_idx` (`Municipio_cod_IBGE` ASC),
  INDEX `fk_Endereco_PID1_idx` (`PID_cod_pid` ASC),
  CONSTRAINT `fk_Endereco_Municipio1`
    FOREIGN KEY (`Municipio_cod_IBGE`)
    REFERENCES `SisCentralRel`.`Municipio` (`cod_IBGE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_PID1`
    FOREIGN KEY (`PID_cod_pid`)
    REFERENCES `SisCentralRel`.`PID` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Contato` (
  `id_contato` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `PID_cod_pid` INT NOT NULL,
  PRIMARY KEY (`id_contato`, `PID_cod_pid`),
  INDEX `fk_Contato_PID1_idx` (`PID_cod_pid` ASC),
  CONSTRAINT `fk_Contato_PID1`
    FOREIGN KEY (`PID_cod_pid`)
    REFERENCES `SisCentralRel`.`PID` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Telefone` (
  `id_telefone` INT NOT NULL AUTO_INCREMENT,
  `ddd` INT NOT NULL,
  `telefone` INT NOT NULL,
  `Contato_id_contato` INT NOT NULL,
  PRIMARY KEY (`id_telefone`),
  INDEX `fk_Telefone_Contato1_idx` (`Contato_id_contato` ASC),
  CONSTRAINT `fk_Telefone_Contato1`
    FOREIGN KEY (`Contato_id_contato`)
    REFERENCES `SisCentralRel`.`Contato` (`id_contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Perguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Perguntas` (
  `id_Perguntas` INT NOT NULL AUTO_INCREMENT,
  `pergunta` VARCHAR(300) NULL,
  `Servico_cod_servico` INT NOT NULL,
  PRIMARY KEY (`id_Perguntas`),
  INDEX `fk_Perguntas_Servico1_idx` (`Servico_cod_servico` ASC),
  CONSTRAINT `fk_Perguntas_Servico1`
    FOREIGN KEY (`Servico_cod_servico`)
    REFERENCES `SisCentralRel`.`Servico` (`id_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Respostas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Respostas` (
  `id_Respostas` INT NOT NULL AUTO_INCREMENT,
  `Resposta` VARCHAR(1000) NULL,
  `chamado_cod_chamado` INT NOT NULL,
  PRIMARY KEY (`id_Respostas`),
  INDEX `fk_Respostas_chamado1_idx` (`chamado_cod_chamado` ASC),
  CONSTRAINT `fk_Respostas_chamado1`
    FOREIGN KEY (`chamado_cod_chamado`)
    REFERENCES `SisCentralRel`.`chamado` (`id_chamado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SisCentralRel`.`Endereco_novo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SisCentralRel`.`Endereco_novo` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NULL,
  `numero` VARCHAR(100) NULL,
  `bairro` VARCHAR(100) NULL,
  `cep` VARCHAR(100) NULL,
  `complemento` VARCHAR(100) NULL,
  `Municipio_cod_IBGE` INT NOT NULL,
  `PID_cod_pid` INT NOT NULL,
  `valido` TINYINT(1) NULL,
  PRIMARY KEY (`id_endereco`, `Municipio_cod_IBGE`, `PID_cod_pid`),
  INDEX `fk_Endereco_novo_Municipio1_idx` (`Municipio_cod_IBGE` ASC),
  INDEX `fk_Endereco_novo_PID1_idx` (`PID_cod_pid` ASC),
  CONSTRAINT `fk_Endereco_novo_Municipio1`
    FOREIGN KEY (`Municipio_cod_IBGE`)
    REFERENCES `SisCentralRel`.`Municipio` (`cod_IBGE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_novo_PID1`
    FOREIGN KEY (`PID_cod_pid`)
    REFERENCES `SisCentralRel`.`PID` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
