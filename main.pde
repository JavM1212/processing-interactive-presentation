// Librerias necesarias
import gifAnimation.*;
import processing.sound.*;

// Variables globales 
int currentScene = 1; 
int scene2Duration = 10000; // Milisegundos
boolean showOpts = false;
String[][] defTetxt = {
    {
      "Pandurata plantae", 
      "Esta planta es ideal para las personas\nque buscan tener una compañera que\nse de fácil cuido y le de vida a tu casa", 
      "Busca Semisombra",
      "Requiere poco tiempo",
      "Para el Asesino de plantas"
    },
    {
      "Guzmania",
      "Es una bromelia de fácil cultivo. No es\nmuy exigente en cuanto a la luz, pero\nagradece cercanía de una ventana con\ncortina para asegurar una luz tamizada",
      "Busca Luz Indirecta", 
      "Requiere un tiempo moderado de cuidado",
      "Para la que le gusta hablarle a sus plantas"
    },
    {
      "Philodendron ‘Hoja de Corazón’",
      "Esta planta es ideal para las personas\nque buscan tener una compañera que\nse de fácil cuido y le de vida a tu casa",
      "Busca Luz Indirecta",
      "Requiere poco tiempo",
      "Para el Asesino de plantas"
    },
    {
      "Monstera deliciosa",
      "Es muy usada principalmente como\nplanta de interior para decoración,\ngeneralmente en hoteles, restaurantes,\noficinas, y en domicilios particulares.",
      "Busca Luz Indirecta",
      "Requiere poco tiempo",
      "Para el Asesino de plantas"
    }
  };
int currentText = 0;

// Imagenes
PImage img_title; 
PImage img_1;
PImage img_2;
PImage img_3;
PImage img_4;

// Gifs
Gif gif_cover; 
Gif scene_2;
Gif opt_1;
Gif opt_2;
Gif opt_3;
Gif opt_4;
Gif currentGif;

// Sonidos
SoundFile audio_1;
SoundFile audio_2;

// Props del menu dona
float DONUT_RADIUS = 250;
int BG_COLOR = #FFFFFF;
int DONUT_COLOR = #F9F9F9;
int DONUT_THICKNESS = 50;

void setup() {
  fullScreen(); // opcion de pantalla completa (tambien es 1920, 1080)
  // size(1920, 1080);
  
  // Cargar imagenes
  img_title = loadImage("assets/imgs/titulo_plantas.png");
  img_1 = loadImage("assets/imgs/planta_1.png");
  img_2 = loadImage("assets/imgs/planta_2.png");
  img_3 = loadImage("assets/imgs/planta_3.png");
  img_4 = loadImage("assets/imgs/planta_4.png");
  
  // Cargar gifs
  gif_cover = new Gif(this, "assets/gifs/escena_1.gif");
  scene_2 = new Gif(this, "assets/gifs/escena_2.gif");
  opt_1 = new Gif(this, "assets/gifs/opt_1.gif");
  opt_2 = new Gif(this, "assets/gifs/opt_2.gif");
  opt_3 = new Gif(this, "assets/gifs/opt_3.gif");
  opt_4 = new Gif(this, "assets/gifs/opt_4.gif");
  
  // Cargar audios
  audio_1 = new SoundFile(this, "assets/audios/audio1.mp3");
  audio_2 = new SoundFile(this, "assets/audios/audio2.mp3");  
  
  // Config audio 1
  audio_1.loop();
}
    
void draw() {
  // Dibujamos la escena actual
  switch (currentScene) {
    case 1:
      dibujarEscena1();
      break;
    case 2:
      dibujarEscena2();
      break;
    case 3:
      dibujarEscena3();
      break;
  }
}


