package modelos;

import java.util.Date;

public class HistorialMedico {
    private int idHistorial;
    private int idAnimal;
    private Date fecha;
    private String tratamiento;
    private String descripcion;
    private String estadoTratamiento; // Nuevo atributo para el estado del tratamiento

    public HistorialMedico(int idHistorial, int idAnimal, Date fecha, String tratamiento, String descripcion, String estadoTratamiento) {
        this.idHistorial = idHistorial;
        this.idAnimal = idAnimal;
        this.fecha = fecha;
        this.tratamiento = tratamiento;
        this.descripcion = descripcion;
        this.estadoTratamiento = estadoTratamiento;
    }

    // Getters y Setters
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

    public String getEstadoTratamiento() {
        return estadoTratamiento;
    }

    public void setEstadoTratamiento(String estadoTratamiento) {
        this.estadoTratamiento = estadoTratamiento;
    }
}
