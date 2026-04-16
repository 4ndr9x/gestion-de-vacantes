package com.empleo.usuarios;

public class Empresa {
	
	private int id_empresa;
	private String nombre;
	private String correo;
	private String password;
	private String rnc;
	private String descripcion;
	private String contacto;
	private int rol_id;
	private String estado;
	
	public Empresa(int id_empresa, String nombre, String correo, String password, String rnc, String descripcion, String contacto,
			int rol_id) {
		
		this.id_empresa = id_empresa;
		this.nombre = nombre;
		this.correo = correo;
		this.password = password;
		this.rnc = rnc;
		this.descripcion = descripcion;
		this.contacto = contacto;
		this.rol_id = rol_id;
	}

	public Empresa() {
		
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRol_id() {
		return rol_id;
	}

	public void setRol_id(int rol_id) {
		this.rol_id = rol_id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getRnc() {
		return rnc;
	}

	public void setRnc(String rnc) {
		this.rnc = rnc;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getContacto() {
		return contacto;
	}

	public void setContacto(String contacto) {
		this.contacto = contacto;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getId_empresa() {
		return id_empresa;
	}

	public void setId_empresa(int id_empresa) {
		this.id_empresa = id_empresa;
	}
	
	
	
	
}
