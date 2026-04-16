package com.empleo.usuarios;

import java.sql.Date;

public class Postulacion {

	private int id;
	private Vacante vacante;
	private Usuario usuario;
	private Date fechaPostulacion;
	private String estatus;

	
	public Postulacion(int id, Vacante vacante, Usuario usuario, Date fechaPostulacion, String estatus) {
		this.id = id;
		this.vacante = vacante;
		this.usuario = usuario;
		this.fechaPostulacion = fechaPostulacion;
		this.estatus = estatus;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		
		this.id= id;
	}
	
	public Vacante getVacante() {
		return vacante;
	}
	
	public void setVacante(Vacante vacante) {
		
		this.vacante= vacante;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		
		this.usuario= usuario;
	}
	
	public Date getFechaPostulacion() {
		return fechaPostulacion;
	}
	
	public void setFechaPostulacion(Date fechaPostulacion) {
		
		this.fechaPostulacion= fechaPostulacion;
	}
	
	public String getEstatus() {
		return estatus;
	}
	
	public void setEstatus(String estatus) {
		
		this.estatus=estatus;
	}

	
}