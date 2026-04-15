package com.empleo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.empleo.usuarios.Usuario;

public class UsuarioDAO {
	
	public static void registrarUsuario(String nombre, String correo, String password, int rol_id) {
		
		String consultaSQL = "INSERT INTO proyectofinal.usuarios (nombre, correo, pass, rol_id) VALUES (?, ?, ?, ?);";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setString(1, nombre);
			consultaFinal.setString(2, correo);
			consultaFinal.setString(3, password);
			consultaFinal.setInt(4, rol_id);
			
			consultaFinal.executeUpdate();
			
			System.out.println("Exito ejecutar la consulta REGISTRAR USUARIO");
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta REGISTRAR USUARIO");
			e.printStackTrace();
			
		}
		
	}
	
	public static Usuario buscarUsuario(String correoLogin, String passwordLogin) {

	    String consultaSQL = "SELECT * FROM proyectofinal.usuarios WHERE correo = ?";

	    try (Connection conexionDB = ConexionDB.conectar();
	         PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL)) {

	        consultaFinal.setString(1, correoLogin);
	        ResultSet resultadoDB = consultaFinal.executeQuery();

	        if (resultadoDB.next()) {
	        	
	        	String correoRef = resultadoDB.getString("correo");
	            String passRef = resultadoDB.getString("pass");
	            String nombreRef = resultadoDB.getString("nombre");
	            int rol_idRef = resultadoDB.getInt("rol_id");

	            if (passwordLogin.equals(passRef)) {
	            	
	            	Usuario u = new Usuario(nombreRef, correoRef, passRef, rol_idRef);
	            	
	                return u;
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;
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
