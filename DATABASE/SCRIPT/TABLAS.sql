/*
drop table ACEG_CARNICERIA cascade constraints;
drop table ACEG_CARNICERIA_CLIENTE cascade constraints;
drop table ACEG_CARNICERIA_PROD_CARN cascade constraints;
drop table ACEG_CARNICERIA_PROVEEDOR cascade constraints;
drop table ACEG_CARNICERO cascade constraints;
drop table ACEG_CLIENTE cascade constraints;
drop table ACEG_ESTADO cascade constraints;
drop table ACEG_MUNICIPIO cascade constraints;
drop table ACEG_NOTA_ADEUDADA cascade constraints;
drop table ACEG_NOTA_PAGADA cascade constraints;
drop table ACEG_PEDIDO cascade constraints;
drop table ACEG_PROD_ADE_CLIENTE cascade constraints;
drop table ACEG_PROD_CAR_PROD_ADE_CLI cascade constraints;
drop table ACEG_PROD_CARN_PEDIDO cascade constraints;
drop table ACEG_PROD_CARNICERIA cascade constraints;
drop table ACEG_PROD_PROV_NOTA_ADE cascade constraints;
drop table ACEG_PROD_PROV_NOTA_PAGADA cascade constraints;
drop table ACEG_PROD_PROVEEDOR cascade constraints;
drop table ACEG_PROV_PROD_PROV cascade constraints;
drop table ACEG_PROVEEDOR cascade constraints;

DROP SEQUENCE ACEG_CARNICERIA_SEQ;
DROP SEQUENCE ACEG_PEDIDO_SEQ;
DROP SEQUENCE ACEG_NOTA_ADEUDADA_SEQ;
DROP SEQUENCE ACEG_NOTA_PAGADA_SEQ;
DROP SEQUENCE ACEG_ESTADO_SEQ;
DROP SEQUENCE ACEG_CARNICERO_SEQ;
DROP SEQUENCE ACEG_CLIENTE_SEQ;
DROP SEQUENCE ACEG_MUNICIPIO_SEQ;
DROP SEQUENCE ACEG_PROD_CARNICERIA_SEQ;
DROP SEQUENCE ACEG_PROD_PROVEEDOR_SEQ;
DROP SEQUENCE ACEG_PROD_ADE_CLIENTE_SEQ;
DROP SEQUENCE ACEG_PROVEEDOR_SEQ;
*/

-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2020-08-26 18:27:50 CDT
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c
-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE


CREATE TABLE aceg_carniceria (
    id_carniceria_pk   NUMBER NOT NULL,
    nombre             VARCHAR2(100) NOT NULL,
    direccion          VARCHAR2(100),
    cp                 VARCHAR2(5),
    telefono           CHAR(10),
    descripcion        VARCHAR2(100),
    id_estado_fk       NUMBER NOT NULL
);

ALTER TABLE aceg_carniceria ADD CONSTRAINT carniceria_pk PRIMARY KEY ( id_carniceria_pk );

