package com.empleo.usuarios;

import java.math.BigDecimal;
import java.sql.Date;

public class Vacante {
	
	private int id;
	private String titulo;
	private String descripcion;
	private String estado;
	private Date fecha_limite;
	private BigDecimal salario;
	
	public Vacante() {
		
	}
	
	public Vacante (int id, String titulo, String descripcion, String modalidad, BigDecimal salario, Date fecha_limite, String estado) {
		this.id = id;
		this.titulo = titulo;
		this.descripcion = descripcion;
		this.salario = salario;
		this.fecha_limite = fecha_limite;
		this.estado = estado;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitulo() {
		return titulo;
	}
	
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public BigDecimal getSalario() {
		return salario;
	}

	public void setSalario(BigDecimal salario) {
		this.salario = salario;
	}
	
	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Date getFecha_limite() {
		return fecha_limite;
	}

	public void setFecha_limite(Date fecha_limite) {
		this.fecha_limite = fecha_limite;
	}
}