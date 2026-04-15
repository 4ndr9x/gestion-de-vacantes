package com.empleo.usuarios;

import java.math.BigDecimal;
import java.sql.Date;

public class Contratacion {

	private int id;
	private Postulacion postulacion;
	private Date fechaContratoDate;
	private BigDecimal comision;
	
	public Contratacion(int id, Postulacion postulacion, Date fechaContratoDate, BigDecimal comision) {
		this.id = id;
		this.postulacion = postulacion;
		this.fechaContratoDate = fechaContratoDate;
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
	public Date getFechaContratoDate() {
		return fechaContratoDate;
	}
	public void setFechaContratoDate(Date fechaContratoDate) {
		this.fechaContratoDate = fechaContratoDate;
	}
	public BigDecimal getComision() {
		return comision;
	}
	public void setComision(BigDecimal comision) {
		this.comision = comision;
	}
	
	
}
