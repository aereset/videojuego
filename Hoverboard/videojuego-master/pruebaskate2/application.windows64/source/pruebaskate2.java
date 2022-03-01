import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pruebaskate2 extends PApplet {

 //Importamos la librer\u00eda Serial
 
Serial port; //Nombre del puerto serie
 
//PrintWriter output;  //Para crear el archivo de texto donde guardar los datos

//--------------------------------------------------------------
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
//variables de la persona
int pos_personax;
int puntuacion_2=0;

String lines[]; //cargo las mejores puntuaciones

PFont myFont;  //para la fuente y el tama\u00f1o de letra
 
boolean dibujobola = false; //para ver si debo pintar la bola


//dibujo del cilindro central
public void dibujasuelo(){
  background(240,250,255);
  noFill(); //ninguna con relleno
  stroke(0,0,0); //ahora son todas negras
  strokeWeight(3);//ancho de linea de 8 pixeles
  line(200, 0, 200, 700);
  line(800, 0, 800, 700);
  strokeWeight(1);//ancho de linea de 8 pixeles
  line(400, 0, 400, 700);
  line(600, 0, 600, 700);

}

public void creolinea(){
float aleatorio=random(300, 700);
linea1x = PApplet.parseInt(aleatorio)-50;
linea2x = PApplet.parseInt(aleatorio)+50;
dibujobola = true;
}

public void muevebolita(){
lineay=lineay+velocidadb1;
if (lineay >690){
  dibujobola = false; 
  puntuacion = puntuacion +10;
  lineay=0;}
 else ;
}

public void dibujabolita(int linea1x, int linea2x, int lineay){
    noFill(); //relleno
    strokeWeight(10);//ancho de linea de 8 pixeles
    strokeCap(SQUARE);
    stroke(250,0,0); //ahora son todas verdes
    line(200, lineay, linea1x, lineay);
    line(linea2x, lineay,800,lineay);
    }
    
public void dibujapersona(int pos_personax){
  fill(0,000,0);
  quad(PApplet.parseFloat(pos_personax-25),650.0f,PApplet.parseFloat(pos_personax+25),650.0f,PApplet.parseFloat(pos_personax),600.0f,PApplet.parseFloat(pos_personax),600.0f);
}
//aqui empiezan las funciones de dibujar texto

public void dibujanombre(){
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  fill(0,0,0);
  switch (puntuacion){
    case 0:  text("En serio? repite...",500,200);
    break;
    case 10: text("mmm... Esto no es lo tuyo",500,200);
    break;
    case 20: text("Has conseguido aguantar de pie. bravo...",500,200);
    break;
    case 30: text("3 puertas? menuda mierda",500,200);
    break;
    case 40: text("Hay gente peor que tu, tranquilo",500,200);
    break;
    case 50: text("Tu madre es calva",500,200);
    break;
    case 60: text("No esta mal, para ti...",500,200);
    break;
    case 70: text("Eres malo... y feo tambien",500,200);
    break;
    case 80: text("GENIAL! Es broma, pesimo...",500,200);
    break;
    case 90: text("Eres adoptado",500,200);
    break;
    case 100: text("Medio, te libras de ser loser.",500,200);
    break;
    case 110: text("Estas en la media, que no es bueno",500,200);
    break;
    case 120: text("puedes hacerlo mejor! la verdad... no",500,200);
    break;
    case 130: text("Has bebido antes de subir?",500,200);
    break;
    case 140: text("Enhorabuena. Cerveza gratis!",500,200);
    break;
    case 150: text("Casi llegas al final. casi...",500,200);
    break;
    case 160: text("Buen trabajo",500,200);
    break;
    case 170: text("Bien... bien.",500,200);
    break;
    case 180: text("Que putada...",500,200);
    break;
    case 190: text("A una puerta te has quedado",500,200);
    break;
    default: text("GANASTE (pero eres feo)",500,200);
  }
}

public void dibujapuntuacion(){
  textFont(myFont);
  fill(0,0,0);
  text(puntuacion, 900, 100);
}


public void dibujacuentatras(){
  textFont(myFont);
  fill(0,0,0);
  if(tiempo >= millis()-1000)
   text("3.", 500, 250);
  else if(tiempo >= millis()-2000)
   text("2.", 500, 250);
  else if(tiempo >= millis()-3000)
   text("1.", 500, 250);
  else if(tiempo >= millis()-4000){
   nivel = 2;
   tiempo = millis();
  }
}

public void dibujainstrucciones(){
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  text("Hola.", width/2, 200);
  text("Pasa por las puertas sin tocar.", 500, 250);
  text("Si te inclinas hacia los lados controlas la nave.", 500, 300);
  text("Consigue la max puntuacion", 500, 350);
  text("Pulsa la E para continuar.", 500, 450);
}

public void dibujapuntuaciones(){
  PFont myFont = createFont("minecraft.ttf", 20);
  textFont(myFont);
  int j=50;
  for (int i = 0 ; i < lines.length; i++) {
  text(lines[i], 100,j);
  j=j+20;
  }
}

//funcion que se encarga de sumar a la puntuacion 
public void choques(int lineax1, int lineax2){
  float distancia;
 // println(distancia+pos_personax);
  if(lineay >=601 && lineay<=651){
  distancia = (lineay-600)/2;
      if(((distancia+pos_personax) > lineax2) ||((pos_personax-distancia) < lineax1) ){
       nivel = nivel +1;
        }
  
  }
}

public void comunicacion(){
 if(port.available() > 0) // si hay alg\u00fan dato disponible en el puerto
 {
    vienearduino=port.read();//Lee el dato y lo almacena en la variable "valor"
    vienearduinof = PApplet.parseFloat(vienearduino);
    vienearduinof = map(vienearduino, 50, 155, 250, 750);
    pos_personax=PApplet.parseInt(vienearduinof);
    println(pos_personax);
  }
  else ;
}
public void setup()
{
  frameRate(24);
  //println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
 port = new Serial(this, Serial.list()[0], 9600); //Abre el puerto serie COM3
   
// output = createWriter("puntuaciones.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa

    lines=loadStrings("puntuaciones.txt"); //cargo las mejores puntuaciones

myFont = createFont("minecraft.ttf", 64); //para la fuente y el tama\u00f1o de letra
  
   //Creamos una ventana de 700 p\u00edxeles de anchura por 700 p\u00edxeles de altura 
} //<>//
 
public void draw()
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
  
  case 1:{ //cuenta atr\u00e1s para que empiecen a salir las bolitas
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
      choques(linea1x, linea2x);
    }
  if (puntuacion_2 <= puntuacion - 40){
  puntuacion_2 = puntuacion;
  velocidadb1=velocidadb1 + 1;
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
  
  public void keyPressed() //Cuando se pulsa una tecla
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
  public void settings() {  size(1366, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pruebaskate2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
