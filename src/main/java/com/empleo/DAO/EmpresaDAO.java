package com.empleo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.empleo.usuarios.Empresa;

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
	
	public List<Empresa> listarEmpresas() {
	    List<Empresa> lista = new ArrayList<>();
	    String sql = "SELECT id_empresa, nombre FROM empresas"; // Ajusta los nombres de tus columnas
	    try (Connection con = ConexionDB.conectar(); 
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        while (rs.next()) {
	            Empresa e = new Empresa();
	            e.setId_empresa(rs.getInt("id_empresa"));;
	            e.setNombre(rs.getString("nombre"));
	            lista.add(e);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return lista;
	}
	
}
	
	
	
	
