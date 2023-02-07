-- Smart Production Linie mit 4 Maschinen
DROP DATABASE MES;

CREATE DATABASE IF NOT EXISTS MES;

CREATE TABLE IF NOT EXISTS MES.MACHINES (
    MACHINE_ID SMALLINT(5) UNSIGNED NOT NULL,
    NAME VARCHAR(45) NOT NULL,
    NAME_PARA1 VARCHAR(45),
    NAME_PARA2 VARCHAR(45),
    PRIMARY KEY (MACHINE_ID)
);

CREATE TABLE IF NOT EXISTS MES.VARIANTS (
    VARIANT_ID SMALLINT(5) UNSIGNED NOT NULL,
    NAME VARCHAR(45) NOT NULL,
    PRIMARY KEY (VARIANT_ID)
);

CREATE TABLE IF NOT EXISTS MES.PRODUCTION_STEPS (
    PRODUCTION_STEP_ID SMALLINT(5) UNSIGNED NOT NULL,
    STEP_NO SMALLINT(5) UNSIGNED NOT NULL,
    VARIANT_ID SMALLINT(5) UNSIGNED NOT NULL,
    MACHINE_ID SMALLINT(5) UNSIGNED NOT NULL,
    PARA1 SMALLINT(5),
    PARA2 SMALLINT(5),
    PRIMARY KEY (PRODUCTION_STEP_ID)
);

CREATE TABLE IF NOT EXISTS MES.PRODUCTS (
    PRODUCT_ID SMALLINT(5) UNSIGNED NOT NULL,
    NAME VARCHAR(45) NOT NULL,
    PRIMARY KEY (PRODUCT_ID)
);

CREATE TABLE IF NOT EXISTS MES.COLORS (
    COLOR_ID SMALLINT(5) UNSIGNED NOT NULL,
    WEB_COLOR VARCHAR(7) NOT NULL,
    NAME VARCHAR(45) NOT NULL,
    PRIMARY KEY (COLOR_ID)
);

CREATE TABLE IF NOT EXISTS MES.CUSTOMERS (
    CUSTOMER_ID SMALLINT(5) UNSIGNED NOT NULL,
    NAME VARCHAR(45) NOT NULL,
    CONTACT VARCHAR(45) NOT NULL,
    STREET VARCHAR(45) NOT NULL,
    ZIP VARCHAR(45) NOT NULL,
    CITY VARCHAR(45) NOT NULL,
    PRIMARY KEY (CUSTOMER_ID)
);

CREATE TABLE IF NOT EXISTS MES.PARTS (
    PART_ID SMALLINT(5) UNSIGNED NOT NULL,
    RFID SMALLINT(5),
    COLOR_ID SMALLINT(5) UNSIGNED NOT NULL,
    PART_STATE SMALLINT(5),
    PRIMARY KEY (PART_ID)
);

CREATE TABLE IF NOT EXISTS MES.STOCKYARDS (
    STOCKYARD_ID SMALLINT(5) UNSIGNED NOT NULL,
    PART_ID SMALLINT(5),
    PRIMARY KEY (STOCKYARD_ID)
);

CREATE TABLE IF NOT EXISTS MES.ORDERS (
    ORDER_ID SMALLINT(5) UNSIGNED NOT NULL,
    PRODUCT_ID SMALLINT(5) UNSIGNED NOT NULL,
    COLOR_ID  SMALLINT(5) UNSIGNED NOT NULL,
    VARIANT_ID SMALLINT(5) UNSIGNED NOT NULL,
    CUSTOMER_ID SMALLINT(5) UNSIGNED NOT NULL,
    ORDER_STATE SMALLINT(5),
    PART_ID SMALLINT(5) UNSIGNED,
    PRIMARY KEY (ORDER_ID)
);

CREATE TABLE IF NOT EXISTS MES.PROD_DATA (
    LOG_TIME TIMESTAMP NOT NULL,
    LOG_TYPE SMALLINT(5),
    RFID SMALLINT(5),
    MACHINE SMALLINT(5),
    DURATION BIGINT UNSIGNED,
    MESSAGE VARCHAR(160) NOT NULL
);

