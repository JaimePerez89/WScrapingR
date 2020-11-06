# Hacemos accesibles las funciones creadas
source("./WScraping/scrap.R")


# Cargamos las librerías. En caso de no tenerlas instaladas, se descargarán
PACKAGES <- c("dplyr", "rvest", "ggplot2", "tibble", "knitr", "stringr")
inst <- match(PACKAGES, .packages(all=TRUE))
need <- which(is.na(inst))
if (length(need) > 0) install.packages(PACKAGES[need], repos = "http://cran.us.r-project.org")
lapply(PACKAGES, require, character.only=T)


# Llamamos la función scrap_top30 para cada una de los géneros disponibles
generos_disponibles <- c("AC", "AN", "AV", "BE", "C-F", "F-N", "CO", "DR", "FAN", "INF", "INT", "MU", "RO", "TE", "TH", "WE")
BD_peliculas_top <- data.frame() # Creo un data.frame vacio sobre el que añadir filas

for (i in generos_disponibles){
        # Llamo a la función
        BD_peliculas_scrap <- scrap_top30(i)
        # Añado filas a base de datos
        BD_peliculas_top <- bind_rows(BD_peliculas_top, BD_peliculas_scrap)
        # Meto un retraso de 1 segundo para no saturar el servidor consultado
        Sys.sleep(1)
}


# Creamos un csv con los resultados
write.csv(BD_peliculas_top, file = "./WScraping/BD_inicial_top30.csv", row.names = FALSE)



# Para cada uno de los id obtenidos, se extrae la información relacionada con la película
BD_peliculas <- data.frame()  # Creamos un dataframe vacio para ir almancenando la información
for (m in BD_peliculas_top$id_pelicula){
        BD_id <- scrap_film(id_url = m)
        BD_peliculas <- rbind(BD_peliculas, BD_id)
        Sys.sleep(0.5)
}

# Creamos un csv con los resultados
write.csv(BD_peliculas, file = "./WScraping/BD_peliculas.csv", row.names = FALSE)


# Unimos los dos dataframes en una único archivo, que será nuestra base de datos final
# Para ello eliminamos previamente las películas duplicadas
BD_peliculas_clean <- BD_peliculas %>% distinct()
BD_peliculas_full <- merge(BD_peliculas_top, BD_peliculas_clean, by = "id_pelicula")

# Lo almacenamos en un archivo
write.csv(BD_peliculas_full, file = "./WScraping/BD_peliculas_full.csv", row.names = FALSE)


# Proceso de limpieza de la Base de datos