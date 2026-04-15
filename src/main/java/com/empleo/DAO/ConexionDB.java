
package com.empleo.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConexionDB {
	
	//private static String urlRemota = "jdbc:mysql://10.0.0.76:3306/agendadb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	// private static String usuarioRemoto = "programa";
	
	private static String urlLocal = "jdbc:mysql://localhost:3306/proyectofinal?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	private static String usuarioLocal = "root";
	private static String password = "hola2332";
	
	public static Connection conectar() {
		
		Connection conexion = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(urlLocal, usuarioLocal, password);
            System.out.println("Conexion a base de datos exitosa!");

        } catch (SQLException e) {
            System.out.println("Error al crear la conexion");
            e.printStackTrace();

        } catch (ClassNotFoundException e) {
            System.out.println("Driver MySQL no encontrado");
            e.printStackTrace();
        }

        return conexion;
    }
		

		
}
