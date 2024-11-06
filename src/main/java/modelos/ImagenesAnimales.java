package modelos;

import java.util.Date;

public class ImagenesAnimales {
    private int idImagen;
    private int idAnimal;
    private String nombreImagen;
    private String tipoImagen;
    private String imagen; // Almacena la imagen en formato Base64
    private Date fechaSubida;

    public ImagenesAnimales() {}

    public ImagenesAnimales(int idImagen, int idAnimal, String nombreImagen, String tipoImagen, String imagen, Date fechaSubida) {
        this.idImagen = idImagen;
        this.idAnimal = idAnimal;
        this.nombreImagen = nombreImagen;
        this.tipoImagen = tipoImagen;
        this.imagen = imagen;
        this.fechaSubida = fechaSubida;
    }

    public int getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(int idImagen) {
        this.idImagen = idImagen;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public String getNombreImagen() {
        return nombreImagen;
    }

    public void setNombreImagen(String nombreImagen) {
        this.nombreImagen = nombreImagen;
    }

    public String getTipoImagen() {
        return tipoImagen;
    }

    public void setTipoImagen(String tipoImagen) {
        this.tipoImagen = tipoImagen;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public Date getFechaSubida() {
        return fechaSubida;
    }

    public void setFechaSubida(Date fechaSubida) {
        this.fechaSubida = fechaSubida;
    }
}
