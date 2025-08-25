import processing.serial.*; //Importamos la librería Serial //<>//
 
Serial port; //Nombre del puerto serie
 
//PrintWriter output;  //Para crear el archivo de texto donde guardar los datos

//--------------------------------------------------------------
int puerto=3;  //posicion de lista de puerto, normalmente 0
//--------------------------------------------------------------
int vienearduino;
float vienearduinof;
int puntuacion = 0;
//variable de la velocidad general
int grado=1;
//variables de tiempo 
int segundos = 30;
int milisegundos = 99;
float tiempo = 0;
float tiempom =0;
//variable que avisa del nivel
int nivel = 0;
//variables de la bolita azul
int linea1x =0;
int linea2x = 0;
int lineay =0;
int velocidadb1 = 10;
int aceleracion = 5;//= 1;
//variables de la persona
int pos_personax;
int puntuacion_2=0;
float linea1xAdjusted=0;
float linea2xAdjusted=0;
int anchoInicio=200;
int anchoFinal=1000;
float porcentajeCreacionInicio=0.8;
float porcentajePuerta=0.07;

String lines[]; //cargo las mejores puntuaciones

PFont myFont;  //para la fuente y el tamaño de letra
 
boolean dibujobola = false; //para ver si debo pintar la bola


//dibujo del cilindro central
void dibujasuelo(){
  background(240,250,255);
  noFill(); //ninguna con relleno
  stroke(0,0,0); //ahora son todas negras
  strokeWeight(3);//ancho de linea de 8 pixeles
  line((width-anchoInicio)/2, 0, (width-anchoFinal)/2, 700);
  line((width+anchoInicio)/2, 0, (width+anchoFinal)/2, 700);
  strokeWeight(1);//ancho de linea de 8 pixeles
  line((width-(anchoInicio/2))/2, 0, (width-(anchoFinal/2))/2, 700);
  line((width+(anchoInicio/2))/2, 0, (width+(anchoFinal/2))/2, 700);
  line(width/2, 0, width/2, 700);
  stroke(50,50,50); //ahora son todas negras
  strokeWeight(10);//ancho de linea de 8 pixeles
  line((width-anchoFinal)/2, 600, (width-anchoFinal)/2, 700);
  line((width+anchoFinal)/2, 600, (width+anchoFinal)/2, 700);
  line((width-(anchoFinal+anchoInicio)/2)/2, 250, (width-(anchoFinal+anchoInicio)/2)/2, 350);
  line((width+(anchoFinal+anchoInicio)/2)/2, 250, (width+(anchoFinal+anchoInicio)/2)/2, 350);
}

void creolinea() {
    // Calcular una posición aleatoria del centro del hueco 
    float aleatorio = random((width-anchoInicio*porcentajeCreacionInicio)/2, (width+anchoInicio*porcentajeCreacionInicio)/2);

    // Almacenamos el centro del hueco (para usarlo en la perspectiva)
    linea1x = int(aleatorio);  // Esto será el centro del hueco
    dibujobola = true;         // Indicamos que hay que dibujar la bola
}


void muevebolita(){
lineay=lineay+velocidadb1;
if (lineay >690){
  dibujobola = false; 
  puntuacion = puntuacion +10;
  lineay=0;}
 else ;
}

