package modelos;

import java.util.Date;

public class HistorialMedico {
    private int idHistorial;
    private int idAnimal;
    private Date fecha;
    private String tratamiento;
    private String descripcion;

    public HistorialMedico() {}

    public HistorialMedico(int idHistorial, int idAnimal, Date fecha, String tratamiento, String descripcion) {
        this.idHistorial = idHistorial;
        this.idAnimal = idAnimal;
        this.fecha = fecha;
        this.tratamiento = tratamiento;
        this.descripcion = descripcion;
    }

    public int getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(int idHistorial) {
        this.idHistorial = idHistorial;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
