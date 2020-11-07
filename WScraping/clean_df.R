# Este fichero definirá la funcíon que cargará el data.frame generado por las funciones del script "scrap" y lo limpiará.

# Carga intermedia de pruebas
# data <- read.csv("./WScraping/data_procesos_intermedios/BD_peliculas_full.csv")


clean_BD <- function(data){
        
        # Creamos la base datos final
        BD_filmaffinity_top30 <- data.frame("url" = data$id_pelicula)
        
        # Sacar los id
        BD_filmaffinity_top30$id <- str_extract(data$id_pelicula, "[0-9]{6}")
        
        # Generos del top30
        generos <- data.frame("AC" = "Accion",
                              "AN" = "Animacion",
                              "AV" = "Aventuras",
                              "BE" = "Belico",
                              "C-F" = "Ciencia ficcion",
                              "F-N" = "Cine negro",
                              "CO" = "Comedia",
                              "DR" = "Drama",
                              "FAN" = "Fantástico",
                              "INF" = "Infantil",
                              "INT" = "Intriga",
                              "MU" = "Musical",
                              "RO" = "Romance",
                              "TE" = "Terror",
                              "TH" = "Thriller",
                              "WE" = "Western")
        
        generos_extraccion <- c()  # Inicializamos un vector para guardar los nombres
        
        # Convertimos nombres para evitar fallos
        data$genero.x <- str_replace(data$genero.x, "C-F", "C.F")
        data$genero.x <- str_replace(data$genero.x, "F-N", "F.N")
        
        # Obtenemos dicha información de la BD original convirtiendo las abreviaturas
        for (i in data$genero.x){
                genero_film <- generos %>% pull(i)
                generos_extraccion <- append(generos_extraccion, genero_film)
        }
        BD_filmaffinity_top30$genero_top30 <- generos_extraccion
        
        # Posición dentro del top30
        BD_filmaffinity_top30$posicion_top30 <- data$posicion
        
        
        # Nombre en España
        nombre_peliculas <- str_remove(data$nombre, "\\([:digit:]{4}\\)")
        nombre_peliculas <- trimws(nombre_peliculas)
        BD_filmaffinity_top30$titulo <- nombre_peliculas
        
        # Titulo original
        BD_filmaffinity_top30$titulo_VO <- data$titulo_original
        
        # Año
        BD_filmaffinity_top30$anio <- data$anio
        
        # Duración
        duracion_peliculas <- str_remove(data$duracion, " min.")
        BD_filmaffinity_top30$duracion <- duracion_peliculas
        
        # País
        BD_filmaffinity_top30$pais <- data$pais
        
        # Direccion
        BD_filmaffinity_top30$direccion <- data$direccion
        
        # Direccion, musica, fotografia y reparto
        BD_filmaffinity_top30$guion <- data$guion
        BD_filmaffinity_top30$musica <- data$musica
        BD_filmaffinity_top30$fotografia <- data$fotografia
        BD_filmaffinity_top30$reparto <- data$reparto
        BD_filmaffinity_top30$productora <- data$productora
        
        # Sinopsis, puntuacio media/mejor/peor, votos y numero de criticas
        BD_filmaffinity_top30$sinopsis <- data$sinopsis
        BD_filmaffinity_top30$puntuacion_media <- data$puntuacion_media
        BD_filmaffinity_top30$mejor_puntuacion <- data$mejor_puntuacion
        BD_filmaffinity_top30$peor_puntuacion <- data$peor_puntuacion
        BD_filmaffinity_top30$votos <- data$votos
        BD_filmaffinity_top30$num_criticas <- data$num_criticas
        
        # Tags -Géeneros
        generos_peliculas <- gsub("\\s+", " ", str_trim(data$genero.y))
        generos_peliculas <- gsub(" \\|", ".", str_trim(generos_peliculas))
        generos_peliculas
        
        
        generos_peliculas_df <- str_split_fixed(generos_peliculas, "\\.[:blank:]",13)
        
        generos_names <- c()
        for (i in 1:13){
                name_i <- paste("tag_", i, sep = "")
                generos_names <- append(generos_names, name_i)
        }
        colnames(generos_peliculas_df) <- generos_names
        
        BD_filmaffinity_top30 <- cbind(BD_filmaffinity_top30, generos_peliculas_df)
        
        # Organizamos las columnas para devolverlo de forma más visual
        
        BD_filmaffinity_top30 <- BD_filmaffinity_top30 %>% select(id, genero_top30, posicion_top30, titulo, titulo_VO, duracion, pais, 
                                                                  puntuacion_media, votos, num_criticas, mejor_puntuacion, peor_puntuacion,
                                                                  direccion, guion, musica, fotografia, reparto, productora, sinopsis, url, 
                                                                  tag_1, tag_2, tag_3, tag_4, tag_5, tag_6, tag_7, tag_8, tag_9, tag_10, tag_11, tag_12, tag_13)
        
        
        return(BD_clean = BD_filmaffinity_top30)
}


