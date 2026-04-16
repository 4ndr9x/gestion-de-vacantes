package com.empleo.DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.empleo.usuarios.Vacante;

public class VacanteDAO {
	
	private static final String insertDatos =
			"INSERT INTO vacantes (id_empresa, titulo, descripcion, salario, estado, fecha_limite) VALUES (?,?,?,?,?,?)";
	private static final String selectTitulo = "SELECT titulo from vacantes";
	private static final String deleteVacante = "DELETE from vacantes where id_vacantes = ?;";
	private static final String updateVacante = "UPDATE vacantes SET titulo = ?, descripcion = ?, salario = ?, estado = ?, fecha_limite = ? WHERE id_vacantes = ?";
	
	
	public void insertarVacantes(Vacante vacante) {
	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement(insertDatos)) {

	        ps.setInt(1, vacante.getIdEmpresa());
	        ps.setString(2, vacante.getTitulo());
	        ps.setString(3, vacante.getDescripcion());
	        ps.setBigDecimal(4, vacante.getSalario());
	        ps.setString(5, vacante.getEstado());
	        ps.setDate(6, vacante.getFechaLimite());

	        System.out.println("ATENCIÓN - Intentando insertar vacante con ID de Empresa: " + vacante.getIdEmpresa());

	        ps.executeUpdate();
	        
	        System.out.println("Exito ejecutar la consulta INSERTAR VACANTES");

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public List<Vacante> listarVacantes() {
	    List<Vacante> lista = new ArrayList<>();

	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement("SELECT * FROM vacantes");
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Vacante v = new Vacante();
	            v.setId(rs.getInt("id_vacantes"));
	            v.setIdEmpresa(rs.getInt("id_empresa"));
	            v.setTitulo(rs.getString("titulo"));
	            v.setDescripcion(rs.getString("descripcion"));
	            v.setSalario(rs.getBigDecimal("salario"));
	            v.setEstado(rs.getString("estado"));
	            v.setFechaLimite(rs.getDate("fecha_limite"));
	            
	            lista.add(v);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return lista;
	}
	
	public List<Vacante> listarVacantesActivas() {
	    List<Vacante> lista = new ArrayList<>();
	    // Ajusta los nombres de las columnas 'id_vacantes' y 'estado' según tu DB
	    String sql = "SELECT * FROM vacantes WHERE estado = 'activa'";

	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Vacante v = new Vacante();
	            v.setId(rs.getInt("id_vacantes"));
	            v.setIdEmpresa(rs.getInt("id_empresa"));
	            v.setTitulo(rs.getString("titulo"));
	            v.setDescripcion(rs.getString("descripcion"));
	            v.setSalario(rs.getBigDecimal("salario"));
	            v.setFechaLimite(rs.getDate("fecha_limite"));
	            v.setEstado(rs.getString("estado"));
	            
	            lista.add(v);
	        }
	    } catch (SQLException e) {
	        System.err.println("Error en listarActivas: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return lista;
	}
	
	
	public List<String> listarTitulos() {
	    List<String> titulos = new ArrayList<>();

	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement(selectTitulo);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            titulos.add(rs.getString("titulo"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return titulos;
	}
	
	public void eliminarVacante(int id) {
	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement(deleteVacante)) {

	        ps.setInt(1, id);
	        ps.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public void actualizarVacante(Vacante vacante) {
	    try (Connection con = ConexionDB.conectar();
	         PreparedStatement ps = con.prepareStatement(updateVacante)) {

	        ps.setString(1, vacante.getTitulo());
	        ps.setString(2, vacante.getDescripcion());
	        ps.setBigDecimal(3, vacante.getSalario());
	        ps.setString(4, vacante.getEstado());
	        ps.setDate(5, vacante.getFechaLimite());
	        ps.setInt(6, vacante.getId());

	        ps.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
}	
	
	
	
