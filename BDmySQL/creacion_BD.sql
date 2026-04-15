
CREATE DATABASE proyectofinal;
USE proyectofinal;

/* Tabla externa para roles */

CREATE TABLE roles (

id INT PRIMARY KEY AUTO_INCREMENT,
nombre varchar(20) NOT NULL

);

/* Agregando los valores pertinentes a la tabla roles */

INSERT INTO proyectofinal.roles (nombre) VALUES ('usuario');
INSERT INTO proyectofinal.roles (nombre) VALUES ('empresa');
INSERT INTO proyectofinal.roles (nombre) VALUES ('administrador');

/*Tabla para el manejo de usuarios donde estos tendran roles para acceder*/

CREATE TABLE usuarios (

id int primary key auto_increment,
nombre varchar(50) not null,
correo varchar(50)  not null UNIQUE,
pass varchar(25) not null,
rol_id INT,
FOREIGN KEY (rol_id) REFERENCES roles(id)

);

/*Tabla para las empresas asociadas*/

CREATE TABLE empresas (

id int primary key auto_increment,
nombre varchar(20) not null,
correo varchar(50) not null UNIQUE,
pass varchar(25) not null,
RNC varchar(20) not null,
descripcion varchar (100),
contacto varchar(25),
rol_id INT,
FOREIGN KEY (rol_id) REFERENCES roles(id)

);

/*Tabla para las vacantes, necesitamos relacionar con empresas*/

CREATE TABLE vacantes (

id int primary key auto_increment,
id_empresa int,
titulo varchar(20) not null,
descripcion varchar(150),
salario decimal (10,2) not null,
estado ENUM('activa', 'finalizada') default 'activa',
fecha_limite date,

FOREIGN KEY (id_empresa) REFERENCES empresas(id)

);

/*Tabla para las vacantes. Se relacionara con usuario y empresas, ademas que tendran diferentes estados*/

CREATE TABLE postulaciones (

id int primary key auto_increment,
id_vacante int,
id_usuario int,
fecha_postulacion date,
estatus ENUM('pendiente', 'aceptado', 'rechazado') default 'pendiente',

FOREIGN KEY(id_vacante) REFERENCES vacantes(id),
FOREIGN KEY(id_usuario) REFERENCES usuarios(id)
);

/*Tabla para las contrataciones, servira como reporte para conocer las contrataciones hechas*/

CREATE TABLE contrataciones (

id int primary key auto_increment,
id_postulacion int,
fecha_contrato date,
comision decimal(10,2),

FOREIGN KEY(id_postulacion) REFERENCES postulaciones(id)
);


