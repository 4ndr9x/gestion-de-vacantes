package com.empleo.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.empleo.usuarios.Postulacion;
import com.empleo.usuarios.Usuario;
import com.empleo.usuarios.Vacante;

public class PostulacionDAO {

    // SOLUCIÓN: Se cambió id_vacante por id_vacantes en todas las consultas
    private static final String insertarDatos = "INSERT INTO postulaciones (id_vacantes, id_usuario, fecha_postulacion, estatus) VALUES(?,?,?,?)";
    private static final String selectPorId = "SELECT \r\n"
    		+ "    p.id_postulacion, \r\n"
    		+ "    p.id_vacantes, \r\n"
    		+ "    p.id_usuario, \r\n"
    		+ "    p.fecha_postulacion, \r\n"
    		+ "    p.estatus, \r\n"
    		+ "    v.titulo AS titulo_vacante, \r\n"
    		+ "    u.nombre AS nombre_usuario \r\n"
    		+ "FROM postulaciones p \r\n"
    		+ "LEFT JOIN vacantes v ON p.id_vacantes = v.id_vacantes \r\n"
    		+ "LEFT JOIN usuarios u ON p.id_usuario = u.id_usuario \r\n"
    		+ "WHERE p.id_postulacion = ?";
    private static final String selectPostulaciones = "SELECT p.id_postulacion, p.id_vacantes, p.id_usuario, p.fecha_postulacion, p.estatus, \r\n"
    		+ "v.titulo as titulo_vacante, u.nombre as nombre_usuario\r\n"
    		+ "FROM postulaciones p \r\n"
    		+ "LEFT JOIN vacantes v ON p.id_vacantes = v.id_vacantes\r\n"
    		+ "LEFT JOIN usuarios u ON p.id_usuario = u.id_usuario;";
    private static final String searchPostulaciones = "SELECT p.id as id_postulacion, p.id_vacantes, p.id_usuario, p.fecha_postulacion, p.estatus FROM postulaciones p INNER JOIN vacantes v ON p.id_vacantes = v.id INNER JOIN usuarios u ON p.id_usuario = u.id WHERE p.estatus LIKE ? OR u.nombre LIKE ? OR v.titulo LIKE ?";
    private static final String countPostulaciones = "SELECT COUNT(*) AS total FROM postulaciones";
    private static final String deletePostulaciones = "DELETE FROM postulaciones where id_postulacion= ?";
    private static final String updatePostulaciones = "UPDATE postulaciones \r\n"
    		+ "SET id_vacantes = ?, id_usuario = ?, fecha_postulacion = ?, estatus = ? \r\n"
    		+ "WHERE id_postulacion = ?";
    
    public boolean insertarPostulacion(Postulacion postulacion) {
        // Es buena práctica verificar si ya existe una postulación previa para este par Usuario-Vacante
        
        try (Connection con = ConexionDB.conectar(); 
             PreparedStatement ps = con.prepareStatement(insertarDatos)) {
            
            // Seteamos los valores desde los objetos internos
            ps.setInt(1, postulacion.getVacante().getId());
            ps.setInt(2, postulacion.getUsuario().getId());
            
            // Si la fecha viene nula en el objeto, usamos la fecha actual del sistema
            if (postulacion.getFechaPostulacion() != null) {
                ps.setDate(3, postulacion.getFechaPostulacion());
            } else {
                ps.setDate(3, new java.sql.Date(System.currentTimeMillis()));
            }
            
            // Estatus inicial por defecto suele ser 'pendiente'
            ps.setString(4, postulacion.getEstatus() != null ? postulacion.getEstatus() : "pendiente");
            
            // Retorna true si se insertó al menos una fila
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error en insertarPostulacion: " + e.getMessage());
            // Si hay un error de llave duplicada (Unique Constraint en DB), aquí saltará
            return false;
        }
    }
    
