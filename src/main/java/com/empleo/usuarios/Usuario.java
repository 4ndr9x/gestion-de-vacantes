package com.empleo.usuarios;

public class Usuario {
	
	private int id;
	private String nombre;
	private String correo;
	private String password;
	private int rol_id;
	
	public Usuario(String nombre, String correo, String password, int rol_id) {
		
		this.nombre = nombre;
		this.correo = correo;
		this.password = password;
		this.rol_id = rol_id;
		
	}
	
	public Usuario() {
		
	}
	

	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
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
	
		
	}
	