//dibuja el muro y su movimiento
void dibujabolita(int linea1x, int linea2x, int lineay) {
    noFill(); // Sin relleno
    strokeWeight(10); // Ancho de línea
    strokeCap(SQUARE);
    stroke(250, 0, 0); // Color rojo

    // Interpolar el tamaño de las líneas y el hueco según la posición de lineay (la altura de la bolita)
    float t = map(lineay, 0, 700, 0, 1); // Factor de interpolación (toma valores entre 0 y 1)

    // Interpolamos las posiciones de los extremos del muro entre el valor "arriba" (cerca) y "abajo" (lejos)
    float xLeftTop = (width-anchoInicio)/2;   // Posición izquierda al inicio (arriba)
    float xLeftBottom = (width-anchoFinal)/2; // Posición izquierda al final (abajo)
    float xLeft = lerp(xLeftTop, xLeftBottom, t); // Interpolación para la izquierda

    float xRightTop = (width+anchoInicio)/2;   // Posición derecha al inicio (arriba)
    float xRightBottom = (width+anchoFinal)/2; // Posición derecha al final (abajo)
    float xRight = lerp(xRightTop, xRightBottom, t); // Interpolación para la derecha

    // Interpolar el hueco entre las líneas (el espacio entre las "puertas")
    float gapTop = anchoInicio*porcentajePuerta;  // Hueco más pequeño (arriba)
    float gapBottom = anchoFinal*porcentajePuerta; // Hueco más grande (abajo)
    float gap = lerp(gapTop, gapBottom, t); // Interpolamos el hueco
    
    // Interpolar el centro del hueco)
    float gapMidTop = linea1x;  // Hueco más pequeño (arriba)
    float percentajeCenterMidGap = (linea1x-xLeftTop)/anchoInicio;
    float gapMidBottom = xLeftBottom+(anchoFinal*percentajeCenterMidGap); // Hueco más grande (abajo)
    float gapMid = lerp(gapMidTop, gapMidBottom, t); // Interpolamos el hueco

    // Ajustar las posiciones de las líneas usando el hueco interpolado
    linea1xAdjusted = gapMid - gap;  // Ajuste de la línea izquierda
    linea2xAdjusted = gapMid + gap; // Ajuste de la línea derecha

    // Dibujar las líneas con las nuevas posiciones ajustadas por la perspectiva
    line(xLeft, lineay, linea1xAdjusted, lineay); // Línea izquierda
    line(linea2xAdjusted, lineay, xRight, lineay); // Línea derecha
}


    
void dibujapersona(int pos_personax){
  fill(0,000,0);
  quad(float(pos_personax-25),650.0,float(pos_personax+25),650.0,float(pos_personax),600.0,float(pos_personax),600.0);
}
//aqui empiezan las funciones de dibujar texto

void dibujanombre(){
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  fill(0,0,0);
  switch (puntuacion){
    case 0:  text("En serio? repite...",width/2,200);
    break;
    case 10: text("mmm... Esto no es lo tuyo",width/2,200);
    break;
    case 20: text("Has conseguido aguantar de pie. bravo...",width/2,200);
    break;
    case 30: text("3 puertas? menuda mierda",width/2,200);
    break;
    case 40: text("Hay gente peor que tu, tranquilo",width/2,200);
    break;
    case 50: text("Tu madre es calva",width/2,200);
    break;
    case 60: text("No esta mal, para ti...",width/2,200);
    break;
    case 70: text("Eres malo... y feo tambien",width/2,200);
    break;
    case 80: text("GENIAL! Es broma, pesimo...",width/2,200);
    break;
    case 90: text("Eres adoptado",width/2,200);
    break;
    case 100: text("Medio, te libras de ser loser.",width/2,200);
    break;
    case 110: text("Estas en la media, que no es bueno",width/2,200);
    break;
    case 120: text("puedes hacerlo mejor! la verdad... no",width/2,200);
    break;
    case 130: text("Has bebido antes de subir?",width/2,200);
    break;
    case 140: text("Enhorabuena. Cerveza gratis!",width/2,200);
    break;
    case 150: text("Casi llegas al final. casi...",width/2,200);
    break;
    case 160: text("Buen trabajo",width/2,200);
    break;
    case 170: text("Bien... bien.",width/2,200);
    break;
    case 180: text("Que putada...",width/2,200);
    break;
    case 190: text("A una puerta te has quedado",width/2,200);
    break;
    default: text("GANASTE (pero eres feo)",width/2,200);
  }
}

void dibujapuntuacion(){
  textFont(myFont);
  fill(0,0,0);
  text(puntuacion, 11*width/16, 100);
}


void dibujacuentatras(){
  textFont(myFont);
  fill(0,0,0);
  if(tiempo >= millis()-1000)
   text("3.", width/2, 250);
  else if(tiempo >= millis()-2000)
   text("2.", width/2, 250);
  else if(tiempo >= millis()-3000)
   text("1.", width/2, 250);
  else if(tiempo >= millis()-4000){
   nivel = 2;
   tiempo = millis();
  }
}

