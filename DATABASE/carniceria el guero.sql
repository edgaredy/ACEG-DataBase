ALTER SESSION SET "_ORACLE_SCRIPT" = true;  
CREATE USER alejandro IDENTIFIED BY carniceriaelguero; 

GRANT ALL PRIVILEGES TO ALEJANDRO;

GRANT EXECUTE ANY PROCEDURE TO ALEJANDRO;
GRANT UNLIMITED TABLESPACE TO ALEJANDRO;


INSERT INTO carniceria (nombre, descripcion) VALUES('carniceria el guero', 'la mas chingona');
SELECT * FROM carniceria;

CREATE TABLE carniceria (
    id           INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    nombre       VARCHAR2(50) NOT NULL,
    descripcion  VARCHAR2(100)
);

ALTER TABLE carniceria ADD CONSTRAINT carniceria_pk PRIMARY KEY ( id );

INSERT INTO usuario (id, nombre, apellido, email) VALUES('15140502', 'alejandro', 'rangel hurtado', 'edgar_edii_24@hotmail.com');
SELECT * FROM usuario;

CREATE TABLE usuario (
    id        VARCHAR2(10) NOT NULL,
    nombre    VARCHAR2(30) NOT NULL,
    apellido  VARCHAR2(50) NOT NULL,
    email     VARCHAR2(30) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id );

INSERT INTO usuario_carniceria (usuario_id)
VALUES ('15140502');
SELECT * FROM usuario_carniceria;


CREATE TABLE usuario_carniceria (
    carniceria_id  INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    usuario_id     VARCHAR2(10) NOT NULL
);

ALTER TABLE usuario_carniceria ADD CONSTRAINT relacion_usuario_carniceria_pk PRIMARY KEY ( usuario_id,
                                                                                           carniceria_id );

ALTER TABLE usuario_carniceria
    ADD CONSTRAINT usuario__carniceria_fk FOREIGN KEY ( carniceria_id )
        REFERENCES carniceria ( id );


ALTER TABLE usuario_carniceria
    ADD CONSTRAINT carniceria_usuario_fk FOREIGN KEY ( usuario_id )
        REFERENCES usuario ( id );
