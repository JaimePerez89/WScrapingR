# PRÁCTICA 1: WEB SCRAPING

# Antecedentes

El objetivo de este repositorio es dar respuesta a la práctica 1 de la asignatura Tipología y ciclo de vida de los datos, impartida dentro del Máster en Ciencia de Datos de la UOC. Con la realización de dicha práctica se pretende aprender a identificar los datos relevantes por un proyecto analítico y usar las herramientas de extracción de datos.


# Descripción

La actividad ha sido desarrollada de forma conjunta por Ana Hubel y Jaime Pérez Ordieres. En dicha actividad se aplican técnicas de web scraping mediante el lenguaje de programación R para extraer datos de la página Filmaffinity y crear una base de datos que recoja las características relacionadas con las películas más relevantes según su género.

El objetivo final será la extracción de los datos características (nombre, pais, género, duración, etiquetas, número de votos, etc.) de las películas y series actualmente en el Top 30 según los géneros a los que pertenecen. De esta forma se espera generar un dataset limpio que será utilizado caracterizar y dar respuesta a una serie de preguntas, como por ejemplo:

*¿En qué países se producen las mejores películas?*

*¿Qué generos reciben unas puntuaciones más elevadas?*

*¿Cómo se relaciona el número de votos y el de críticas con la puntuación obtenida?*

*¿Tiene algo que ver la longitud de la sinopsis con el número de votos o la puntuación que recibe una película?*

*¿Qué tags se encuentran más relacionados con cada género de película?*

En conclusión, la principal pregunta a la que se pretende responder es *¿Están esas películas en esa posición porque de verdad son muy buenas o hay algún tipo de sesgo que las hace estar ahí?*

> Tanto las preguntas, como las respuestas al propio enunciado de la práctica, se encuentra recogidos en el archivo html generado por /WScraping/results.Rmd


# Contenido del repositorio

* WScraping
    - data_procesos_intermedios: contiene bases de datos intermedias que se han ido limpiando/ajustando hasta llegar a nuestra base de datos final.
    - main.R: fichero que ejecuta todo el proceso de carga y limpieza
    - scrap.R: contiene el programa que descarga los archivos de la página de imbd
    - clean_df.R: contiene el código que limpia el dataframe y genera el .csv final
    - results.Rmd: este fichero da respuesta a los principales objetivos y requisitos de la práctica. Se carga y analiza el dataframe limpio. Además, se presenta el contexto en el que se ha recopilado la información, se realizan representaciones gráficas del contenido, estadísticas básicas y descripciones de las variables, resultados de correlaciones, clasificaciones, etc.
    - results.html: documento html en el que se recoge el informe final de la práctica.
    - BD_filmaffinity_top30.csv: base de datos final generada en main.R

* test: contiene ficheros donde se realizan pruebas de scraping previas a la generación de los ficheros principales.

* License: se ha elegido la licencia MIT para el software desarrollado. Esta licencia no tiene restricciones, permite el uso, copia, modificación, integración con otro software, publicación, distribución, sublicenciamiento y uso comercial del código. Por otro lado, el dataset obtenido mediante el uso del software se encuentran bajo licencia creative commons by-nc-sa 4.0. Esta licencia permite copiar y redistribuir el material en cualquier medio o formato y adaptarlo o modificarlo bajo ciertas condiciones (https://creativecommons.org/licenses/by-nc-sa/4.0/)

# Recusos y bibliografía utilizada

* Simon Munzert, Christian Rubba, Peter Meißner, Dominic Nyhuis. (2015). Automated Data Collection with R: A Practical Guide to Web Scraping and Text Mining. John Wiley & Sons.
