
-- Permisos del usuario
ALTER SESSION SET "_ORACLE_SCRIPT" = true;  
CREATE USER alejandro IDENTIFIED BY carniceriaelguero; 

GRANT ALL PRIVILEGES TO ALEJANDRO;

GRANT EXECUTE ANY PROCEDURE TO ALEJANDRO;
GRANT UNLIMITED TABLESPACE TO ALEJANDRO;


-- Creacion de las tablas de la base de datos
-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2020-08-13 22:21:53 CDT
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c
-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE


-- CREACION DE TABLAS Y SUS LLAVES PRIMARIAS
CREATE TABLE carniceria (
    id           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre       VARCHAR2(30) NOT NULL,
    direccion    VARCHAR2(100),
    descripcion  VARCHAR2(100),
    estado_id    INTEGER NOT NULL
);

ALTER TABLE carniceria ADD CONSTRAINT carniceria_pk PRIMARY KEY ( id );

CREATE TABLE carnicero (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre         VARCHAR2(30) NOT NULL,
    apellido       VARCHAR2(50),
    email          VARCHAR2(30) NOT NULL,
    telefono       VARCHAR2(10),
    carniceria_id  INTEGER NOT NULL
);

ALTER TABLE carnicero ADD CONSTRAINT carnicero_pk PRIMARY KEY ( id,
                                                                carniceria_id );

CREATE TABLE cliente (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre         VARCHAR2(50) NOT NULL,
    apellido       VARCHAR2(50),
    telefono       VARCHAR2(10),
    carniceria_id  INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id );

CREATE TABLE estado (
    id           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    estado       VARCHAR2(50) NOT NULL,
    abreviacion  CHAR(3)
);

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( id );

CREATE TABLE municipio (
    id           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    municipio    VARCHAR2(50),
    estado_id    INTEGER NOT NULL,
    abreviacion  CHAR(3)
);

ALTER TABLE municipio ADD CONSTRAINT municipio_pk PRIMARY KEY ( id );

CREATE TABLE nota_adeudada (
    id               INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    idnota           VARCHAR2(10) NOT NULL,
    nombrecomprador  VARCHAR2(30) NOT NULL,
    carniceria_id    INTEGER NOT NULL
);

ALTER TABLE nota_adeudada ADD CONSTRAINT nota_adeudada_pk PRIMARY KEY ( id,
                                                                        carniceria_id );

CREATE TABLE pedido (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    peso           VARCHAR2(10) NOT NULL,
    precio         VARCHAR2(10) NOT NULL,
    costo          NUMBER(16, 4) NOT NULL,
    descripcion    VARCHAR2(100) NOT NULL,
    fechaentrega   DATE NOT NULL,
    total          NUMBER(16, 4) NOT NULL,
    carniceria_id  INTEGER NOT NULL,
    cliente_id     INTEGER NOT NULL
);

ALTER TABLE pedido
    ADD CONSTRAINT pedido_pk PRIMARY KEY ( id,
                                           carniceria_id,
                                           cliente_id );

CREATE TABLE producto_adeudo_cliente (
    id           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    peso         VARCHAR2(10) NOT NULL,
    precio       NUMBER(16, 4) NOT NULL,
    costo        NUMBER(16, 4) NOT NULL,
    descripcion  VARCHAR2(100) NOT NULL,
    fechacompra  DATE NOT NULL,
    total        NUMBER(16, 4) NOT NULL,
    cliente_id   INTEGER NOT NULL
);

ALTER TABLE producto_adeudo_cliente ADD CONSTRAINT producto_adeudo_cliente_pk PRIMARY KEY ( id,
                                                                                            cliente_id );

CREATE TABLE producto_carniceria (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    producto       VARCHAR2(50) NOT NULL,
    precio         NUMBER(16, 4) NOT NULL,
    descripcion    VARCHAR2(100),
    carniceria_id  INTEGER NOT NULL
);

ALTER TABLE producto_carniceria ADD CONSTRAINT producto_carniceria_pk PRIMARY KEY ( id,
                                                                                    carniceria_id );

CREATE TABLE producto_nota_adeudada (
    id                           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    peso                         VARCHAR2(10) NOT NULL,
    precio                       NUMBER(19, 4) NOT NULL,
    costo                        NUMBER(19, 4) NOT NULL,
    descripcion                  VARCHAR2(100),
    fechacompra                  DATE NOT NULL,
    total                        NUMBER(19, 4) NOT NULL,
    nota_adeudada_id             INTEGER NOT NULL,
    nota_adeudada_carniceria_id  INTEGER NOT NULL
);

ALTER TABLE producto_nota_adeudada
    ADD CONSTRAINT producto_nota_adeudada_pk PRIMARY KEY ( id,
                                                           nota_adeudada_id,
                                                           nota_adeudada_carniceria_id );

CREATE TABLE prov_prod_carniceria (
    proveedor_id                       INTEGER NOT NULL,
    prod_carniceria_id             INTEGER NOT NULL, 
         producto_carniceria_carniceria_id  INTEGER NOT NULL
);

ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT prov_prod_carniceria_pk PRIMARY KEY ( proveedor_id,
                                                         prod_carniceria_id);

CREATE TABLE proveedor (
    id               INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre_empresa   VARCHAR2(50),
    nombreproveedor  VARCHAR2(30) NOT NULL,
    apellido         VARCHAR2(50),
    telefono         VARCHAR2(10)
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id );

CREATE TABLE proveedor_carniceria (
    proveedor_id   INTEGER NOT NULL,
    carniceria_id  INTEGER NOT NULL
);

ALTER TABLE proveedor_carniceria ADD CONSTRAINT proveedor_carniceria_pk PRIMARY KEY ( proveedor_id,
                                                                                      carniceria_id );


-- CREACION DE LLAVES FORANEAS

ALTER TABLE carniceria
    ADD CONSTRAINT carniceria_estado_fk FOREIGN KEY ( estado_id )
        REFERENCES estado ( id );

ALTER TABLE carnicero
    ADD CONSTRAINT carnicero_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

ALTER TABLE municipio
    ADD CONSTRAINT municipio_estado_fk FOREIGN KEY ( estado_id )
        REFERENCES estado ( id );

ALTER TABLE nota_adeudada
    ADD CONSTRAINT nota_adeudada_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );
        
-- CONTINUAR A PARTIR DE AQUI CON EL SCRIPT

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE producto_adeudo_cliente
    ADD CONSTRAINT prod_adeudo_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE producto_carniceria
    ADD CONSTRAINT prod_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE producto_nota_adeudada
    ADD CONSTRAINT produ_nota_adeudada_fk FOREIGN KEY ( nota_adeudada_id,
                                                                         nota_adeudada_carniceria_id )
        REFERENCES nota_adeudada ( id,
                                   carniceria_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT proveed_prod_carniceria_fk FOREIGN KEY ( producto_carniceria_id,
                                                                             producto_carniceria_carniceria_id )
        REFERENCES producto_carniceria ( id,
                                         carniceria_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT prov_prod_carniceria_fk FOREIGN KEY ( proveedor_id )
        REFERENCES proveedor ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE proveedor_carniceria
    ADD CONSTRAINT prov_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE proveedor_carniceria
    ADD CONSTRAINT prov_carniceria_prov_fk FOREIGN KEY ( proveedor_id )
        REFERENCES proveedor ( id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             27
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
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
-- CREATE SEQUENCE                          0
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
