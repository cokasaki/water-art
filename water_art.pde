import processing.serial.*;
import processing.sound.*;
import cc.arduino.*;

int time = 0;
int new_time = 0;
int text_size = 15;

int num = 100;
int[] bottle_x = new int[num];
int[] bottle_y = new int[num];
float[] bottle_th = new float[num];

Arduino arduino;
BottleDropper dropper;
ScaleModel model;
PImage bottle_img;
Sensor[] sensors = new Sensor[4];
int[] pin_nums = {2,3,4,5};
int[] bottle_nums = {500,1000,2000,7000}; 
// lettuce, corn, milk, chicken, steak
SoundFile[] sounds = new SoundFile[4];
int[] sound_start_times = {49,0,0,0};
SoundFile current_sound;

int h = 600;
int model_w = 200;
int dropper_w = 600;

void setup() {
  size(800,600);
  stroke(1.0);
  fill(1.0);
  textSize(text_size);
  
  for(int i = 1; i < bottle_x.length; i++) {
    bottle_x[i] = (int)random(width);
    bottle_y[i] = (int)random(height);
    bottle_th[i] = random(2*PI);
  }
  
  //println(Arduino.list());
  
  arduino = new Arduino(this, "/dev/tty.usbmodem1411", 57600);

  bottle_img = loadImage("bottle_img.png");
  PImage person_img = loadImage("person_img_2.png");
  dropper = new BottleDropper(bottle_img,model_w,0,    // upper left corner
                                         dropper_w,h); // lower right corner
  model = new ScaleModel(bottle_img,person_img,0,0,    // upper left corner
                                               200,600,// lower right corner
                                               15);
  //for(int i = 0; i < buttons.length; i++){
  //  buttons[i] = new Button(width-75,25+75*i);
  //}
  
  //sounds[0] = new SoundFile(this,"trickle.mp3"); // start_time should be 3 
  sounds[0] = new SoundFile(this,"faucet.wav"); // start_time should be 49
  sounds[1] = new SoundFile(this,"brook.wav"); // start_time should be 0
  sounds[2] = new SoundFile(this,"waterfall.mp3"); // start_time should be 0
  sounds[3] = new SoundFile(this,"waterfall.mp3"); // start_time should be 0
  
  
  for(int i = 0; i < sensors.length; i++){
    sensors[i] = new Sensor(pin_nums[i], bottle_nums[i], arduino, sounds[i], sound_start_times[i]);
  }

  
    
}
      
void draw() {
  
  // wipe the screen
  if(dropper.is_dropping()){
    background(255,255,255);
  } else {
    background(117,168,197);
    
    for(int i = 0; i < bottle_x.length; i++) {
      int xpos = bottle_x[i];
      int ypos = bottle_y[i];
      float angle = bottle_th[i];
      
      pushMatrix();
    
      translate(xpos,ypos);
      rotate(angle);
    
      imageMode(CENTER);
      image(bottle_img,0,0,b_width,b_height);
    
      popMatrix();
    }
  }

  // calculate the time since the last draw cycle
  new_time = millis();
  int dt = new_time - time;
  time = new_time;

  dropper.draw(dt);
  if(current_sound != null){
    if(!dropper.is_dropping()){
      current_sound.stop();
    }
  }
  int num_dropped = dropper.get_num_dropped();
  
  // separate the two halves of the screen
  if(dropper.is_dropping()){
    line(200,0,200,height);
  } else {
    textAlign(CENTER);
    textSize(50);
    text("WATER YOU EATING?",width/2,height/2);
  }
  
  // draw the scale model
  model.draw(dt,num_dropped);
  
  // draw the buttons
  //for (int i = 0; i < buttons.length; i++){
  //  buttons[i].draw();
  //}
  for (int i = 0; i < sensors.length; i++){
    sensors[i].sense();
    if (sensors[i].selected()) {
      if ( !dropper.is_dropping() ){
        dropper.drop_n_bottles(sensors[i].getNumBottles());
        current_sound = sensors[i].getSound();
        current_sound.cue(sensors[i].getSoundStart());
        current_sound.play();
      }
    }
  }

}

void keyPressed(){
  dropper.drop_n_bottles(100);
}

     