package com.empleo.usuarios;

import java.math.BigDecimal;
import java.sql.Date;

public class Contratacion {

	private int id;
	private Postulacion postulacion;
	private Date fechaContrato;
	private BigDecimal comision;
	
	public Contratacion(int id, Postulacion postulacion, Date fechaContrato, BigDecimal comision) {
		this.id = id;
		this.postulacion = postulacion;
		this.fechaContrato = fechaContrato;
		this.comision = comision;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Postulacion getPostulacion() {
		return postulacion;
	}
	public void setPostulacion(Postulacion postulacion) {
		this.postulacion = postulacion;
	}
	public Date getFechaContrato() {
		return fechaContrato;
	}
	public void setFechaContrato(Date fechaContrato) {
		this.fechaContrato = fechaContrato;
	}
	public BigDecimal getComision() {
		return comision;
	}
	public void setComision(BigDecimal comision) {
		this.comision = comision;
	}
	
	
}
