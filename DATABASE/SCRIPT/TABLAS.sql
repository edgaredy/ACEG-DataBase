
-- Permisos del usuario
ALTER SESSION SET "_ORACLE_SCRIPT" = true;  
CREATE USER alejandro IDENTIFIED BY carniceriaelguero; 

GRANT ALL PRIVILEGES TO ALEJANDRO;

GRANT EXECUTE ANY PROCEDURE TO ALEJANDRO;
GRANT UNLIMITED TABLESPACE TO ALEJANDRO;


DROP TABLE CARNICERO;
DROP TABLE MUNICIPIO;
DROP TABLE PEDIDO;
DROP TABLE PRODUCTO_NOTA_ADEUDADA;
DROP TABLE PROV_PROD_CARNICERIA;
DROP TABLE PROVEEDOR_CARNICERIA;
DROP TABLE PROVEEDOR;
DROP TABLE PRODUCTO_CARNICERIA;
DROP TABLE NOTA_ADEUDADA;
DROP TABLE PRODUCTO_ADEUDO_CLIENTE;
DROP TABLE CLIENTE;
DROP TABLE CARNICERIA;
DROP TABLE ESTADO;


-- Creacion de las tablas de la base de datos
-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2020-08-13 22:21:53 CDT
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c
-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE


-- CREACION DE TABLAS Y SUS LLAVES PRIMARIAS

CREATE TABLE carniceria (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre         VARCHAR2(30) NOT NULL,
    direccion      VARCHAR2(100),
    codigo_postal  VARCHAR2(5),
    telefono       VARCHAR2(10),
    descripcion    VARCHAR2(100),
    estado_id      INTEGER NOT NULL
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


ALTER TABLE carnicero ADD CONSTRAINT carnicero_pk PRIMARY KEY ( id, carniceria_id );

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
    estado_id    INTEGER NOT NULL
);

ALTER TABLE municipio ADD CONSTRAINT municipio_pk PRIMARY KEY ( id );

CREATE TABLE nota_adeudada (
    id               INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    idnota           VARCHAR2(10) NOT NULL,
    nombrecomprador  VARCHAR2(30) NOT NULL,
    carniceria_id    INTEGER NOT NULL
);

ALTER TABLE nota_adeudada ADD CONSTRAINT nota_adeudada_pk PRIMARY KEY ( id, carniceria_id );

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
    ADD CONSTRAINT pedido_pk PRIMARY KEY ( id, carniceria_id, cliente_id );

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

ALTER TABLE producto_adeudo_cliente ADD CONSTRAINT producto_adeudo_cliente_pk PRIMARY KEY ( id, cliente_id );

CREATE TABLE producto_carniceria (
    id             INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    producto       VARCHAR2(50) NOT NULL,
    precio         NUMBER(16, 4) NOT NULL,
    descripcion    VARCHAR2(100),
    carniceria_id  INTEGER NOT NULL
);

ALTER TABLE producto_carniceria ADD CONSTRAINT producto_carniceria_pk PRIMARY KEY ( id, carniceria_id );
                                                                                                                                                            
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
    ADD CONSTRAINT producto_nota_adeudada_pk PRIMARY KEY ( id, nota_adeudada_id, nota_adeudada_carniceria_id );

CREATE TABLE prov_prod_carniceria (
    proveedor_id                       INTEGER NOT NULL,
    prod_carniceria_id             INTEGER NOT NULL, 
    producto_carniceria_carniceria_id  INTEGER NOT NULL
);

ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT prov_prod_carniceria_pk PRIMARY KEY ( proveedor_id, prod_carniceria_id);

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

ALTER TABLE proveedor_carniceria ADD CONSTRAINT proveedor_carniceria_pk PRIMARY KEY ( proveedor_id, carniceria_id );


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

ALTER TABLE producto_adeudo_cliente
    ADD CONSTRAINT prod_adeudo_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE producto_carniceria
    ADD CONSTRAINT prod_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );
     
