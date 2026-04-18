package com.empleo.usuarios;

import java.math.BigDecimal;
import java.sql.Date;

public class Vacante {
	
	private int id;
	private int idEmpresa;
	private String nombreEmpresa;
	private String correoEmpresa; // <-- NUEVO: para mostrar contacto al usuario
	private String titulo;
	private String descripcion;
	private String estado;
	private Date fechaLimite;
	private BigDecimal salario;
	
	public Vacante() {}
	
	public Vacante(int id, String nombreEmpresa, int idEmpresa, String titulo, String descripcion, BigDecimal salario, String estado, Date fechaLimite) {
		this.id = id;
		this.nombreEmpresa = nombreEmpresa;
		this.idEmpresa = idEmpresa;
		this.titulo = titulo;
		this.descripcion = descripcion;
		this.salario = salario;
		this.fechaLimite = fechaLimite;
		this.estado = estado;
	}
	
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public String getNombreEmpresa() { return nombreEmpresa; }
	public void setNombreEmpresa(String nombreEmpresa) { this.nombreEmpresa = nombreEmpresa; }

	public String getCorreoEmpresa() { return correoEmpresa; }
	public void setCorreoEmpresa(String correoEmpresa) { this.correoEmpresa = correoEmpresa; }

	public String getTitulo() { return titulo; }
	public void setTitulo(String titulo) { this.titulo = titulo; }

	public String getDescripcion() { return descripcion; }
	public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

	public BigDecimal getSalario() { return salario; }
	public void setSalario(BigDecimal salario) { this.salario = salario; }

	public String getEstado() { return estado; }
	public void setEstado(String estado) { this.estado = estado; }

	public int getIdEmpresa() { return idEmpresa; }
	public void setIdEmpresa(int idEmpresa) { this.idEmpresa = idEmpresa; }

	public Date getFechaLimite() { return fechaLimite; }
	public void setFechaLimite(Date fechaLimite) { this.fechaLimite = fechaLimite; }
}