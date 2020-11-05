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
# for (j in BD_peliculas_top$id_pelicula){
#         target_page <- read_html(target_url)
#         
# }




# Ejemplo para no ejecutarlo todo junto
id_url_extract <- BD_peliculas_top$id_pelicula[4]

BD_id_prueba <- scrap_film(id_url = id_url_extract)
BD_id_prueba

BD_peliculas_full <- data.frame()
# COjo solo 5 peliculas
for (m in BD_peliculas_top$id_pelicula[1:8]){
        BD_id_scrap <- scrap_film(id_url = m)
        BD_peliculas_full <- bind_rows(BD_peliculas_full, BD_id_scrap)
        Sys.sleep(1)
}

BD_peliculas_full


BD_peliculas_final <- right_join(BD_peliculas_top, BD_peliculas_full, by = "id_pelicula")

write.csv2(BD_peliculas_final, file = "./WScraping/BD_peliculas.csv", row.names = FALSE)
