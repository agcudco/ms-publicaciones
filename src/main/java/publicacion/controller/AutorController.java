package publicacion.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import publicacion.dto.AutorDto;
import publicacion.dto.ResponseDto;
import publicacion.service.AutorService;

import java.util.List;

@RestController
@RequestMapping("/autores")
public class AutorController {
    @Autowired
    private AutorService autorService;

    // 🟢 CREAR AUTOR
    @PostMapping
    public ResponseDto crear(@RequestBody AutorDto dto) {
        return autorService.crearAutor(dto);
    }

    // 🔍 LISTAR TODOS LOS AUTORES
    @GetMapping
    public List<ResponseDto> listar() {
        return autorService.listarAutores();
    }

    // 🔍 OBTENER AUTOR POR ID
    @GetMapping("/{id}")
    public ResponseDto obtenerPorId(@PathVariable Long id) {
        return autorService.obtenerAutorPorId(id);
    }

    // 🟡 ACTUALIZAR AUTOR
    @PutMapping("/{id}")
    public ResponseDto actualizar(@PathVariable Long id, @RequestBody AutorDto dto) {
        return autorService.actualizarAutor(id, dto);
    }

    // 🔴 ELIMINAR AUTOR
    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        autorService.eliminarAutor(id);
    }
}
