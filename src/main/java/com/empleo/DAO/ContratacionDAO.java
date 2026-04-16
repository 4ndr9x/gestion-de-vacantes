package com.empleo.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.empleo.usuarios.Contratacion;

public class ContratacionDAO {
	
	public static void registrarContratacion(int id_postulacion, Date fecha_contrato, BigDecimal comision) {
		
		String consultaSQL = "INSERT INTO contrataciones (id_postulacion, fecha_contrato, comision)\\r\\n\"\r\n"
				+ "	    		+ \"SELECT \\r\\n\"\r\n"
				+ "	    		+ \"p.id_postulacion,\\r\\n\"\r\n"
				+ "	    		+ \"CURDATE(),\\r\\n\"\r\n"
				+ "	    		+ \"v.salario * 0.20\\r\\n\"\r\n"
				+ "	    		+ \"FROM postulaciones p\\r\\n\"\r\n"
				+ "	    		+ \"JOIN vacantes v ON p.id_vacantes = v.id_vacantes\\r\\n\"\r\n"
				+ "	    		+ \"WHERE p.id_postulacion = ?;;";
		
		try (Connection conexionDB = ConexionDB.conectar();
				PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {
			
			consultaFinal.setInt(1, id_postulacion);
			consultaFinal.setDate(2, fecha_contrato);
			consultaFinal.setBigDecimal(3, comision);
			
			consultaFinal.executeUpdate();
			
			System.out.println("Exito ejecutar la consulta REGISTRAR CONTRATACIONES");
			
		} catch (SQLException e) {
			
			System.out.println("Error al ejecutar la consulta REGISTRAR CONTRATACIONES");
			e.printStackTrace();
			
		}
		
	}
	
	public static Contratacion buscarContratacion(int id_contrataciones) {

	    String consultaSQL = "SELECT u.nombre, u.correo, v.titulo, e.nombre, c.fecha_contrato, c.comision FROM proyectofinal.contrataciones AS c \r\n"
	    		+ "INNER JOIN proyectofinal.postulaciones AS p ON p.id_postulacion = c.id_postulacion\r\n"
	    		+ "INNER JOIN proyectofinal.usuarios AS u ON p.id_usuario = u.id_usuario\r\n"
	    		+ "INNER JOIN proyectofinal.vacantes AS v ON p.id_vacantes = v.id_vacantes\r\n"
	    		+ "JOIN proyectofinal.empresas AS e ON v.id_empresa = e.id_empresa\r\n"
	    		+ "WHERE c.id_contratacion = 2;";

	    try (Connection conexionDB = ConexionDB.conectar();
	         PreparedStatement consultaFinal = conexionDB.prepareStatement(consultaSQL);) {

	        consultaFinal.setInt(1, id_contrataciones);
	        consultaFinal.executeQuery();

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
