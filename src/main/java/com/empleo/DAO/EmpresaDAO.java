package com.empleo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmpresaDAO {
	
	public static void registrarEmpresa(String nombre, String correo, String password, String rnc, String descripcion, String contacto,
			int rol_id) {
		
		String consultaSQL = "INSERT INTO proyectofinal.empresas (nombre, correo, pass, RNC, descripcion, contacto, rol_id)\r\n"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?);";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setString(1, nombre);
			consultaFinal.setString(2, correo);
			consultaFinal.setString(3, password);
			consultaFinal.setString(4, rnc);
			consultaFinal.setString(5, descripcion);
			consultaFinal.setString(6, contacto);
			consultaFinal.setInt(7, rol_id);
			
			consultaFinal.executeUpdate();
			
			System.out.println("Exito ejecutar la consulta REGISTRAR EMPRESA");
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta REGISTRAR EMPRESA");
			e.printStackTrace();
			
		}
		
	}
	
	public static String buscarEmpresa(String correoLogin, String passwordLogin) {

	    String consultaSQL = "SELECT * FROM proyectofinal.empresas WHERE correo = ?";

	    try (Connection conexionDB = ConexionDB.conectar();
	         PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL)) {

	        consultaFinal.setString(1, correoLogin);
	        ResultSet resultadoDB = consultaFinal.executeQuery();

	        if (resultadoDB.next()) {
	            String passRef   = resultadoDB.getString("pass");
	            String nombreRef = resultadoDB.getString("nombre"); // 👈 obtienes el nombre

	            if (passwordLogin.equals(passRef)) {
	                return nombreRef; // ✅ devuelves el nombre si el login es correcto
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null; // ❌ null significa que falló el login
	}
	
	
	
	/* public static void eliminarDatos(int ID_evento) {
		
		String consultaSQL = "DELETE FROM agendadb.eventos WHERE ID_evento = ?;";
		
		try (Connection conexionDB = ConexionDB.conectar(); PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setInt(1, ID_evento);
			
			int numEventos = consultaFinal.executeUpdate();
			
			if (numEventos > 0) {
			
				System.out.println("Exito ejecutar la consulta ELIMINAR");
				
			} else {
				
				System.out.println("No se elimino");
				
			}
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta ELIMINAR");
			e.printStackTrace();
			
			
		}
		
	}
	
	public static void editarDatos(String nombre_evento, LocalDate fecha_evento, String descripcion, String prioridad, int ID_evento) {
		
		String consultaSQL = "UPDATE agendadb.eventos SET nombre_evento = ?, fecha_evento = ?, descripcion = ?, prioridad = ? WHERE ID_evento = ?;";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);
				ResultSet resultadoDB = consultaFinal.executeQuery()) {
			
			consultaFinal.executeUpdate();
			
			System.out.println("Exito ejecutar la consulta EDITAR");
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta EDITAR");
			e.printStackTrace();
			
			
		}
		
	} */
	
	

}
