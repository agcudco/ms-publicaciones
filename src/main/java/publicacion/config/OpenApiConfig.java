package publicacion.config;

import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                .group("publicaciones-api")
                .pathsToMatch("/autores/**", "/libros/**", "/articulos/**")
                .build();
    }
}