CREATE TABLE aceg_carniceria_cliente (
    id_cliente_fk      NUMBER NOT NULL,
    id_carniceria_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_carniceria_cliente ADD CONSTRAINT carniceria_cliente_pk PRIMARY KEY ( id_cliente_fk,
                                                                                       id_carniceria_fk );

CREATE TABLE aceg_carniceria_prod_carn (
    id_carniceria_fk   NUMBER NOT NULL,
    id_producto_fk     NUMBER NOT NULL
);

ALTER TABLE aceg_carniceria_prod_carn ADD CONSTRAINT carniceria_prod_carn_pk PRIMARY KEY ( id_carniceria_fk,
                                                                                           id_producto_fk );

CREATE TABLE aceg_carniceria_proveedor (
    id_proveedor_fk    NUMBER NOT NULL,
    id_carniceria_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_carniceria_proveedor ADD CONSTRAINT aceg_carniceria_proveedor_pk PRIMARY KEY ( id_proveedor_fk,
                                                                                                id_carniceria_fk );

CREATE TABLE aceg_carnicero (
    id_carnicero_pk    NUMBER NOT NULL,
    nombre             VARCHAR2(30) NOT NULL,
    apellido           VARCHAR2(50),
    genero             CHAR(1),
    email              VARCHAR2(30),
    telefono           CHAR(10) NOT NULL,
    direccion          VARCHAR2(100),
    cp                 CHAR(5),
    sueldo_mensual     NUMBER(7, 2) NOT NULL,
    id_carniceria_fk   NUMBER NOT NULL,
    id_estado_fk       NUMBER NOT NULL
);

ALTER TABLE aceg_carnicero ADD CONSTRAINT carnicero_pk PRIMARY KEY ( id_carnicero_pk,
                                                                     id_carniceria_fk );

CREATE TABLE aceg_cliente (
    id_cliente_pk   NUMBER NOT NULL,
    nombre          VARCHAR2(30) NOT NULL,
    apellido        VARCHAR2(50),
    genero          CHAR(1),
    email           VARCHAR2(30),
    telefono        CHAR(10),
    direccion       VARCHAR2(100),
    cp              CHAR(5),
    id_estado_fk    NUMBER NOT NULL
);

ALTER TABLE aceg_cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente_pk );

CREATE TABLE aceg_estado (
    id_estado_pk   NUMBER NOT NULL,
    estado         VARCHAR2(50) NOT NULL,
    abreviacion    CHAR(3)
);

ALTER TABLE aceg_estado ADD CONSTRAINT estado_pk PRIMARY KEY ( id_estado_pk );

CREATE TABLE aceg_municipio (
    id_municipio_pk   NUMBER NOT NULL,
    municipio         VARCHAR2(50) NOT NULL,
    id_estado_fk      NUMBER NOT NULL
);

ALTER TABLE aceg_municipio ADD CONSTRAINT municipio_pk PRIMARY KEY ( id_municipio_pk );

CREATE TABLE aceg_nota_adeudada (
    id_nota_pk         NUMBER NOT NULL,
    id_nota_prov_pk    NUMBER NOT NULL,
    fecha_compra       DATE NOT NULL,
    peso_producto      VARCHAR2(10) NOT NULL,
    total              NUMBER(7, 2) NOT NULL,
    descripcion        VARCHAR2(100),
    id_carnicero_fk    NUMBER NOT NULL,
    id_carniceria_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_nota_adeudada ADD CONSTRAINT nota_adeudada_pk PRIMARY KEY ( id_nota_pk,
                                                                             id_nota_prov_pk );

CREATE TABLE aceg_nota_pagada (
    id_nota_pk          NUMBER NOT NULL,
    id_nota_prov_pk     NUMBER NOT NULL,
    fecha_compra_prod   DATE NOT NULL,
    fecha_pago_prod     DATE NOT NULL,
    peso_prod_kg        VARCHAR2(10) NOT NULL,
    total               NUMBER(7, 5) NOT NULL,
    descripcion         VARCHAR2(100),
    id_carnicero_fk     NUMBER NOT NULL,
    id_carniceria_fk    NUMBER NOT NULL
);

ALTER TABLE aceg_nota_pagada ADD CONSTRAINT nota_pagada_pk PRIMARY KEY ( id_nota_prov_pk,
                                                                         id_nota_pk );

CREATE TABLE aceg_pedido (
    id_pedido_pk       NUMBER NOT NULL,
    id_nota_pk         NUMBER NOT NULL,
    peso_total_kg      NUMBER(7, 2) NOT NULL,
    fecha_entrega      DATE NOT NULL,
    total              NUMBER(7, 2) NOT NULL,
    descripcion        VARCHAR2(100),
    id_carniceria_fk   NUMBER NOT NULL,
    id_cliente_fk      NUMBER NOT NULL
);

ALTER TABLE aceg_pedido
    ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido_pk,
                                           id_carniceria_fk,
                                           id_cliente_fk,
                                           id_nota_pk );

CREATE TABLE aceg_prod_ade_cliente (
    id_prod_ade_pk     NUMBER NOT NULL,
    fecha_compra       DATE NOT NULL,
    peso_producto_kg   NUMBER(7, 2) NOT NULL,
    total              NUMBER(7, 2) NOT NULL,
    descripcion        VARCHAR2(100),
    id_cliente_fk      NUMBER NOT NULL
);

ALTER TABLE aceg_prod_ade_cliente ADD CONSTRAINT prod_ade_cliente_pk PRIMARY KEY ( id_prod_ade_pk,
                                                                                   id_cliente_fk );

CREATE TABLE aceg_prod_car_prod_ade_cli (
    id_prod_ade_fk   NUMBER NOT NULL,
    id_cliente_fk    NUMBER NOT NULL,
    id_producto_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_prod_car_prod_ade_cli
    ADD CONSTRAINT prod_car_prod_ade_cli_pk PRIMARY KEY ( id_prod_ade_fk,
                                                          id_cliente_fk,
                                                          id_producto_fk );

CREATE TABLE aceg_prod_carn_pedido (
    id_producto_fk     NUMBER NOT NULL,
    id_pedido_fk       NUMBER NOT NULL,
    id_carniceria_fk   NUMBER NOT NULL,
    id_cliente_fk      NUMBER NOT NULL,
    id_nota_fk         NUMBER NOT NULL
);

ALTER TABLE aceg_prod_carn_pedido
    ADD CONSTRAINT prod_carn_pedido_pk PRIMARY KEY ( id_producto_fk,
                                                     id_pedido_fk,
                                                     id_carniceria_fk,
                                                     id_cliente_fk,
                                                     id_nota_fk );

CREATE TABLE aceg_prod_carniceria (
    id_producto_pk   NUMBER NOT NULL,
    producto         VARCHAR2(50) NOT NULL,
    precio_kg        NUMBER(7, 2) NOT NULL,
    tipo_carne       VARCHAR2(5) NOT NULL,
    descripcion      VARCHAR2(100)
);

ALTER TABLE aceg_prod_carniceria ADD CONSTRAINT prod_carniceria_pk PRIMARY KEY ( id_producto_pk );

CREATE TABLE aceg_prod_prov_nota_ade (
    id_nota_fk        NUMBER NOT NULL,
    id_nota_prov_fk   NUMBER NOT NULL,
    id_prod_prov_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_prod_prov_nota_ade
    ADD CONSTRAINT prod_prov_nota_ade_pk PRIMARY KEY ( id_nota_fk,
                                                       id_nota_prov_fk,
                                                       id_prod_prov_fk );

CREATE TABLE aceg_prod_prov_nota_pagada (
    id_nota_prov_fk   NUMBER NOT NULL,
    id_nota_fk        NUMBER NOT NULL,
    id_prod_prov_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_prod_prov_nota_pagada
    ADD CONSTRAINT prod_prov_nota_pagada_pk PRIMARY KEY ( id_nota_prov_fk,
                                                          id_nota_fk,
                                                          id_prod_prov_fk );

CREATE TABLE aceg_prod_proveedor (
    id_prod_prov_pk   NUMBER NOT NULL,
    producto          VARCHAR2(30) NOT NULL,
    precio_kg         NUMBER(7, 2) NOT NULL,
    tipo_carne        VARCHAR2(5) NOT NULL,
    descripcion       VARCHAR2(100)
);

ALTER TABLE aceg_prod_proveedor ADD CONSTRAINT prod_proveedor_pk PRIMARY KEY ( id_prod_prov_pk );

CREATE TABLE aceg_prov_prod_prov (
    id_proveedor_fk   NUMBER NOT NULL,
    id_prod_prov_fk   NUMBER NOT NULL
);

ALTER TABLE aceg_prov_prod_prov ADD CONSTRAINT prov_prod_prov_pk PRIMARY KEY ( id_proveedor_fk,
                                                                               id_prod_prov_fk );

CREATE TABLE aceg_proveedor (
    id_proveedor_pk    NUMBER NOT NULL,
    nombre_empresa     VARCHAR2(30),
    nombre_proveedor   VARCHAR2(30) NOT NULL,
    apellido           VARCHAR2(50),
    genero             CHAR(1),
    email              VARCHAR2(50),
    telefono           CHAR(10) NOT NULL,
    direccion          VARCHAR2(100),
    cp                 CHAR(5)
);

ALTER TABLE aceg_proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id_proveedor_pk );

ALTER TABLE aceg_carniceria_cliente
    ADD CONSTRAINT carn_cliente_carn_fk FOREIGN KEY ( id_carniceria_fk )
        REFERENCES aceg_carniceria ( id_carniceria_pk );

ALTER TABLE aceg_carniceria_prod_carn
    ADD CONSTRAINT carn_prod_carn_prod_carn_fk FOREIGN KEY ( id_producto_fk )
        REFERENCES aceg_prod_carniceria ( id_producto_pk );

ALTER TABLE aceg_carniceria_proveedor
    ADD CONSTRAINT carn_proveedor_carni_fk FOREIGN KEY ( id_carniceria_fk )
        REFERENCES aceg_carniceria ( id_carniceria_pk );

ALTER TABLE aceg_carniceria_cliente
    ADD CONSTRAINT carni_cliente_cliente_fk FOREIGN KEY ( id_cliente_fk )
        REFERENCES aceg_cliente ( id_cliente_pk );

ALTER TABLE aceg_carniceria_prod_carn
    ADD CONSTRAINT carni_prod_carn_carni_fk FOREIGN KEY ( id_carniceria_fk )
        REFERENCES aceg_carniceria ( id_carniceria_pk );

ALTER TABLE aceg_carniceria
    ADD CONSTRAINT carniceria_estado_fk FOREIGN KEY ( id_estado_fk )
        REFERENCES aceg_estado ( id_estado_pk );

ALTER TABLE aceg_carniceria_proveedor
    ADD CONSTRAINT carniceria_prov_proveedor_fk FOREIGN KEY ( id_proveedor_fk )
        REFERENCES aceg_proveedor ( id_proveedor_pk );

ALTER TABLE aceg_carnicero
    ADD CONSTRAINT carnicero_carniceria_fk FOREIGN KEY ( id_carniceria_fk )
        REFERENCES aceg_carniceria ( id_carniceria_pk );

ALTER TABLE aceg_carnicero
    ADD CONSTRAINT carnicero_estado_fk FOREIGN KEY ( id_estado_fk )
        REFERENCES aceg_estado ( id_estado_pk );

ALTER TABLE aceg_cliente
    ADD CONSTRAINT cliente_estado_fk FOREIGN KEY ( id_estado_fk )
        REFERENCES aceg_estado ( id_estado_pk );

ALTER TABLE aceg_municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY ( id_estado_fk )
        REFERENCES aceg_estado ( id_estado_pk );

ALTER TABLE aceg_nota_adeudada
    ADD CONSTRAINT nota_adeudada_carnicero_fk FOREIGN KEY ( id_carnicero_fk,
                                                            id_carniceria_fk )
        REFERENCES aceg_carnicero ( id_carnicero_pk,
                                    id_carniceria_fk );

ALTER TABLE aceg_nota_pagada
    ADD CONSTRAINT nota_pagada_carnicero_fk FOREIGN KEY ( id_carnicero_fk,
                                                          id_carniceria_fk )
        REFERENCES aceg_carnicero ( id_carnicero_pk,
                                    id_carniceria_fk );

ALTER TABLE aceg_pedido
    ADD CONSTRAINT pedido_carniceria_fk FOREIGN KEY ( id_carniceria_fk )
        REFERENCES aceg_carniceria ( id_carniceria_pk );

ALTER TABLE aceg_pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( id_cliente_fk )
        REFERENCES aceg_cliente ( id_cliente_pk );

ALTER TABLE aceg_prod_car_prod_ade_cli
    ADD CONSTRAINT pro_car_pro_ade_cli_pro_car_fk FOREIGN KEY ( id_producto_fk )
        REFERENCES aceg_prod_carniceria ( id_producto_pk );

ALTER TABLE aceg_prod_ade_cliente
    ADD CONSTRAINT prod_ade_cliente_cliente_fk FOREIGN KEY ( id_cliente_fk )
        REFERENCES aceg_cliente ( id_cliente_pk );

ALTER TABLE aceg_prod_car_prod_ade_cli
    ADD CONSTRAINT prod_car_prod_ade_cli_fk FOREIGN KEY ( id_prod_ade_fk,
                                                          id_cliente_fk )
        REFERENCES aceg_prod_ade_cliente ( id_prod_ade_pk,
                                           id_cliente_fk );

ALTER TABLE aceg_prod_carn_pedido
    ADD CONSTRAINT prod_carn_pedido_pedido_fk FOREIGN KEY ( id_pedido_fk,
                                                            id_carniceria_fk,
                                                            id_cliente_fk,
                                                            id_nota_fk )
        REFERENCES aceg_pedido ( id_pedido_pk,
                                 id_carniceria_fk,
                                 id_cliente_fk,
                                 id_nota_pk );

ALTER TABLE aceg_prod_carn_pedido
    ADD CONSTRAINT prod_carn_pedido_prod_carn_fk FOREIGN KEY ( id_producto_fk )
        REFERENCES aceg_prod_carniceria ( id_producto_pk );

ALTER TABLE aceg_prod_prov_nota_pagada
    ADD CONSTRAINT prod_prov_not_pag_prod_prov_fk FOREIGN KEY ( id_prod_prov_fk )
        REFERENCES aceg_prod_proveedor ( id_prod_prov_pk );

ALTER TABLE aceg_prod_prov_nota_ade
    ADD CONSTRAINT prod_prov_nota_ade_nota_ade_fk FOREIGN KEY ( id_nota_fk,
                                                                id_nota_prov_fk )
        REFERENCES aceg_nota_adeudada ( id_nota_pk,
                                        id_nota_prov_pk );

ALTER TABLE aceg_prod_prov_nota_pagada
    ADD CONSTRAINT prod_prov_nota_pagada_fk FOREIGN KEY ( id_nota_prov_fk,
                                                          id_nota_fk )
        REFERENCES aceg_nota_pagada ( id_nota_prov_pk,
                                      id_nota_pk );

ALTER TABLE aceg_prod_prov_nota_ade
    ADD CONSTRAINT prod_prv_nota_ade_prod_prv_fk FOREIGN KEY ( id_prod_prov_fk )
        REFERENCES aceg_prod_proveedor ( id_prod_prov_pk );

ALTER TABLE aceg_prov_prod_prov
    ADD CONSTRAINT prov_prod_prov_prod_prove_fk FOREIGN KEY ( id_prod_prov_fk )
        REFERENCES aceg_prod_proveedor ( id_prod_prov_pk );

ALTER TABLE aceg_prov_prod_prov
    ADD CONSTRAINT prov_prod_prov_proveedor_fk FOREIGN KEY ( id_proveedor_fk )
        REFERENCES aceg_proveedor ( id_proveedor_pk );

CREATE SEQUENCE aceg_carniceria_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_carniceria_trig BEFORE
    INSERT ON aceg_carniceria
    FOR EACH ROW
    WHEN ( new.id_carniceria_pk IS NULL )
BEGIN
    :new.id_carniceria_pk := aceg_carniceria_seq.nextval;
END;
/

CREATE SEQUENCE aceg_carnicero_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_carnicero_trig BEFORE
    INSERT ON aceg_carnicero
    FOR EACH ROW
    WHEN ( new.id_carnicero_pk IS NULL )
BEGIN
    :new.id_carnicero_pk := aceg_carnicero_seq.nextval;
END;
/

CREATE SEQUENCE aceg_cliente_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_cliente_trig BEFORE
    INSERT ON aceg_cliente
    FOR EACH ROW
    WHEN ( new.id_cliente_pk IS NULL )
BEGIN
    :new.id_cliente_pk := aceg_cliente_seq.nextval;
END;
/

CREATE SEQUENCE aceg_estado_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999;

CREATE OR REPLACE TRIGGER aceg_estado_trig BEFORE
    INSERT ON aceg_estado
    FOR EACH ROW
    WHEN ( new.id_estado_pk IS NULL )
BEGIN
    :new.id_estado_pk := aceg_estado_seq.nextval;
END;
/

CREATE SEQUENCE aceg_municipio_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_municipio_trig BEFORE
    INSERT ON aceg_municipio
    FOR EACH ROW
    WHEN ( new.id_municipio_pk IS NULL )
BEGIN
    :new.id_municipio_pk := aceg_municipio_seq.nextval;
END;
/

CREATE SEQUENCE aceg_nota_adeudada_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_nota_adeudada_trig BEFORE
    INSERT ON aceg_nota_adeudada
    FOR EACH ROW
    WHEN ( new.id_nota_pk IS NULL )
BEGIN
    :new.id_nota_pk := aceg_nota_adeudada_seq.nextval;
END;
/

CREATE SEQUENCE aceg_nota_pagada_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_nota_pagada_trig BEFORE
    INSERT ON aceg_nota_pagada
    FOR EACH ROW
    WHEN ( new.id_nota_pk IS NULL )
BEGIN
    :new.id_nota_pk := aceg_nota_pagada_seq.nextval;
END;
/

CREATE SEQUENCE aceg_pedido_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20 ORDER;

CREATE OR REPLACE TRIGGER aceg_pedido_trig BEFORE
    INSERT ON aceg_pedido
    FOR EACH ROW
    WHEN ( new.id_pedido_pk IS NULL )
BEGIN
    :new.id_pedido_pk := aceg_pedido_seq.nextval;
END;
/

CREATE SEQUENCE aceg_prod_ade_cliente_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_prod_ade_cliente_trig BEFORE
    INSERT ON aceg_prod_ade_cliente
    FOR EACH ROW
    WHEN ( new.id_prod_ade_pk IS NULL )
BEGIN
    :new.id_prod_ade_pk := aceg_prod_ade_cliente_seq.nextval;
END;
/

CREATE SEQUENCE aceg_prod_carniceria_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_prod_carniceria_trig BEFORE
    INSERT ON aceg_prod_carniceria
    FOR EACH ROW
    WHEN ( new.id_producto_pk IS NULL )
BEGIN
    :new.id_producto_pk := aceg_prod_carniceria_seq.nextval;
END;
/

CREATE SEQUENCE aceg_prod_proveedor_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_prod_proveedor_trig BEFORE
    INSERT ON aceg_prod_proveedor
    FOR EACH ROW
    WHEN ( new.id_prod_prov_pk IS NULL )
BEGIN
    :new.id_prod_prov_pk := aceg_prod_proveedor_seq.nextval;
END;
/

CREATE SEQUENCE aceg_proveedor_seq START WITH 1 MINVALUE 1 MAXVALUE 9999999999999999999999999999 CACHE 20;

CREATE OR REPLACE TRIGGER aceg_proveedor_trig BEFORE
    INSERT ON aceg_proveedor
    FOR EACH ROW
    WHEN ( new.id_proveedor_pk IS NULL )
BEGIN
    :new.id_proveedor_pk := aceg_proveedor_seq.nextval;
END;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             0
-- ALTER TABLE                             46
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          12
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         12
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0