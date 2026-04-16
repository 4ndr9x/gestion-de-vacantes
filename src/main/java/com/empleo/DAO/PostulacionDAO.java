package com.empleo.DAO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.empleo.usuarios.Postulacion;
import com.empleo.usuarios.Usuario;
import com.empleo.usuarios.Vacante;

public class PostulacionDAO {
	
	
	private String bddUrl="";
	private String bddUser="root";
	private String bddPass="";
			

	private static final String insertarDatos= "INSERT INTO postulaciones (id_vacante, id_usuario,fecha_postulacion, estatus) VALUES(?,?,?,?)";
	private static final String selectPorId= "SELECT p.id as id_postulacion,p.id_vacante,p.id_usuario, p.fecha_postulacion, p.estatus FROM postulaciones p INNER JOIN vacantes v ON p.id_vacante= v.id INNER JOIN usuarios u ON p.id_usuario=u.id WHERE p.id=?";
	private static final String selectPostulaciones= "SELECT p.id as id_postulacion,p.id_vacante,p.id_usuario, p.fecha_postulacion, p.estatus  FROM postulaciones p INNER JOIN vacantes v ON p.id_vacante= v.id INNER JOIN usuarios u ON p.id_usuario=u.id";
	private static final String searchPostulaciones= "SELECT p.id as id_postulacion,p.id_vacante,p.id_usuario, p.fecha_postulacion, p.estatus FROM postulaciones p INNER JOIN vacantes v ON p.id_vacante= v.id INNER JOIN usuarios u ON p.id_usuario=u.id"
	+ " WHERE p.estatus LIKE ? OR u.nombre LIKE ? OR v.titulo LIKE ?";
	private static final String countPostulaciones= "SELECT COUNT(*) AS total FROM postulaciones";
	private static final String deletePostulaciones= "DELETE FROM postulaciones where id= ?";
	private static final String updatePostulaciones= "UPDATE  postulaciones set id_vacante=?, id_usuario=?, fecha_postulacion=?, estatus=? where id=?";
	
	
	protected Connection getConnection() {
		Connection con= null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con= DriverManager.getConnection(bddUrl,bddUser,bddPass);
			
		}catch(SQLException e){
			
			e.printStackTrace();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return con;
		
	}
	
	public void insertarPostulaciiones(Postulacion postulacion) {
		
		try(Connection con= getConnection(); PreparedStatement ps=con.prepareStatement(insertarDatos)){
			
			ps.setInt(1, postulacion.getVacante().getId());
			ps.setInt(2, postulacion.getUsuario().getId());
			ps.setDate(3, postulacion.getFechaPostulacion());
			ps.setString(4, postulacion.getEstatus());
			
			ps.executeUpdate();
			
		} catch(SQLException e){
			e.printStackTrace();
		}
		
	}
	
	public Postulacion buscarPorID(int id) {
		
		Postulacion postulacion=null; 
		
		try(Connection con= getConnection(); PreparedStatement ps= con.prepareStatement(selectPorId)){
			
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				
				int idVacante= rs.getInt("id_vacante");
				int idUsuario= rs.getInt("id_usuario");
				Date fechaPost= rs.getDate("fecha_postulacion");
				String status= rs.getString("estatus");
				
				Vacante vacante= new Vacante();
				vacante.setId(idVacante);
				Usuario usuario= new Usuario();
				usuario.setId(idUsuario);
				
				postulacion= new Postulacion(id,vacante,usuario,fechaPost,status);
			}
			
		}
		catch(SQLException e) {
			e.printStackTrace();
			
		}
		return postulacion;
	}
	
	public List<Postulacion> ListaPostulaciones(){
		
		List<Postulacion> postulaciones= new ArrayList<>();
		
		try(Connection con= getConnection(); PreparedStatement ps= con.prepareStatement(selectPostulaciones)){
			
			ResultSet rs= ps.executeQuery();
			
			while(rs.next()) {
				
				int idPost = rs.getInt("id_postulacion");
				int idVacante= rs.getInt("id_vacante");
				int idUsuario= rs.getInt("id_usuario");
				Date fechaPost= rs.getDate("fecha_postulacion");
				String status= rs.getString("estatus");
				Vacante vacante= new Vacante();
				vacante.setId(idVacante);
				Usuario usuario= new Usuario();
				usuario.setId(idUsuario);
				
				postulaciones.add(new Postulacion(idPost,vacante,usuario,fechaPost,status));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return postulaciones;
		
		
	}
	
	public boolean borrarPostulacion(int id) {
		
		boolean borrado = false;
		
		try(Connection con= getConnection(); PreparedStatement ps= con.prepareStatement(deletePostulaciones)){
			
			ps.setInt(1, id);
			borrado=ps.executeUpdate()>0;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		
		return borrado;
		
	}
	
	public List<Postulacion> buscarPorDato(String buscar){
		
		List<Postulacion> postulaciones= new ArrayList<>();
		
		try(Connection con= getConnection(); PreparedStatement ps= con.prepareStatement(searchPostulaciones)){
			
			String like= "%" + buscar + "%";
			
			ps.setString(1, like);
			ps.setString(2, like);
			ps.setString(3, like);
			
			ResultSet rs= ps.executeQuery();
			
			while(rs.next()) {
				
				int idPost = rs.getInt("id_postulacion");
				int idVacante= rs.getInt("id_vacante");
				int idUsuario= rs.getInt("id_usuario");
				Date fechaPost= rs.getDate("fecha_postulacion");
				String status= rs.getString("estatus");
		
				Vacante vacante= new Vacante();
				vacante.setId(idVacante);
				Usuario usuario= new Usuario();
				usuario.setId(idUsuario);
				
				postulaciones.add(new Postulacion(idPost,vacante,usuario,fechaPost,status));
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
			
		}
		
		return postulaciones;
		
	}
	
	public int totalPostulaciones() {
		
		int total=0;
		
		try(Connection con= getConnection(); PreparedStatement ps= con.prepareStatement(countPostulaciones)){
			
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				
				total= rs.getInt("total");
				
			}
			
			
		}catch(SQLException e) {
			e.printStackTrace();
			
		}
		return total;
		
	}
	
    public boolean editarPostulacion(Postulacion postulacion){
        boolean actualizada = false;
        
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(updatePostulaciones);) {
            ps.setInt(1, postulacion.getVacante().getId());
            ps.setInt(2, postulacion.getUsuario().getId());
            ps.setDate(3, postulacion.getFechaPostulacion());
            ps.setString(4, postulacion.getEstatus());
            ps.setInt(5, postulacion.getId());

            actualizada = ps.executeUpdate() > 0;
        } catch(SQLException e) {
        	e.printStackTrace();
        }
        return actualizada;
    }

	
	
	
}