ALTER TABLE producto_nota_adeudada
    ADD CONSTRAINT produ_nota_adeudada_fk FOREIGN KEY ( nota_adeudada_id, nota_adeudada_carniceria_id )
        REFERENCES nota_adeudada ( id, carniceria_id );
            
ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT proveed_prod_carniceria_fk FOREIGN KEY ( prod_carniceria_id, producto_carniceria_carniceria_id )
        REFERENCES producto_carniceria ( id, carniceria_id );

ALTER TABLE prov_prod_carniceria
    ADD CONSTRAINT prov_prod_carniceria_fk FOREIGN KEY ( proveedor_id )
        REFERENCES proveedor ( id );

ALTER TABLE proveedor_carniceria
    ADD CONSTRAINT prov_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

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


-- CARNICERIA 100%
-- CARNICEROS 100%
-- CLIENTES 100%
-- ESTADOS 100%
-- MUNICIPIOS 100%

DROP TABLE carn_prod;
DROP TABLE prod_carniceria;
DROP TABLE carniceria;
 
 -- 1
CREATE TABLE carn_prod (
    carniceria_id             INTEGER NOT NULL,
    prod_carniceria_id        INTEGER NOT NULL,
    prod_carniceria_precio    NUMBER(7, 2),
    prod_carniceria_producto  VARCHAR2(50)
);

ALTER TABLE carn_prod
    ADD CONSTRAINT carn_prod_pk PRIMARY KEY ( carniceria_id,
                                              prod_carniceria_id,
                                              prod_carniceria_precio,
                                              prod_carniceria_producto );
-- 2                                                                
CREATE TABLE carniceria (
    id             INTEGER NOT NULL,
    nombre         VARCHAR2(30) NOT NULL,
    direccion      VARCHAR2(100),
    codigo_postal  VARCHAR2(5),
    telefono       CHAR(10),
    descripcion    VARCHAR2(100)
);

ALTER TABLE carniceria ADD CONSTRAINT carniceria_pk PRIMARY KEY ( id );

-- 3
CREATE TABLE prod_carniceria (
    id           INTEGER NOT NULL,
    producto     VARCHAR2(50) NOT NULL,
    precio       NUMBER(7, 2) NOT NULL,
    tipo_carne   VARCHAR2(5) NOT NULL,
    descripcion  VARCHAR2(100)
);

ALTER TABLE prod_carniceria
    ADD CONSTRAINT prod_carniceria_pk PRIMARY KEY ( id,
                                                    precio,
                                                    producto );


SELECT * FROM carniceria C
INNER JOIN carn_prod CP
ON CP.carniceria_id = c.id
INNER JOIN prod_carniceria PC
ON PC.ID = CP.PROD_CARNICERIA_ID
WHERE C.ID = 2;


SELECT * FROM prod_carniceria;
SELECT * FROM carn_prod;
SELECT * FROM carniceria;




-- 1                                                             
ALTER TABLE carn_prod
    ADD CONSTRAINT carn_prod_carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );

ALTER TABLE carn_prod
    ADD CONSTRAINT carn_prod_prod_carniceria_fk FOREIGN KEY ( prod_carniceria_id )
        REFERENCES prod_carniceria ( id );
        
-- 2
-- 3



-- 1
INSERT INTO carn_prod (carniceria_id, prod_carniceria_id) VALUES(1,1);
INSERT INTO carn_prod (carniceria_id, prod_carniceria_id) VALUES(2,1);
INSERT INTO carn_prod (carniceria_id, prod_carniceria_id) VALUES(2,2);

-- 2
INSERT INTO carniceria (id, nombre, direccion, codigo_postal, telefono, descripcion) VALUES(1, 'EL GUERO', 'LOMAS', '76080', '4423357630', 'NIEVES PUTO');
INSERT INTO carniceria (id, nombre, direccion, codigo_postal, telefono, descripcion) VALUES(2, 'BAMBI', 'LOMAS', '76080', '4412378945', 'EL TRONCO');

-- 3
INSERT INTO prod_carniceria (id, producto, precio, tipo_carne, descripcion) VALUES(1, 'SUADERO', 110, 'RES', 'CARNE CHINGONA');
INSERT INTO prod_carniceria (id, producto, precio, tipo_carne, descripcion) VALUES(2, 'JUIL', 145, 'RES', 'CARNE ALV');


