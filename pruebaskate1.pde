import processing.serial.*; //Importamos la librería Serial
 
Serial port; //Nombre del puerto serie
 
//PrintWriter output;  //Para crear el archivo de texto donde guardar los datos

//--------------------------------------------------------------
//--------------------------------------------------------------
int vienearduino;
float vienearduinof;
int puntuacion = 0;
//variable de la velocidad general
float velocidadgeneral=50;
//variables de tiempo 
int segundos = 30;
int milisegundos = 99;
float tiempo = 0;
float tiempom =0;
//variable que avisa del nivel
int nivel = 0;
//variables de la bolita azul
float radio = 10.0f;
float x_bol1 =0.0f;
float y_bol1 = 0.0f;
float x_director1 = 0.0f;
float y_director1 = 0.0f;
float velocidadb1 = 0.5f;
//variables de la persona
float desviacion = 0.0f;  //es el valor de la inclinacion respecto a la vertical
float pos_personax=500 + 300*sin(desviacion);
float pos_personay=350 + 340*cos(desviacion);


int dibujobola = 0; //para ver si debo pintar la bola

//variables de la bolita especial
float radio2 = 10.0f;
float x_bol2 =0.0f;
float y_bol2 = 0.0f;

boolean dibujobola2 = false; //para ver si debo pintar la bola


//dibujo del cilindro central
void dibujasuelo(){
  noFill(); //ninguna con relleno
  stroke(0,255,0); //ahora son todas verdes
  arc(500, 350, 100, 100, 0, PI);
  arc(500, 330, 200, 200, 0, PI);
  arc(500, 310, 350, 350, 0, PI);
  arc(500, 290, 550, 550, 0, PI);
  arc(500, 270, 800, 800, 0, PI);
  arc(500, 230, 1100, 1100, 0, PI);

  line(500, 400, 500, 770);
  line(450, 350, 0, 230);
  line(550, 350, 1000, 230);
  line(464.644, 385.35533, 0.77328, 849.226);
  line(535.35466, 385.35533, 999.2267, 849.226);

}

void creobolita(){
//me va a dar un numero aleatorio en radianes, para yo darle la coordenada buena
radio=10;
velocidadb1=0.15;
float aleatorio=random(0, 314)/100;
x_bol1 = 500 + cos(aleatorio)*50;
y_bol1 = 350 + sin(aleatorio)*50;
//para saber en que direccion se mueve la bola. Al dividirlo entre el radio, ya es unitario
x_director1 = (x_bol1 - 500)/50;
y_director1 = (y_bol1 - 350)/50;

dibujobola = 1;
}

void muevebolita(){
x_bol1 = x_bol1+x_director1*velocidadb1*(velocidadgeneral/50);
y_bol1 = y_bol1+y_director1*velocidadb1*(velocidadgeneral/50);
radio = radio + 0.2*(velocidadgeneral/50);
velocidadb1 = velocidadb1 + 0.02;
if (x_bol1 <= 10 || x_bol1 >= 1000 || y_bol1 >= 700 ){
  dibujobola = 0; }
}
void dibujabolita(float radio, float x_bol1, float y_bol1){
    fill(0,0,255); //relleno
    stroke(0,0,255); //ahora son todas azules
    ellipse(x_bol1, y_bol1, radio, radio);
   
    }
    
void dibujapersona(float pos_personax, float pos_personay){
  float x1,x2,x3,x4,y1,y2,y3,y4;
  fill(225,225,225);
  if (desviacion <=0){
  x1=pos_personax+50*sin(abs(desviacion))-10*cos(abs(desviacion));
  y1=pos_personay-50*cos(abs(desviacion))-10*sin(abs(desviacion));
  x2=pos_personax+50*sin(abs(desviacion))+10*cos(abs(desviacion));
  y2=pos_personay-50*cos(abs(desviacion))+10*sin(abs(desviacion));
  x3=pos_personax+25*cos(abs(desviacion));
  y3=pos_personay+25*sin(abs(desviacion));
  x4=pos_personax-25*cos(abs(desviacion));
  y4=pos_personay-25*sin(abs(desviacion));
  }
  else {
  x1=pos_personax-50*sin(abs(desviacion))-10*cos(abs(desviacion));
  y1=pos_personay-50*cos(abs(desviacion))+10*sin(abs(desviacion));
  x2=pos_personax-50*sin(abs(desviacion))+10*cos(abs(desviacion));
  y2=pos_personay-50*cos(abs(desviacion))-10*sin(abs(desviacion));
  x3=pos_personax+25*cos(abs(desviacion));
  y3=pos_personay-25*sin(abs(desviacion));
  x4=pos_personax-25*cos(abs(desviacion));
  y4=pos_personay+25*sin(abs(desviacion));
  }
  
  quad(x1,y1,x2,y2,x3,y3,x4,y4);
}
//aqui empiezan las funciones de dibujar texto

