drop table alerm;
drop table comment;
drop table hashtag;
drop table like_siren;
drop table relationship;
drop table board;
drop table member;
CREATE TABLE `dailygram`.`member` (
  `id` VARCHAR(30) NOT NULL,
  `board_seq` INT NOT NULL,
  `pwd` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NULL,
  `birthday` DATE NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `gendar` INT NOT NULL,
  `joindate` DATE NOT NULL,
  `useyn` INT NOT NULL,
  `profile_img` VARCHAR(500) NULL,
  `publicyn` INT NOT NULL,
  PRIMARY KEY (`id`, `board_seq`));
CREATE TABLE `dailygram`.`board` (
  `board_seq` INT NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `content` LONGTEXT NULL,
  `posted` VARCHAR(45) NOT NULL,
  `sender` VARCHAR(30) NULL,
  `img1` VARCHAR(500) NOT NULL,
  `img2` VARCHAR(500) NULL,
  `img3` VARCHAR(500) NULL,
  `img4` VARCHAR(500) NULL,
  `img5` VARCHAR(500) NULL,
  PRIMARY KEY (`board_seq`),
  INDEX `writer_idx` (`writer` ASC),
  CONSTRAINT `writer`
    FOREIGN KEY (`writer`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
ALTER TABLE `dailygram`.`board` 
CHANGE COLUMN `board_seq` `board_seq` INT(11) NOT NULL AUTO_INCREMENT ;
CREATE TABLE `dailygram`.`relationship` (
  `sender` VARCHAR(30) NOT NULL,
  `receiver` VARCHAR(30) NOT NULL,
  `board_seq` INT NOT NULL AUTO_INCREMENT,
  `status` INT NOT NULL,
  PRIMARY KEY (`sender`, `receiver`, `board_seq`),
  INDEX `receiver_idx` (`receiver` ASC),
  INDEX `board_seq_idx` (`board_seq` ASC),
  CONSTRAINT `sender`
    FOREIGN KEY (`sender`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `receiver`
    FOREIGN KEY (`receiver`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `board_seq`
    FOREIGN KEY (`board_seq`)
    REFERENCES `dailygram`.`board` (`board_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `dailygram`.`hashtag` (
  `board_seq` INT NOT NULL AUTO_INCREMENT,
  `tagname` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`board_seq`),
  CONSTRAINT `hastTag_board_seq`
    FOREIGN KEY (`board_seq`)
    REFERENCES `dailygram`.`board` (`board_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `dailygram`.`like_siren` (
  `board_seq` INT NOT NULL,
  `sender` VARCHAR(30) NOT NULL,
  `type` INT NOT NULL,
  PRIMARY KEY (`board_seq`, `sender`),
  INDEX `sender_idx` (`sender` ASC),
  CONSTRAINT `like_siren_board_seq`
    FOREIGN KEY (`board_seq`)
    REFERENCES `dailygram`.`board` (`board_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `like_siren_sender`
    FOREIGN KEY (`sender`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `dailygram`.`alerm` (
  `date` DATE NOT NULL,
  `sender` VARCHAR(30) NOT NULL,
  `receiver` VARCHAR(30) NOT NULL,
  `board_seq` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`date`, `sender`),
  INDEX `alerm_sender_idx` (`sender` ASC),
  INDEX `alerm_receiver_idx` (`receiver` ASC),
  INDEX `alerm_board_seq_idx` (`board_seq` ASC),
  CONSTRAINT `alerm_sender`
    FOREIGN KEY (`sender`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alerm_receiver`
    FOREIGN KEY (`receiver`)
    REFERENCES `dailygram`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alerm_board_seq`
    FOREIGN KEY (`board_seq`)
    REFERENCES `dailygram`.`board` (`board_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `dailygram`.`comment` (
  `board_seq` INT NOT NULL AUTO_INCREMENT,
  `com_seq` INT NOT NULL,
  `parent_seq` INT NOT NULL,
  `writer` VARCHAR(30) NOT NULL,
  `content` VARCHAR(200) NOT NULL,
  `posted` DATE NOT NULL,
  PRIMARY KEY (`board_seq`, `com_seq`),
  CONSTRAINT `comment_board_seq`
    FOREIGN KEY (`board_seq`)
    REFERENCES `dailygram`.`board` (`board_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
commit;