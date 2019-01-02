Use test;

DROP TABLE IF EXISTS part;

CREATE TABLE part (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(255) NOT NULL,
  `NECESSARY` BIT(1) NOT NULL,
  `COUNT` INT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

INSERT INTO part (`NAME`,`NECESSARY`,`COUNT`)
    VALUES 
    ("материнская плата", 1, 3),
    ("звуковая карта ", 0, 2),
    ("процессор", 1, 2),
    ("подсветка корпуса", 0, 0),
    ("HDD диск", 0, 1),
    ("корпус", 1, 10),
    ("память", 1, 10),
    ("SSD диск", 1, 15),
    ("видеокарта", 0, 7),
    ("блок питания", 1, 12),
    ("мышка", 1, 20),
    ("коврик для мышки", 0, 20),
    ("клавиатура", 1, 5),
    ("USB-flash", 0, 22),
    ("монитор", 1, 12),
    ("колонки", 0, 5),
	  ("наушники", 0, 10),
    ("микрофон", 0, 1),
    ("принтер", 0, 6),
    ("сканер", 0, 2),
    ("веб-камера", 0, 5),
    ("сетевая карта", 1, 7),
    ("роутер", 0, 5)
    
;