INSERT INTO MES.MACHINES (MACHINE_ID, NAME, NAME_PARA1, NAME_PARA2) VALUES (1, 'Lager', 'Lagerplatz', '');
INSERT INTO MES.MACHINES (MACHINE_ID, NAME, NAME_PARA1, NAME_PARA2) VALUES (2, 'Bohrer', 'Bohrtiefe', '');
INSERT INTO MES.MACHINES (MACHINE_ID, NAME, NAME_PARA1, NAME_PARA2) VALUES (3, 'Schrauber', 'Schraube', '');
INSERT INTO MES.MACHINES (MACHINE_ID, NAME, NAME_PARA1, NAME_PARA2) VALUES (4, 'Presse', 'Tischfuss', '');

INSERT INTO MES.COLORS (COLOR_ID, WEB_COLOR, NAME) VALUES (1, '#515A5A', 'steingrau');
INSERT INTO MES.COLORS (COLOR_ID, WEB_COLOR, NAME) VALUES (2, '#FFFFFF', 'weiss');
INSERT INTO MES.COLORS (COLOR_ID, WEB_COLOR, NAME) VALUES (3, '#FBEEC1', 'buche');

INSERT INTO MES.PARTS (PART_ID, RFID, COLOR_ID, PART_STATE) VALUES (1, 51, 1, 0);
INSERT INTO MES.PARTS (PART_ID, RFID, COLOR_ID, PART_STATE) VALUES (2, 52, 2, 0);
INSERT INTO MES.PARTS (PART_ID, RFID, COLOR_ID, PART_STATE) VALUES (3, 53, 3, 0);
INSERT INTO MES.PARTS (PART_ID, RFID, COLOR_ID, PART_STATE) VALUES (4, 54, 3, 0);
INSERT INTO MES.PARTS (PART_ID, RFID, COLOR_ID, PART_STATE) VALUES (5, 55, 3, 0);

INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (1, 1);
INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (2, 2);
INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (3, 0);
INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (4, 3);
INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (5, 0);
INSERT INTO MES.STOCKYARDS (STOCKYARD_ID, PART_ID) VALUES (6, 0);

INSERT INTO MES.PRODUCTS (PRODUCT_ID, NAME) VALUES (1, 'Tisch 501 System 24');

INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (1, 'Orlendo GmbH','Frau Meyer','Wollenweberstr. 70','31134','Hildesheim');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (2, 'Office AG','Herr Schmidt','Esterholzer Straße 71','29525','Uelzen');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (3, 'Werner KG','Frau Baumann','Mühlenstraße 20','31785','Hameln');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (4, 'Kunter GmbH','Herr Opalinski','Am Schwalbenberg 25','21337','Lüneburg');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (5, 'Bowl OHG','Frau Kunze','Lavesallee 20','30169','Hannover');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (6, 'Alensen GmbH','Herr Laurisch','Joh.-Seb.-Bach.Str. 20','38226','Salzgitter');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (7, 'Desk KG','Frau Vollbrecht','Weender Landstr. 5','37073','Göttingen');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (8, 'Klausen AG','Frau Yilkiran','Glückstädter Str. 20','21682','Stade');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (9, 'Arzu GmbH','Herr Kirez','Hüttenstraße 35','31655','Stadthagen');
INSERT INTO MES.CUSTOMERS (CUSTOMER_ID, NAME, CONTACT, STREET, ZIP, CITY) VALUES (10,'Jansen OHG','Frau Ostermann','Bebelstraße 45','21614','Buxtehude');

INSERT INTO MES.VARIANTS (VARIANT_ID, NAME) VALUES (1, 'mit verchromten Beinen');
INSERT INTO MES.VARIANTS (VARIANT_ID, NAME) VALUES (2, 'mit schwarzen Beinen');

INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (1, 1, 1, 1, NULL, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (2, 2, 1, 2, 14, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (3, 3, 1, 3, 1, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (4, 4, 1, 4, 1, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (5, 5, 1, 1, NULL, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (6, 1, 2, 1, NULL, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (7, 2, 2, 2, 10, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (8, 3, 2, 3, 2, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (9, 4, 2, 4, 2, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (10, 5, 2, 1, NULL, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (11, 1, 3, 1, NULL, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (12, 2, 3, 2, 14, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (13, 3, 3, 3, 3, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (14, 4, 3, 4, 1, NULL);
INSERT INTO MES.PRODUCTION_STEPS (PRODUCTION_STEP_ID, STEP_NO, VARIANT_ID, MACHINE_ID, PARA1, PARA2) VALUES (15, 5, 3, 1, NULL, NULL);


