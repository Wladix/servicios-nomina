package cl.app.nomina.serviciosnomina.entities;

import javax.persistence.Entity;

/**
 *
 * @author Resorte
 */

@Entity
public class Pais {
    
    //Atributos
    private String id;
    private String nombre;
    
    public Pais(){        
    }
    
    public Pais(String id){
        this.id = id;
    }
    
    public Pais(String id, String nombre){
        this.id = id;
        this.nombre = nombre;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
}
