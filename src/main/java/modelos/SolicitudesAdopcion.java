package modelos;

import java.util.Date;

public class SolicitudesAdopcion {
    private int idSolicitud;
    private int idAdoptante;
    private int idAnimal;
    private Date fechaSolicitud;
    private String estado;

    public SolicitudesAdopcion() {}

    public SolicitudesAdopcion(int idSolicitud, int idAdoptante, int idAnimal, Date fechaSolicitud, String estado) {
        this.idSolicitud = idSolicitud;
        this.idAdoptante = idAdoptante;
        this.idAnimal = idAnimal;
        this.fechaSolicitud = fechaSolicitud;
        this.estado = estado;
    }

    public int getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(int idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public int getIdAdoptante() {
        return idAdoptante;
    }

    public void setIdAdoptante(int idAdoptante) {
        this.idAdoptante = idAdoptante;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
