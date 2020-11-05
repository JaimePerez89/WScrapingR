# El fichero contiene 2 funciones:
#       scrap_top30: extrae las 30 películas del género input
#       scrap_film: dado el link con el id de una película extrae la información disponible


scrap_top30 <- function(genre){
        # Función que extrae el top30 de las películas del género solicitado
        # param genre: character (ej. AC)
        #
        # Posibles valores de entrada:
        #       - Acción: AC
        #       - Animación: AN
        #       - Aventuras: AV
        #       - Bélico: BE
        #       - Ciencia ficción: C-F
        #       - Cine negro: F-N
        #       - Comedia: CO
        #       - Drama: DR
        #       - Fantástico: FN
        #       - Infantil: INF
        #       - Intriga: INT
        #       - Musical: MU
        #       - Romance: RO
        #       - Terror: TE
        #       - Thriller: TH
        #       - Western: WE
        
        posibles_generos <- c("AC", "AN", "AV", "BE", "C-F", "F-N", "CO", "DR", "FAN", "INF", "INT", "MU", "RO", "TE", "TH", "WE")
        
        if (!(genre %in% posibles_generos)){
                mens_error <- "No existe el genero en la plataforma"
                return(mens_error)
        }
        
        url_comun_inicial <- "https://www.filmaffinity.com/es/topgen.php?genre="
        url_comun_final <- "&fromyear=&toyear=&country=&nodoc&notvse"
        pag_a_consultar <- paste(url_comun_inicial, genre, url_comun_final, sep = "")
        
        target_page <- read_html(pag_a_consultar)
        
        nombre_path <- target_page %>%
                html_nodes(xpath = '//*[@id="top-movies"]')
        
        posicion <- nombre_path %>%
                html_nodes("li.position") %>%
                html_text(trim = TRUE)
        
        nombre <- nombre_path %>%
                html_nodes("li.content") %>%
                html_nodes("div.mc-title") %>%
                html_text(trim = TRUE)
        
        id_pelicula <- nombre_path %>%
                html_nodes("li.content") %>%
                html_nodes("div.mc-poster") %>%
                html_nodes("a") %>%
                html_attr("href")
        
        BD_peliculas <- data.frame(
                "genero" = genre, 
                "posicion" = posicion,
                "nombre" = nombre,
                "id_pelicula" = id_pelicula
        )
        
        return(BD_peliculas)
}