// Función para dibujar la escena 1
void dibujarEscena1() {
  // Dibujamos el fondo
  gif_cover.loop();
  image(gif_cover, 0, 0);

  // Dibujamos la imagen en el centro de la pantalla
  float xImg_title = width/2 - img_title.width/2;
  float yImg_title = height/2 - img_title.height/2;
  image(img_title, xImg_title, yImg_title);

  // settear colores onHover y normal
  if (mouseX >= width/2 - 150 && mouseX <= width/2 + 150 && mouseY >= height/2 + 155 && mouseY <= height/2 + 220) {
    fill(#D1DBB3);
  } else {
    fill(#C4C4C4);
  }

  // Boton
  rectMode(CENTER);
  rect(width/2, height/2 + 187.5, 300, 65, 10);
  fill(255); 
  textSize(24); 
  textAlign(CENTER, CENTER);
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 24));
  text("Encuentra más", width/2, height/2 + 185);
  noStroke();

  // Verificamos si se ha hecho clic en el boton
  if (mouseX >= width/2 - 150 && mouseX <= width/2 + 150 && mouseY >= height/2 + 155 && mouseY <= height/2 + 220 && mousePressed) {

    // Detenemos el sonido de la primera escena
    audio_1.stop();
    
    // Mostramos la segunda escena
    currentScene = 2;
    
    // Iniciamos el sonido de la segunda escena
    audio_2.loop();
    
    // Reseteamos el temporizador para la segunda escena
    scene2Duration = millis();
  }
}

void dibujarEscena2() {
  // Establecemos el fondo blanco
  background(255);

  scene_2.loop();
  image(scene_2, width/2 - scene_2.width/2, height/2 - scene_2.height/2); // dibuja la imagen  

  // Mostramos el texto en la esquina superior izquierda
  upperText();

  // Verificamos si han pasado 10 segundos
  if (millis() - scene2Duration >= 10000) { // remplazar por 10000
    currentScene = 3;
    
    audio_2.stop();
  }
}

