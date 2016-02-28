import processing.serial.*; //Importamos la librería Serial
 
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


int dibujobola = 0; //para ver si debo pintar la bola


//dibujo del cilindro central
void dibujasuelo(){
  noFill(); //ninguna con relleno
  stroke(0,255,0); //ahora son todas verdes
  line(200, 0, 200, 700);
  line(800, 0, 800, 700);

}

void creolinea(){

float aleatorio=random(300, 700);
linea1x = int(aleatorio)-50;
linea2x = int(aleatorio)+50;
dibujobola = 1;
}

void muevebolita(){
lineay=lineay+velocidadb1;
if (lineay >690){
  dibujobola = 0; 
  puntuacion = puntuacion +10;
  lineay=0;}
 else ;
}

void dibujabolita(int linea1x, int linea2x, int lineay){
    noFill(); //relleno
    stroke(0,255,0); //ahora son todas verdes
    line(200, lineay, linea1x, lineay);
    line(linea2x, lineay,800,lineay);

    }
    
void dibujapersona(int pos_personax){
  fill(0,255,0);
  quad(float(pos_personax-25),650.0,float(pos_personax+25),650.0,float(pos_personax),600.0,float(pos_personax),600.0);
}
//aqui empiezan las funciones de dibujar texto

void dibujanombre(){
  PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  fill(255,255,255);
  text("loser",500,200);
}

void dibujapuntuacion(){
   PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  fill(255,255,255);
  text(puntuacion, 900, 100);
}

void dibujatiempo(){

}

void dibujacuentatras(){
   PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  fill(255,255,255);
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

void dibujavelocidad(int grado){
 fill(255,255,255);
 switch (grado){
   case 1:{
    // quad(810,200,830,110,830,110,810,120);
  }
   break;
   
   case 2:{}
   break;
   
   case 3:{}
   break;
   
   case 4:{}
   break;
 
 }
}

void dibujainstrucciones(){
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  text("hola.", width/2, 200);
  text("Coge tantas bolas como puedas.", 500, 250);
  text("Si te inclinas hacia delante aceleras, hacia atrás frenas.", 500, 300);
  text("hacia los lados giras", 500, 350);
  text("Pulsa la E para empezar.", 500, 450);
}

void dibujapuntuaciones(){
  String lines[]=loadStrings("puntuaciones.txt");
  PFont myFont = createFont("minecraft.ttf", 24);
  textFont(myFont);
  int j=200;
  for (int i = 0 ; i < lines.length; i++) {
  text(lines[i], 200,j);
  j=j+50;
  }
}

//funcion que se encarga de sumar a la puntuacion 
void choques(int lineax1, int lineax2){
  float distancia;
 // println(distancia+pos_personax);
  if(lineay >=601 && lineay<=651){
  distancia = (lineay-600)/2;
      if(((distancia+pos_personax) > lineax2) ||((pos_personax-distancia) < lineax1) ){
       nivel = nivel +1;
        }
  
  }
}

void comunicacion(){
 if(port.available() > 0) // si hay algún dato disponible en el puerto
 {
    vienearduino=port.read();//Lee el dato y lo almacena en la variable "valor"
    vienearduinof = float(vienearduino);
    vienearduinof = map(vienearduino, 50, 155, 250, 750);
    pos_personax=int(vienearduinof);
    println(pos_personax);
  }
}
void setup()
{
  frameRate(30);
  //println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
 port = new Serial(this, "COM5", 9600); //Abre el puerto serie COM3
   
// output = createWriter("puntuaciones.txt"); //Creamos el archivo de texto, que es guardado en la carpeta del programa
   
  size(1000, 700); //Creamos una ventana de 700 píxeles de anchura por 700 píxeles de altura 
}
 
void draw()
{

  background(0,0,0);//
  //actualiza el valor del acelerometro
  comunicacion();
  switch (nivel){
    
  case 0:{ //pantalla inicial del juego
    dibujainstrucciones();
  }
  break;
  
  case 1:{ //cuenta atrás para que empiecen a salir las bolitas
    dibujacuentatras();
     dibujasuelo();
     dibujapersona(pos_personax);
    // dibujavelocidad();
  }
  break;
  
  case 2:{ //juego en si
   // dibujatiempo();
     dibujasuelo();
     dibujapuntuacion();
   // dibujavelocidad();
    if(dibujobola == 0){ //si no hay ninguna bola dibujada
      creolinea();
      dibujabolita(linea1x, linea2x, lineay);
    }
    else{
      muevebolita();
      dibujabolita(linea1x, linea2x, lineay);
      choques(linea1x, linea2x);
    }
  dibujapersona(pos_personax);
  dibujavelocidad(grado);
  if (puntuacion_2 <= puntuacion - 20){
  puntuacion_2 = puntuacion;
  velocidadb1=velocidadb1+3;
  grado = grado + 1;
  }
    else ;
    
  }
  break;
  
  case 3:{ //guarda tu nombre
  dibujanombre();
  dibujasuelo();
  dibujapuntuacion();
  dibujapersona(pos_personax);
  }
  break;
  
  case 4:{ //muestra las puntuaciones.
  dibujasuelo();
  dibujapersona(pos_personax);
  }
  break;
  
  }
}
  
  void keyPressed() //Cuando se pulsa una tecla
{
  if(key=='e'||key=='E')
  {
      if(nivel >=4){ nivel = 0;
      //  segundos = 30;
        puntuacion = 0;
        dibujobola = 0;
        lineay=0;
        velocidadb1=10;
        puntuacion_2=0;
        grado = 1;
        }
      else{
        nivel = nivel +1; //El logo se deplaza hacia arriba
       tiempo = millis();
      }
  }
   if(key=='a'||key=='A')
  {
    pos_personax--;
  }
  
   if(key=='d'||key=='D')
  {
    pos_personax++;
  }
  //Pulsar la tecla q para salir del programa
  if(key=='q' || key=='Q')
  {
    exit();//Salimos del programa
  }
}