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
	            	u.setId(resultadoDB.getInt("id_usuario"));
	            	
	                return u;
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;
	}
	
	public Usuario validar(String correo, String pass) {
	    Usuario u = null;
	    String sql = "SELECT * FROM usuarios WHERE correo = ? AND pass = ?";
	    try (Connection con = ConexionDB.conectar(); 
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, correo);
	        ps.setString(2, pass);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                u = new Usuario();
	                // ¡ESTA LÍNEA ES LA MÁS IMPORTANTE!
	                u.setId(rs.getInt("id_usuario"));
	                u.setNombre(rs.getString("nombre"));
	                u.setRol_id(rs.getInt("rol_id"));
	            }
	        }
	    } catch (SQLException e) { e.printStackTrace(); }
	    return u;
	}
	
	
	
}