scrap_film <- function(id_url){
        # Función que extrae la información de la página de la película input
        # param id_url: character (ej. https://www.filmaffinity.com/es/film811454.html)
        
        target_page <- read_html(id_url)
        
        results <- data.frame("id_pelicula" = id_url)
        
        
        cabecera <- target_page %>%
                html_node("dl.movie-info") %>%
                html_nodes("dt") %>%
                html_text(trim = TRUE)
        
        info <- target_page %>%
                html_node("dl.movie-info") %>%
                html_nodes("dd") %>%
                html_text(trim = TRUE)
        
        BD_pelicula_id <- data.frame(cabecera, info)
        
        # Titulo original
        titulo_original <- BD_pelicula_id %>% filter(cabecera == "Título original") %>% pull(info)
        if(length(titulo_original) == 0){
                titulo_original <- NA
        }
        results <- cbind(results, "titulo_original" = titulo_original)
        
        
        # Año
        anio <- BD_pelicula_id %>% filter(cabecera == "Año") %>% pull(info)
        if(length(anio) == 0){
                anio <- NA
        }
        results <- cbind(results, "anio" = anio)
        
        # Duración
        duracion <- BD_pelicula_id %>% filter(cabecera == "Duración") %>% pull(info)
        if(length(duracion) == 0){
                duracion <- NA
        }
        results <- cbind(results, "duracion" = duracion)
        
        # País
        pais <- BD_pelicula_id %>% filter(cabecera == "País") %>% pull(info)
        if(length(pais) == 0){
                pais <- NA
        }
        results <- cbind(results, "pais" = pais)
        
        # Dirección
        direccion <- BD_pelicula_id %>% filter(cabecera == "Dirección") %>% pull(info)
        if(length(direccion) == 0){
                direccion <- NA
        }
        results <- cbind(results, "direccion" = direccion)
        
        # Guion
        guion <- BD_pelicula_id %>% filter(cabecera == "Guion") %>% pull(info)
        if(length(guion) == 0){
                guion <- NA
        }
        results <- cbind(results, "guion" = guion)
        
        # Música
        musica <- BD_pelicula_id %>% filter(cabecera == "Música") %>% pull(info)
        if(length(musica) == 0){
                musica <- NA
        }
        results <- cbind(results, "musica" = musica)
        
        # Fotografía
        fotografia <- BD_pelicula_id %>% filter(cabecera == "Fotografía") %>% pull(info)
        if(length(fotografia) == 0){
                fotografia <- NA
        }
        results <- cbind(results, "fotografia" = fotografia)
        
        # Reparto
        reparto <- BD_pelicula_id %>% filter(cabecera == "Reparto") %>% pull(info)
        if(length(reparto) == 0){
                reparto <- NA
        }
        results <- cbind(results, "reparto" = reparto)
        
        # Productora
        productora <- BD_pelicula_id %>% filter(cabecera == "Productora") %>% pull(info)
        if(length(productora) == 0){
                productora <- NA
        }
        results <- cbind(results, "productora" = productora)
        
        # Género
        genero <- BD_pelicula_id %>% filter(cabecera == "Género") %>% pull(info)
        if(length(genero) == 0){
                genero <- NA
        }
        results <- cbind(results, "genero" = genero)
        
        # Sinopsis
        sinopsis <- BD_pelicula_id %>% filter(cabecera == "Sinopsis") %>% pull(info)
        if(length(sinopsis) == 0){
                sinopsis <- NA
        }
        results <- cbind(results, "sinopsis" = sinopsis)
        
        # Puntuación media
        puntuacion_media <- target_page %>% 
                html_nodes(xpath = '//*[@id="movie-rat-avg"]') %>%
                html_text(trim = TRUE)
        results <- cbind(results, "puntuacion_media" = puntuacion_media)
        
        # Mejor puntuación
        mejor_puntuacion <- target_page %>% 
                html_nodes(xpath = '//*[@id="rat-avg-container"]/meta[1]') %>%
                html_attr("content")
        results <- cbind(results, "mejor_puntuacion" = mejor_puntuacion)
        
        # Peor puntuación
        peor_puntuacion <- target_page %>% 
                html_nodes(xpath = '//*[@id="rat-avg-container"]/meta[2]') %>%
                html_attr("content")
        results <- cbind(results, "peor_puntuacion" = peor_puntuacion)
        
        # Votos
        votos <- target_page %>% 
                html_nodes(xpath = '//*[@id="movie-count-rat"]/span') %>%
                html_text(trim = TRUE)
        results <- cbind(results, "votos" = votos)
        
        # Número de críticas
        num_criticas <- target_page %>% 
                html_nodes(xpath = '//*[@id="rat-avg-container"]/meta[3]') %>%
                html_attr("content")
        results <- cbind(results, "num_criticas" = num_criticas)
        
        # 
        # results <- data.frame("id_pelicula" = id,
        #                      "titulo_original" = titulo_original,
        #                      "anio" = anio,
        #                      "duracion" = duracion,
        #                      "puntuacion_media" = puntuacion_media,
        #                      "mejor_puntuacion" = mejor_puntuacion,
        #                      "peor_puntuacion" = peor_puntuacion,
        #                      "votos" = votos,
        #                      "num_criticas" = num_criticas,
        #                      "pais" = pais,
        #                      "direccion" = direccion,
        #                      "guion" = guion,
        #                      "musica" = musica,
        #                      "fotografia" = fotografia,
        #                      "reparto" = reparto,
        #                      "productora" = productora,
        #                      "genero" = genero,
        #                      "sinopsis" = sinopsis)
        
        return(results)
        
}
