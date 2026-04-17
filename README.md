# Gestion de Vacantes

Sistema web de portal de empleo desarrollado en Java con Jakarta EE. Permite a empresas publicar vacantes y a usuarios postularse a ellas a traves de una interfaz web sencilla.

---

## Tecnologias utilizadas

- Java 17+
- Jakarta EE (Servlets, JSP, JSTL)
- MySQL
- Bootstrap 5.3
- Apache Tomcat 10+
- Eclipse IDE

---

## Estructura del proyecto

```
gestion-de-vacantes/
├── src/main/
│   ├── java/com/empleo/
│   │   ├── controlador/        # Servlets
│   │   │   ├── AdminDashboardServlet.java
│   │   │   ├── ListaVacantesUsuarioServlet.java
│   │   │   ├── LoginUsuarioServlet.java
│   │   │   ├── LogoutServlet.java
│   │   │   ├── PostulacionesServlet.java
│   │   │   ├── RegistroUsuarioServlet.java
│   │   │   ├── UsuarioDashboardServlet.java
│   │   │   └── VacanteServletAdm.java
│   │   ├── DAO/                # Acceso a datos
│   │   │   ├── ConexionDB.java
│   │   │   ├── ContratacionDAO.java
│   │   │   ├── EmpresaDAO.java
│   │   │   ├── PostulacionDAO.java
│   │   │   ├── UsuarioDAO.java
│   │   │   └── VacanteDAO.java
│   │   └── usuarios/           # Modelos
│   │       ├── Contratacion.java
│   │       ├── Empresa.java
│   │       ├── Postulacion.java
│   │       ├── Rol.java
│   │       ├── Usuario.java
│   │       └── Vacante.java
│   └── webapp/
│       └── vista/              # Paginas JSP
│           ├── admin_postulaciones.jsp
│           ├── loginPageUsuario.jsp
│           ├── paginaPrincipalAdm.jsp
│           ├── paginaPrincipalUsuario.jsp
│           ├── PagPrueba.jsp
│           ├── registroExitoso.jsp
│           ├── registroUsuario.jsp
│           └── usuario_postulaciones.jsp
```

---

## Requisitos previos

- JDK 17 o superior
- Apache Tomcat 10.1 o superior
- MySQL 8.0 o superior
- Eclipse IDE for Enterprise Java (o cualquier IDE compatible con Jakarta EE)

---

## Configuracion de la base de datos

1. Crear la base de datos en MySQL y ejecutar el siguiente script completo:

```sql
CREATE DATABASE proyectofinal;
USE proyectofinal;

/* Tabla externa para roles */
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL
);

/* Valores iniciales de roles */
INSERT INTO proyectofinal.roles (nombre) VALUES ('usuario');
INSERT INTO proyectofinal.roles (nombre) VALUES ('empresa');
INSERT INTO proyectofinal.roles (nombre) VALUES ('administrador');

/* Tabla de usuarios con rol asignado */
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    pass VARCHAR(25) NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

/* Tabla de empresas asociadas */
CREATE TABLE empresas (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    RNC VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100),
    estado ENUM('activa', 'desactiva') DEFAULT 'activa'
);

/* Tabla de vacantes relacionada con empresas */
CREATE TABLE vacantes (
    id_vacantes INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    titulo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(150),
    salario DECIMAL(10,2) NOT NULL,
    estado ENUM('activa', 'finalizada') DEFAULT 'activa',
    fecha_limite DATE,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa)
);

/* Tabla de postulaciones relacionada con usuarios y vacantes */
CREATE TABLE postulaciones (
    id_postulacion INT PRIMARY KEY AUTO_INCREMENT,
    id_vacantes INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_postulacion DATE,
    estatus ENUM('pendiente', 'aceptado', 'rechazado') DEFAULT 'pendiente',
    FOREIGN KEY (id_vacantes) REFERENCES vacantes(id_vacantes),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

/* Tabla de contrataciones como reporte */
CREATE TABLE contrataciones (
    id_contratacion INT PRIMARY KEY AUTO_INCREMENT,
    id_postulacion INT,
    fecha_contrato DATE,
    comision DECIMAL(10,2),
    FOREIGN KEY (id_postulacion) REFERENCES postulaciones(id_postulacion)
);

/* Usuario de conexion para la aplicacion */
CREATE USER 'programa'@'localhost' IDENTIFIED BY 'hola2332';
GRANT SELECT, INSERT, UPDATE, DELETE ON proyectofinal.* TO 'programa'@'localhost';
FLUSH PRIVILEGES;
```

2. Credenciales de conexion en `ConexionDB.java`:

> ⚠️ **IMPORTANTE:** No mover ni reubicar la clase `ConexionDB.java` dentro del proyecto. El sistema cuenta con su propio usuario de base de datos (`programa`) configurado con permisos especificos. Modificar la ubicacion de esta clase puede romper las referencias internas y la conexion a la base de datos.

```java
private static final String URL = "jdbc:mysql://localhost:3306/proyectofinal";
private static final String USER = "programa";
private static final String PASSWORD = "hola2332";
```

---

## Instalacion y ejecucion

1. Clonar el repositorio:

```bash
git clone https://github.com/4ndr9x/gestion-de-vacantes.git
```

2. Importar el proyecto en Eclipse como **Dynamic Web Project** existente o mediante **Import > Existing Maven Projects** si aplica.

3. Agregar el driver JDBC de MySQL (`mysql-connector-j-x.x.x.jar`) en la carpeta `WEB-INF/lib/`.

4. Configurar Tomcat 10+ en Eclipse y asociarlo al proyecto.

5. Ejecutar el proyecto sobre el servidor Tomcat. La aplicacion estara disponible en:

```
http://localhost:8080/gestion-de-vacantes/
```

---

## Funcionalidades

**Panel de usuario**
- Registro e inicio de sesion
- Visualizacion de vacantes disponibles
- Postulacion a vacantes mediante modal de confirmacion
- Consulta de postulaciones realizadas
- Cierre de sesion

**Panel de administrador**
- Gestion completa de vacantes: crear, editar y eliminar
- Visualizacion de postulaciones recibidas
- Cambio de estado de vacantes (Activa / Finalizada)
- Cierre de sesion

---

## Notas

- Las sesiones se manejan con `HttpSession` de Jakarta Servlet.
- El acceso a cada panel esta protegido por rol; si no hay sesion activa, el usuario es redirigido al login.
- Los warnings de atributos SVG y JSTL que muestra Eclipse son falsos positivos y no afectan la ejecucion del proyecto.
