package modelos;

import java.util.Date;

public class Vacunas {
    private int idVacuna;
    private int idAnimal;
    private String nombreVacuna;
    private Date fechaAplicacion;
    private String ml; // Nuevo atributo para la cantidad en ml

    public Vacunas(int idVacuna, int idAnimal, String nombreVacuna, Date fechaAplicacion, String ml) {
        this.idVacuna = idVacuna;
        this.idAnimal = idAnimal;
        this.nombreVacuna = nombreVacuna;
        this.fechaAplicacion = fechaAplicacion;
        this.ml = ml;
    }

    // Getters y Setters
    public int getIdVacuna() {
        return idVacuna;
    }

    public void setIdVacuna(int idVacuna) {
        this.idVacuna = idVacuna;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public String getNombreVacuna() {
        return nombreVacuna;
    }

    public void setNombreVacuna(String nombreVacuna) {
        this.nombreVacuna = nombreVacuna;
    }

    public Date getFechaAplicacion() {
        return fechaAplicacion;
    }

    public void setFechaAplicacion(Date fechaAplicacion) {
        this.fechaAplicacion = fechaAplicacion;
    }

    public String getMl() {
        return ml;
    }

    public void setMl(String ml) {
        this.ml = ml;
    }
}
