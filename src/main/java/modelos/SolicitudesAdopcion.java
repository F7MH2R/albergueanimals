package modelos;

import java.util.Date;

public class SolicitudesAdopcion {
    private int idSolicitud;
    private int idAdoptante;
    private int idAnimal;
    private Date fechaSolicitud;
    private String estado;
    private String nombreAnimal; // Nuevo atributo
    private String especie;       // Nuevo atributo
    private String raza;          // Nuevo atributo
    private int edad;             // Nuevo atributo
    private String estadoSalud;   // Nuevo atributo
    private String imagenUrl;     // Nuevo atributo para almacenar la URL o Base64 de la imagen

    public SolicitudesAdopcion() {}

    public SolicitudesAdopcion(int idSolicitud, int idAdoptante, int idAnimal, Date fechaSolicitud, String estado) {
        this.idSolicitud = idSolicitud;
        this.idAdoptante = idAdoptante;
        this.idAnimal = idAnimal;
        this.fechaSolicitud = fechaSolicitud;
        this.estado = estado;
    }

    // Getters y Setters para los nuevos atributos
    public String getNombreAnimal() {
        return nombreAnimal;
    }

    public void setNombreAnimal(String nombreAnimal) {
        this.nombreAnimal = nombreAnimal;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public String getRaza() {
        return raza;
    }

    public void setRaza(String raza) {
        this.raza = raza;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getEstadoSalud() {
        return estadoSalud;
    }

    public void setEstadoSalud(String estadoSalud) {
        this.estadoSalud = estadoSalud;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }

    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }

    // Resto de getters y setters existentes
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
