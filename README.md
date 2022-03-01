# videojuego
Como muchos ya sabéis, hemos hecho un "videojuego" con processing que puedes controlar con un acelerometro conectado a un arduino. Ahora mismo hay dos pruebas hechas más el codigo para leer desde el arduino los datos del acelerometro. La idea es que quien quiera pueda ir mejorando, añadiendo o modificando cosas, ya que mis conocimientos del processing y de java en general son muy escasos.

# Para correrlo

Abrir la carpeta «Hoverboard».

Subir a la placa de arduino el código que hay en la carpeta «pruebaskate» dentro de la carpeta «pruebaskate2» dentro de la carpeta «videojuego-master».

Abrir la carpeta «processing-3.3».

Run processing app.

Desde la app de processing abrir el «pruebaskate2» que se encuentra nada más abrir la carpeta de «pruebaskate2» y hacer run, es el juego ya, esperas unos segundos a que se estabilicen las lecturas de la IMU y ¡JUGAR!

** Nota: **

A lo mejor no funciona el port porque cambia en vuestro ordenador, teneis que solucionarlo a mano.

En el código abierto en processing de «pruebaskate2» id a la fuinción de SETUP.

Donde pone «port=...» en «Serial.list()[X]» cambiar el número X por la posición en la que se encuentre el port (com) que estáis usando en arduino.

Para saber esa posición podeis descomentar el «println(Serial.list())».