    public Postulacion buscarPorID(int id) {
        Postulacion postulacion = null; 
        try(Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(selectPorId)){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                int idVacante = rs.getInt("id_vacantes"); // CORREGIDO AQUÍ
                int idUsuario = rs.getInt("id_usuario");
                Date fechaPost = rs.getDate("fecha_postulacion");
                String status = rs.getString("estatus");
                
                Vacante vacante = new Vacante();
                vacante.setId(idVacante);
                Usuario usuario = new Usuario();
                usuario.setId(idUsuario);
                
                postulacion = new Postulacion(id, vacante, usuario, fechaPost, status);
            }
        } catch(SQLException e) {
            System.out.println("Error en buscarPorID:");
            e.printStackTrace();
        }
        return postulacion;
    }
    
    public List<Postulacion> ListaPostulaciones(){
        List<Postulacion> postulaciones = new ArrayList<>();
        try(Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(selectPostulaciones)){
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                int idPost = rs.getInt("id_postulacion");
                int idVacante = rs.getInt("id_vacantes");
                int idUsuario = rs.getInt("id_usuario");
                Date fechaPost = rs.getDate("fecha_postulacion");
                String status = rs.getString("estatus");
                
                // Aquí la magia: rellenamos los objetos internos
                Vacante vacante = new Vacante();
                vacante.setId(idVacante);
                vacante.setTitulo(rs.getString("titulo_vacante")); // Asegúrate que Vacante tenga setTitulo
                
                Usuario usuario = new Usuario();
                usuario.setId(idUsuario);
                usuario.setNombre(rs.getString("nombre_usuario")); // Asegúrate que Usuario tenga setNombre
                
                postulaciones.add(new Postulacion(idPost, vacante, usuario, fechaPost, status));
            }
        } catch(SQLException e) {
            System.out.println("Error en ListaPostulaciones:");
            e.printStackTrace();
        }
        return postulaciones;
    }
    
    public boolean borrarPostulacion(int id) {
        boolean borrado = false;
        try(Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(deletePostulaciones)){
            ps.setInt(1, id);
            borrado = ps.executeUpdate() > 0;
        } catch(SQLException e){
            System.out.println("Error en borrarPostulacion:");
            e.printStackTrace();
        }
        return borrado;
    }
    
    public List<Postulacion> buscarPorDato(String buscar){
        List<Postulacion> postulaciones = new ArrayList<>();
        try(Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(searchPostulaciones)){
            String like = "%" + buscar + "%";
            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                int idPost = rs.getInt("id_postulacion");
                int idVacante = rs.getInt("id_vacantes"); // CORREGIDO AQUÍ
                int idUsuario = rs.getInt("id_usuario");
                Date fechaPost = rs.getDate("fecha_postulacion");
                String status = rs.getString("estatus");
        
                Vacante vacante = new Vacante();
                vacante.setId(idVacante);
                Usuario usuario = new Usuario();
                usuario.setId(idUsuario);
                
                postulaciones.add(new Postulacion(idPost, vacante, usuario, fechaPost, status));
            }
        } catch(SQLException e) {
            System.out.println("Error en buscarPorDato:");
            e.printStackTrace();
        }
        return postulaciones;
    }
    
    public int totalPostulaciones() {
        int total = 0;
        try(Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(countPostulaciones)){
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                total = rs.getInt("total");
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public boolean editarPostulacion(Postulacion postulacion){
        boolean actualizada = false;
        try (Connection connection = ConexionDB.conectar(); PreparedStatement ps = connection.prepareStatement(updatePostulaciones)) {
            ps.setInt(1, postulacion.getVacante().getId());
            ps.setInt(2, postulacion.getUsuario().getId());
            ps.setDate(3, postulacion.getFechaPostulacion());
            ps.setString(4, postulacion.getEstatus());
            ps.setInt(5, postulacion.getId());

            actualizada = ps.executeUpdate() > 0;
        } catch(SQLException e) {
            System.out.println("Error en editarPostulacion:");
            e.printStackTrace();
        }
        return actualizada;
    }

    public List<Postulacion> listarPorUsuario(int idUsuario) {
        List<Postulacion> postulaciones = new ArrayList<>();
        String sql = "SELECT p.id as id_postulacion, p.id_vacantes, p.id_usuario, p.fecha_postulacion, p.estatus "
                   + "FROM postulaciones p "
                   + "INNER JOIN vacantes v ON p.id_vacantes = v.id "
                   + "INNER JOIN usuarios u ON p.id_usuario = u.id "
                   + "WHERE p.id_usuario = ?"; 

        try (Connection con = ConexionDB.conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int idPost = rs.getInt("id_postulacion");
                int idVacante = rs.getInt("id_vacantes"); // CORREGIDO AQUÍ
                int idUsuarioDb = rs.getInt("id_usuario");
                Date fecha = rs.getDate("fecha_postulacion");
                String status = rs.getString("estatus");

                Vacante vacante = new Vacante();
                vacante.setId(idVacante);
                Usuario usuario = new Usuario();
                usuario.setId(idUsuarioDb);

                postulaciones.add(new Postulacion(idPost, vacante, usuario, fecha, status));
            }
        } catch (SQLException e) {
            System.out.println("Error en listarPorUsuario:");
            e.printStackTrace();
        }
        return postulaciones;
    }
}