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

### Paso 1 — Ejecutar el script de inicializacion

El repositorio incluye un script SQL completo y listo para usar ubicado en la carpeta `consulta-crear-bd/`. Este script crea la base de datos, todas las tablas, los roles iniciales y el usuario de conexion de la aplicacion.

Para inicializar la base de datos, simplemente abre tu cliente MySQL (MySQL Workbench, DBeaver, terminal, etc.) y ejecuta el contenido de dicho archivo en su totalidad. No es necesario crear nada manualmente.

### Paso 2 — Verificar la conexion

> ⚠️ **No mover ni reubicar `ConexionDB.java`.** El proyecto utiliza un usuario de base de datos dedicado (`programa`) con permisos acotados, cuya configuracion esta vinculada a la ubicacion actual de esta clase. Moverla puede interrumpir la conexion a la base de datos.

Las credenciales ya estan configuradas en `ConexionDB.java` de la siguiente manera:

```java
private static final String URL = "jdbc:mysql://localhost:3306/proyectofinal";
private static final String USER = "programa";
private static final String PASSWORD = "hola2332";
```

### Paso 3 — Crear un usuario administrador

Los administradores no se registran directamente desde el panel de administracion. El proceso es el siguiente:

1. Registra el usuario de forma convencional a traves de la interfaz grafica de la aplicacion.
2. Una vez registrado, ejecuta la siguiente consulta en tu instancia MySQL para elevar su rol a administrador:

```sql
UPDATE proyectofinal.usuarios
SET rol_id = 1
WHERE correo = 'correo@ejemplo.com';
```

> Reemplaza `correo@ejemplo.com` con el correo del usuario que deseas promover. El valor `rol_id = 1` corresponde al rol de **administrador** segun los datos insertados en la tabla `roles`.

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
