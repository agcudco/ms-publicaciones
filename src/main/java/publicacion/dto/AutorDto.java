package publicacion.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AutorDto {
    private String nombre;
    private String apellido;
    private String nacionalidad;
    private String institucion;
    private String email;
    private String biografia;
}
