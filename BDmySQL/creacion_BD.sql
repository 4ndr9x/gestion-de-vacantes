
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

id_usuario int primary key auto_increment,
nombre varchar(50) not null,
correo varchar(50)  not null UNIQUE,
pass varchar(25) not null,
rol_id INT,
FOREIGN KEY (rol_id) REFERENCES roles(id)

);

/*Tabla para las empresas asociadas*/

CREATE TABLE empresas (

id_empresa int primary key auto_increment,
nombre varchar(20) not null,
correo varchar(50) not null UNIQUE,
RNC varchar(20) not null,
descripcion varchar (100),
estado ENUM('activa','desactiva') default 'activa'

);

/*Tabla para las vacantes, necesitamos relacionar con empresas*/

CREATE TABLE vacantes (

id_vacantes int primary key auto_increment,
id_empresa int NOT NULL,
titulo varchar(20) not null,
descripcion varchar(150),
salario decimal (10,2) not null,
estado ENUM('activa', 'finalizada') default 'activa',
fecha_limite date,

FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa)

);

/*Tabla para las vacantes. Se relacionara con usuario y empresas, ademas que tendran diferentes estados*/

CREATE TABLE postulaciones (

id_postulacion int primary key auto_increment,
id_vacantes int NOT NULL,
id_usuario int NOT NULL,
fecha_postulacion date,
estatus ENUM('pendiente', 'aceptado', 'rechazado') default 'pendiente',

FOREIGN KEY(id_vacantes) REFERENCES vacantes(id_vacantes),
FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)

);

/*Tabla para las contrataciones, servira como reporte para conocer las contrataciones hechas*/

CREATE TABLE contrataciones (

id_contratacion int primary key auto_increment,
id_postulacion int,
fecha_contrato date,
comision decimal(10,2),

FOREIGN KEY(id_postulacion) REFERENCES postulaciones(id_postulacion)
);

-- 1. Crear el usuario para la conexión de la aplicación (cambia la contraseña por una de tu preferencia)
CREATE USER 'programa'@'localhost' IDENTIFIED BY 'hola2332';

-- 2. Otorgar los permisos necesarios SOLO sobre la base de datos del proyecto
GRANT SELECT, INSERT, UPDATE, DELETE ON proyectofinal.* TO 'programa'@'localhost';

-- 3. Aplicar los cambios de privilegios
FLUSH PRIVILEGES;
