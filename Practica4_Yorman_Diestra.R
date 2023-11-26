# Radar TOP TRUMPS
#Para poder realizar el grafico en Radar es necesario instalar el paquete `ggradar`, pero debido a que este se encuentra en un repositorio de github, primero es necesario la instalacion del paquete `devtools`
install.packages("devtools")
devtools::install_github("ricardo-bion/ggradar", dependencies = TRUE)

#Al instalar los paquetes es necesario hacer uso de las librerias `fmsb` la cual nos permite realizar graficos en Radar, `ggradar` la cual nos permite realizar el radar especificado en la práctica y la librerìa `fmsb` para realizar ciertas modificaciones al data frame del "Top Trumps".
library(fmsb)
library(ggradar)
library(dplyr)
library(readr)

#Para hacer el gráfico primero se deberá eliminar la columna de roles de los personajes debido a que al ser una variable cualitativa no se considera como una variable compatible con las demás datos del gráfico, las cuales al ser cuantitativas se pueden representar y comparar. Al eliminar la columna **Rol**, el data frame restante se guarda en una variable llamada **Baraja**

library(readr)
top_trumps <- read_delim("top_trumps.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
top_trumps <- top_trumps %>% select('Nombre','Magia','Astucia','Coraje','Sabiduria','Templanza','Rol')
baraja <- top_trumps %>% mutate(Rol = NULL)

#Despues de esto se crea un vector llamado **Pers**, el cual contendrá los nombres de los personajes que se desea mostrar en el Radar.

pers <- c('Profesor Albus Dumbledor','Dementor','Argus Filch','Sirius Black','Dudley Dursley')

#Para poder hacer uso de la funcion ggradar hace falta un data frame que contenga solo estos personajes. Este data frame lo llamo **baraja_filtred**
  
baraja_filtred <- baraja %>% filter(Nombre %in% pers)

#Para concluir se realiza el gráfico en Radar, haciendo uso de la funcion **ggradar** y pasando como argumentos el data frame, los valores **grid.min** y **grid.max** que sirve para establecer el lmité entre los cuales oscilan los valores de las distintas variables de los personajes.

ggradar(baraja_filtred, grid.min = 1, grid.max = 100)

# GGIMG TOP TRUMPS
# Para poder realizar el gráfico indicado en la práctica, es necesario instalar el paquete `ggimg` el cual nos permite crear un gráfico en el cual los puntos de dispersión donde coinciden los ejes *X* y *Y* son reemplazados por imagenes para cada fila correspondiente.

install.packages("ggimg")

library(ggimg)
library(ggplot2)
library(dplyr)
```
#Para poder realizar este gráfico se hará uso de los valores desginados para el grafico de Radar anterior con la variable **baraja_filtred** que contiene el data frame **top_trumps** con los personajes a utilizar.

#Será necesario añadir una columna al data frame, la cual contendrá los nombres de las imagenes que deseamos imprimir que corresponderan con los personajes, cada una de estas con sus respectivos formatos. En este caso la nueva columna es **imagenes**.

pers_filt <- paste(pers,".jpg",sep="")
baraja_filtred$imagenes <- pers_filt
baraja_filtred

# También será necesario crear otra columna llamada path, la cual contendrá las ubicaciones o rutas donde se encuentran las imagenes en mi repositorio de Rstudio. Para poder indicar las rutas se utiliza la función file.path, a la cual pasamos como argumentos la ruta donde se encuentran las imagenes. En mi caso se encuentran dentro de la carpeta **trumpjpg**
  
baraja_filtred <- mutate(baraja_filtred,
                         path = file.path("trumpjpg", imagenes)
)

# Por ultimo se creará el gráfico haciendo uso de la funcion `ggplot` pasando como argumentos el data frame **baraja_filtred** y los valores que se representan en el gráfico, se especifica el tipo de geometría *geom_point_img* la cual es compatible con la libreria `ggimg` y con ayuda del argumento aes podemos definir los valores del eje *X* y *Y*, ademas de indicar la ubicación de las rutas de las imagenes que serán utilizadas, con la variable *path*. El atributo *size* es utilizado para indicar el tamaño de las imagenes mostradas, *theme_minimal()* para indicar un tema minimalista al gráfico. Por ultimo utilizo el argumento ylim para indicar el rango de valores entre los que oscilarán las variables de los personajes para que todos puedan visualizarse correctamente en pantalla. Por ultimo añado el argumento geom_text(), donde indico el valor que posee el personaje por pantalla y que este valor aparezca por encima de la imagen.

grafico_baraja <- ggplot(baraja_filtred,aes(x = Nombre,y = Magia ,label = Magia)) +
  geom_point_img(aes(
    x = Nombre,
    y = Magia,
    img = path
  ), size = 2) +
  theme_minimal() + ylim(0,120) + geom_text(vjust = -3)
grafico_baraja

# En el caso anterior se hizo para comparar los valores respectos a la **Magia** de cada personaje pero esto se puede hacer tambien para las demas variables *Astucia*,*Coraje*,*Sabiduria*,*Templanza*.

# Astucia

grafico_baraja <- ggplot(baraja_filtred,aes(x = Nombre,y = Astucia ,label = Astucia)) +
  geom_point_img(aes(
    x = Nombre,
    y = Astucia,
    img = path
  ), size = 2) +
  theme_minimal() + ylim(0,120) + geom_text(vjust = -3)
grafico_baraja

# Coraje

grafico_baraja <- ggplot(baraja_filtred,aes(x = Nombre,y = Coraje ,label = Coraje)) +
  geom_point_img(aes(
    x = Nombre,
    y =Coraje,
    img = path
  ), size = 2) +
  theme_minimal() + ylim(0,120) + geom_text(vjust = -3)
grafico_baraja


# Sabiduria

grafico_baraja <- ggplot(baraja_filtred,aes(x = Nombre,y = Sabiduria ,label = Sabiduria)) +
  geom_point_img(aes(
    x = Nombre,
    y = Sabiduria,
    img = path
  ), size = 2) +
  theme_minimal() + ylim(0,120) + geom_text(vjust = -3)
grafico_baraja

# Templanza

grafico_baraja <- ggplot(baraja_filtred,aes(x = Nombre,y = Templanza ,label = Templanza)) +
  geom_point_img(aes(
    x = Nombre,
    y = Templanza,
    img = path
  ), size = 2) +
  theme_minimal() + ylim(0,120) + geom_text(vjust = -3)
grafico_baraja

