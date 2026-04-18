package com.empleo.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.empleo.usuarios.Empresa;

public class EmpresaDAO {

    private static final String INSERT_EMPRESA =
            "INSERT INTO empresas (nombre, correo, RNC, descripcion, estado) VALUES (?, ?, ?, ?, 'activa')";

    private static final String SELECT_EMPRESAS =
            "SELECT id_empresa, nombre, correo, RNC, descripcion, estado FROM empresas";

    private static final String UPDATE_EMPRESA =
            "UPDATE empresas SET nombre = ?, correo = ?, RNC = ?, descripcion = ?, estado = ? WHERE id_empresa = ?";

    private static final String DELETE_EMPRESA =
            "DELETE FROM empresas WHERE id_empresa = ?";

    public void registrarEmpresa(Empresa empresa) {
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(INSERT_EMPRESA)) {

            ps.setString(1, empresa.getNombre());
            ps.setString(2, empresa.getCorreo());
            ps.setString(3, empresa.getRnc());
            ps.setString(4, empresa.getDescripcion());

            ps.executeUpdate();
            System.out.println("Éxito: REGISTRAR EMPRESA");

        } catch (SQLException e) {
            System.out.println("Error: REGISTRAR EMPRESA");
            e.printStackTrace();
        }
    }

    public List<Empresa> listarEmpresas() {
        List<Empresa> lista = new ArrayList<>();

        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(SELECT_EMPRESAS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Empresa e = new Empresa();
                e.setId_empresa(rs.getInt("id_empresa"));
                e.setNombre(rs.getString("nombre"));
                e.setCorreo(rs.getString("correo"));
                e.setRnc(rs.getString("RNC"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setEstado(rs.getString("estado"));
                lista.add(e);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public void actualizarEmpresa(Empresa empresa) {
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(UPDATE_EMPRESA)) {

            ps.setString(1, empresa.getNombre());
            ps.setString(2, empresa.getCorreo());
            ps.setString(3, empresa.getRnc());
            ps.setString(4, empresa.getDescripcion());
            ps.setString(5, empresa.getEstado());
            ps.setInt(6, empresa.getId_empresa());

            ps.executeUpdate();
            System.out.println("Éxito: ACTUALIZAR EMPRESA");

        } catch (SQLException e) {
            System.out.println("Error: ACTUALIZAR EMPRESA");
            e.printStackTrace();
        }
    }

    public void eliminarEmpresa(int id) {
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(DELETE_EMPRESA)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Éxito: ELIMINAR EMPRESA");

        } catch (SQLException e) {
            System.out.println("Error: ELIMINAR EMPRESA");
            e.printStackTrace();
        }
    }
}