void dibujarEscena3() {
  // Gif inicial
  if (currentGif == null ) {
    currentGif = opt_1;
  }
  
  // Establecemos el fondo blanco
  background(255);

  // Config gif
  currentGif.loop();
  imageMode(CENTER);
  // Dibujamos el gif animado centrado en la pantalla
  image(currentGif, width/2 - 125, height/2);

  // Dibujamos texto de arriba a la izquierda
  upperText();

  // Dibujamos el texto a la izquierda del gif
  textAlign(LEFT);
  textSize(35);
  fill(#C4C4C4);
  textFont(createFont("assets/fonts/Lora-Bold.ttf", 30));
  text(defTetxt[currentText][0], 145, height/2 - 210);
  
  // Dibujamos el parrafo a la izquierda del gif
  textSize(21.5);
  fill(#C4C4C4);
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 24));
  text(defTetxt[currentText][1], 145, height/2 - 125, 20);
  
  // Elemento de lista 1
  ellipse(170, height/2 + 40, 45, 45);
  textSize(21.5);
  fill(#C4C4C4);
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 23));
  text(defTetxt[currentText][2], 240, height/2 + 50);
  
  // Elemento de lista 2
  ellipse(170, height/2 + 110, 45, 45);
  textSize(21.5);
  fill(#C4C4C4);
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 23));
  text(defTetxt[currentText][3], 240, height/2 + 120);
  
  // Elemento de lista 3
  ellipse(170, height/2 + 190, 45, 45);
  textSize(21.5);
  fill(#C4C4C4);
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 23));
  text(defTetxt[currentText][4], 240, height/2 + 200);

  // Dibujamos el boton
  noFill();
  strokeWeight(1);
  stroke(#C4C4C4);
  ellipse(width - 850, height / 2, 64, 64);
  fill(#C4C4C4);
  textSize(32);
  textAlign(CENTER, CENTER);
  textFont(createFont("assets/fonts/Arimo-Regular.ttf", 30));
  text("↑↓", width - 850, height / 2 - 5);

  // Verificamos si se ha hecho clic en el botón
  if (dist(mouseX, mouseY, width - 850, height / 2) < 32 && mousePressed) {
    // Desplegamos el grid de opciones
    if (showOpts == true) showOpts = false;
    else showOpts = true;
  }

  // Desplegamos el donut menu si se ha presionado el botón correspondiente
  if (showOpts) {
  // Dibujamos la dona (no es un circulo, son 4 arcos)
  fill(DONUT_COLOR);
  noStroke();
  arc(width/2 + 550, height/2, 600, 600, 0 + radians(45), HALF_PI + radians(45));
  arc(width/2 + 550, height/2, 600, 600, HALF_PI + radians(45), PI + radians(45));
  arc(width/2 + 550, height/2, 600, 600, PI + radians(45), PI + HALF_PI + radians(45));
  arc(width/2 + 550, height/2, 600, 600, PI + HALF_PI + radians(45), TWO_PI + radians(45));
  
  // Dibujamos las opciones
  fill(DONUT_COLOR);
  imageMode(CENTER);
  image(img_1, width/2 - 230 + 550, height/2, 150, 150);
  image(img_2, width/2 + 550, height/2 - 230, 150, 150);
  image(img_3, width/2 + 230 + 550, height/2, 150, 150);
  image(img_4, width/2 + 550, height/2 + 230, 150, 150);
  
  // Variables auxiliares
  float d = dist(mouseX, mouseY, width/2 + 550, height/2); // Detector del mouse
  float innerRadius = 125;
  float outerRadius = 325;
  
  // Si el ouse esta en la dona
  if (d > innerRadius && d < outerRadius) {
    float angle = atan2(mouseY - height/2, mouseX - (width/2 + 550)); // Devuelve en radianes el angulo en el que esta el mouse, tomando como origen las coordenadas puestas en los parametros
    float pointX = width/2 + 550 + cos(angle) * 300;
    float pointY = height/2 + sin(angle) * 300;

    // Deteccion del mouse para hacer los cambios de fondo por cada opcion
    // angle sabe los grados en el que esta el mouse segun el punto de origen dado
    // por lo que en cada if lo que se hace es settear el rango de grados deseado,
    // tomando en cuenta que el punto de origen es 0 (se encuentra a la derecha del circulo)
    // y la adicion va en contra de las manesillas del reloj y la resto en el sentido de las manesillas del reloj
    if (angle > radians(45) && angle < HALF_PI + radians(45)) {
      fill(#EEEEEE);
      strokeWeight(2);
      stroke(#CFCFCF);
      arc(width/2 + 550, height/2, 600, 600, 0 + radians(45), HALF_PI + radians(45));
      image(img_4, width/2 + 550, height/2 + 230, 150, 150);
    } else if ((angle >= radians(135) && angle < radians(225) + HALF_PI) || (angle > radians(-225) && angle < radians(-135))) {
      fill(#EEEEEE);
      strokeWeight(2);
      stroke(#CFCFCF);
      arc(width/2 + 550, height/2, 600, 600, HALF_PI + radians(45), PI + radians(45));
      image(img_1, width/2 - 230 + 550, height/2, 150, 150);
      }  else if ((angle > radians(-45) && angle < radians(45))) {
      fill(#EEEEEE);
      strokeWeight(2);
      stroke(#CFCFCF);
      arc(width/2 + 550, height/2, 600, 600, 0 - radians(45), HALF_PI - radians(45));
      image(img_3, width/2 + 230 + 550, height/2, 150, 150);
    }  else if (angle > radians(-135) && angle < radians(-45)) {
      fill(#EEEEEE);
      strokeWeight(2);
      stroke(#CFCFCF);
      arc(width/2 + 550, height/2, 600, 600, PI + radians(45), PI + HALF_PI + radians(45));
      image(img_2, width/2 + 550, height/2 - 230, 150, 150);
    }
  }
} 

// Dibujamos circulo blanco en el centro del circulo de los arcos para simular hueco
fill(BG_COLOR);
noStroke();
ellipse(width/2 + 550, height/2, 250, 250);

// Detectamos clicks con la misma estrategia que el onHover
float angle = atan2(mouseY - height/2, mouseX - (width/2 + 550));
// settear los gifs y textos correspondientes
if (((angle >= radians(135) && angle < radians(225) + HALF_PI) || (angle > radians(-225) && angle < radians(-135))) && mousePressed) {
    currentGif = opt_1;
    currentText = 0;
  } else if ((angle > radians(-135) && angle < radians(-45)) && mouseY <= height/2 - 230 + 75 && mousePressed) {
    currentGif = opt_2;
    currentText = 1;
  } else if ((angle > radians(-45) && angle < radians(45)) && mousePressed) {
    currentGif = opt_3;
    currentText = 2;
  }else if ((angle > radians(45) && angle < HALF_PI + radians(45)) && mousePressed) {
    currentGif = opt_4;
    currentText = 3;
  }
}

// Texto de la parte de arriba
void upperText() {
  textSize(35);
  fill(#C4C4C4); 
  textFont(createFont("assets/fonts/Lora-Regular.ttf", 30));
  text("!Tus mejores matches!", 300, 120); 
}