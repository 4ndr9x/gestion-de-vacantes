package com.empleo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.empleo.usuarios.Contratacion;

public class ContratacionDAO {
	
	public static void registrarContratacion(int id_postulacion) {
		
		String consultaSQL = "INSERT INTO contrataciones (id_postulacion, fecha_contrato, comision) SELECT p.id_postulacion, CURDATE(), (v.salario * 0.20) FROM postulaciones p JOIN vacantes v ON p.id_vacantes = v.id_vacantes WHERE p.id_postulacion = ?;";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setInt(1, id_postulacion);			
			consultaFinal.executeUpdate();
			
			System.out.println("Exito ejecutar la consulta REGISTRAR CONTRATACIONES");
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta REGISTRAR CONTRATACIONES");
			e.printStackTrace();
			
		}
		
	}
	
	public static Contratacion buscarContratacion(int id_contratacion) {

	    String consultaSQL = "SELECT u.nombre, u.correo, v.titulo, e.nombre, c.fecha_contrato, c.comision FROM proyectofinal.contrataciones AS c \r\n"
	    		+ "INNER JOIN proyectofinal.postulaciones AS p ON p.id_postulacion = c.id_postulacion\r\n"
	    		+ "INNER JOIN proyectofinal.usuarios AS u ON p.id_usuario = u.id_usuario\r\n"
	    		+ "INNER JOIN proyectofinal.vacantes AS v ON p.id_vacantes = v.id_vacantes\r\n"
	    		+ "JOIN proyectofinal.empresas AS e ON v.id_empresa = e.id_empresa\r\n"
	    		+ "WHERE c.id_contratacion = 2;";

	    try (Connection conexionDB = ConexionDB.conectar();
	         PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {

	        consultaFinal.setInt(1, id_contratacion);
	        consultaFinal.executeQuery();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;
	}
	
	public static void eliminarContratacion(int id_contratacion) {
		
		String consultaSQL = "DELETE FROM proyectofinal.contrataciones WHERE id_contratacion = ?;";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setInt(1, id_contratacion);
			consultaFinal.executeUpdate();
			System.out.println("Exito ejecutar la consulta ELIMINAR CONTRATACIONES");
			
		} catch (SQLException e) {
			// TODO: handle exception
		}
		
	}
	
	
	public static int comprobarContratacion(int id_contratacion) {
		
		int id_encontrada = 0;
		String consultaSQL = "SELECT * FROM proyectofinal.contrataciones;";
		
		try (Connection con = ConexionDB.conectar();
				PreparedStatement ps = con.prepareStatement(consultaSQL);
						ResultSet rs = ps.executeQuery();) {
			
			while (rs.next()) {
	            id_encontrada = rs.getInt("id_contratacion");
	        }
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return id_encontrada;
		
	}
	
	

}