void dibujanombre(){
  PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  
}

void dibujapuntuacion(){
   PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  text(puntuacion, 900, 100);
}

void dibujatiempo(){
   PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  
  if(tiempo <=millis()-1000){
    segundos = segundos - 1;
    tiempo=millis();}
  else if(tiempom<=millis()-10){
    if(milisegundos <= 0) milisegundos=99;
    else milisegundos= milisegundos-1;
    tiempom=millis();}
  fill(255,255,255);
  text(segundos, 425, 180);
  text(":",500,180);
  text(milisegundos, 575, 180);
  if (segundos ==0){
  nivel = 3;
  }
}

void dibujacuentatras(){
   PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
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

void dibujavelocidad(){
 PFont myFont = createFont("minecraft.ttf", 64);
  textFont(myFont);
  text(velocidadgeneral, 100,100);
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
void choques(){
  float distancia;
  if(desviacion <=0){
  distancia = sqrt(pow((pos_personax+50*sin(abs(desviacion)))-x_bol1,2)+pow((pos_personay-50*cos(abs(desviacion)))-y_bol1,2));
  }
  else {
  distancia = sqrt(pow((pos_personax-50*sin(abs(desviacion)))-x_bol1,2)+pow((pos_personay-50*cos(abs(desviacion)))-y_bol1,2));
  }
  if(radio-10 >= distancia ){
    dibujobola=0;
    puntuacion = puntuacion +10;
  }
}

void comunicacion(){
  if(port.available() > 0) // si hay algún dato disponible en el puerto
   {
     vienearduino=port.read();//Lee el dato y lo almacena en la variable "valor"
     vienearduinof = float(vienearduino);
     vienearduinof = map(vienearduino, 0, 205, 0, 628);
     desviacion = vienearduinof/100 - 3.14;
      println(desviacion);
     pos_personax = 500 + 300*sin(desviacion);
     pos_personay = 350 + 340*cos(desviacion);
   }
}
void setup()
{
 // println(Serial.list()); //Visualiza los puertos serie disponibles en la consola de abajo
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
     dibujapersona(pos_personax, pos_personay);
     dibujavelocidad();
  }
  break;
  
  case 2:{ //juego en si
    dibujatiempo();
     dibujasuelo();
     dibujapuntuacion();
     dibujatiempo();
     dibujavelocidad();
    if(dibujobola == 0){ //si no hay ninguna bola dibujada
  creobolita();
  dibujabolita(radio, x_bol1, y_bol1);
    }
    else{
  muevebolita();
  dibujabolita(radio, x_bol1, y_bol1);
    }
  dibujapersona(pos_personax, pos_personay);
  choques();
    
  }
  break;
  
  case 3:{ //guarda tu nombre
  dibujanombre();
  dibujasuelo();
  dibujapuntuacion();
  dibujapersona(pos_personax, pos_personay);
  }
  break;
  
  case 4:{ //muestra las puntuaciones.
  dibujapuntuaciones();
  }
  break;
  
  }
 
}
  
  void keyPressed() //Cuando se pulsa una tecla
{
  if(key=='e'||key=='E')
  {
      if(nivel >=4){ nivel = 0;
        segundos = 30;
        puntuacion = 0;
        dibujobola=0;
        }
      else{
        nivel = nivel +1; //El logo se deplaza hacia arriba
       tiempo = millis();
      }
  }
   if(key=='a'||key=='A')
  {
    if(desviacion > (-PI/2)){
        desviacion = desviacion - 0.01;
        pos_personax = 500 +300*sin(desviacion);
        pos_personay = 350 + 340*cos(desviacion);
    } 
    
  }
   if(key=='d'||key=='D')
  {
    if(desviacion < (PI/2)){
       desviacion = desviacion + 0.01;
       pos_personax = 500 + 300*sin(desviacion);
        pos_personay = 350 + 340*cos(desviacion);
    }
    
  }
  
  if(key=='w'||key=='W')
  {
    if(velocidadgeneral < 100){
       velocidadgeneral++;
    }
    else ;
  }
  
  if(key=='s'||key=='S')
  {
    if(velocidadgeneral > 0){
       velocidadgeneral--;
    }
    else ;
  }
  //Pulsar la tecla q para salir del programa
  if(key=='q' || key=='Q')
  {
    exit();//Salimos del programa
  }
}