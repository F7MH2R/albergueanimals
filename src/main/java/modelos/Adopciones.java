package modelos;

import java.util.Date;

public class Adopciones {
    private int idAdopcion;
    private int idAnimal;
    private int idAdoptante;
    private Date fechaAdopcion;
    private String estado; // Nuevo atributo estado

    public Adopciones() {}

    public Adopciones(int idAdopcion, int idAnimal, int idAdoptante, Date fechaAdopcion) {
        this.idAdopcion = idAdopcion;
        this.idAnimal = idAnimal;
        this.idAdoptante = idAdoptante;
        this.fechaAdopcion = fechaAdopcion;
    }

    // Getters y Setters
    public int getIdAdopcion() {
        return idAdopcion;
    }

    public void setIdAdopcion(int idAdopcion) {
        this.idAdopcion = idAdopcion;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public int getIdAdoptante() {
        return idAdoptante;
    }

    public void setIdAdoptante(int idAdoptante) {
        this.idAdoptante = idAdoptante;
    }

    public Date getFechaAdopcion() {
        return fechaAdopcion;
    }

    public void setFechaAdopcion(Date fechaAdopcion) {
        this.fechaAdopcion = fechaAdopcion;
    }

    // Nuevo método getEstado
    public String getEstado() {
        return estado;
    }

    // Nuevo método setEstado
    public void setEstado(String estado) {
        this.estado = estado;
    }
}
