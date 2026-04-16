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

1. Crear la base de datos en MySQL:

```sql
CREATE DATABASE gestion_vacantes;
USE gestion_vacantes;
```

2. Crear las tablas principales:

```sql
CREATE TABLE empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    sector VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'usuario') DEFAULT 'usuario'
);

CREATE TABLE vacante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    salario DECIMAL(10,2),
    fecha_limite DATE,
    estado ENUM('Activa', 'Finalizada') DEFAULT 'Activa',
    FOREIGN KEY (id_empresa) REFERENCES empresa(id)
);

CREATE TABLE postulacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_vacante INT NOT NULL,
    fecha_postulacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_vacante) REFERENCES vacante(id)
);
```

3. Configurar la conexion en `ConexionDB.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/gestion_vacantes";
private static final String USER = "tu_usuario";
private static final String PASSWORD = "tu_contrasena";
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