void dibujainstrucciones(){
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  text("Hola.", width/2, 200);
  text("Pasa por las puertas sin tocar.", width/2, 250);
  text("Si te inclinas hacia", width/2, 300);
  text("los lados controlas la nave.", width/2, 350);
  text("Consigue la max puntuacion", width/2, 400);
  text("Pulsa la E para continuar.", width/2, 450);
}

void dibujapuntuaciones(){
  PFont myFont = createFont("minecraft.ttf", 20);
  textFont(myFont);
  int j=50;
  for (int i = 0 ; i < lines.length; i++) {
  text(lines[i], 150,j);
  j=j+20;
  }
}

//funcion que se encarga de sumar a la puntuacion 
void choques() {
  float distancia;

  // Verificar si la bola está en la posición de colisión (cerca del jugador)
  if (lineay >= 641 && lineay <= 691) {
    distancia = 20;//distancia = (lineay - 600) / 2;

    // Verificar si el personaje (pos_personax) toca los extremos de las líneas interpoladas
    float personajeIzquierda = pos_personax - distancia;
    float personajeDerecha = pos_personax + distancia;

    // Si la posición del personaje está fuera del hueco, colisiona
    if (personajeIzquierda < linea1xAdjusted || personajeDerecha > linea2xAdjusted) {
      nivel = nivel + 1; // Sumar al nivel para indicar una colisión o fallo
    }
  }
}


void comunicacion(){
 if(port.available() > 0) // si hay algún dato disponible en el puerto
 {
    vienearduino=port.read();//Lee el dato y lo almacena en la variable "valor"
    vienearduinof = float(vienearduino);
    vienearduinof = map(vienearduino, 80, 0, 0, width); //vienearduinof = map(vienearduino, 80, 0, 250, 750);
    pos_personax=int(vienearduinof+100);
    println(pos_personax);
    
  }
  else ;
}
void setup()
{
  frameRate(20);
  //println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
 port = new Serial(this, Serial.list()[puerto], 9600); //Abre el puerto serie COM3 //puede dar problemas esto
   
// output = createWriter("puntuaciones.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa

    lines=loadStrings("puntuaciones.txt"); //cargo las mejores puntuaciones

myFont = createFont("minecraft.ttf", 64); //para la fuente y el tamaño de letra
  
  size(1366, 768); //Creamos una ventana de 700 píxeles de anchura por 700 píxeles de altura 
  
}
 
void draw()
{

 //
  //actualiza el valor del acelerometro
  dibujasuelo();
  comunicacion();
  dibujapersona(pos_personax);
  dibujapuntuaciones();
  switch (nivel){
    
  case 0:{ //pantalla inicial del juego
    dibujainstrucciones();
  }
  break;
  
  case 1:{ //cuenta atrás para que empiecen a salir las bolitas
    dibujacuentatras();
  }
  break;
  
  case 2:{ //juego en si
     dibujapuntuacion(); 
    if(dibujobola == false){ //si no hay ninguna bola dibujada
      creolinea();
      dibujabolita(linea1x, linea2x, lineay);
    }
    else{
      muevebolita();
      dibujabolita(linea1x, linea2x, lineay);
      choques();
    }
  if (puntuacion_2 <= puntuacion - 100){
  puntuacion_2 = puntuacion;  
  velocidadb1=velocidadb1 + aceleracion;
  }
    else ;
    
  }
  break;
  
  case 3:{ //guarda tu nombre
  dibujanombre();
  dibujapuntuacion();
  }
  break;
  
  default:
  }
}
  
  void keyPressed() //Cuando se pulsa una tecla
{
  if(key=='e'||key=='E')
  {
      if(nivel >=3){ nivel = 0;
      //  segundos = 30;
        puntuacion = 0;
        dibujobola = false;
        lineay=0;
        velocidadb1=10;
        puntuacion_2=0;
        grado = 1;
        }
      else{
        nivel = nivel +1; 
       tiempo = millis();
      }
  }
   
}