import processing.serial.*;
import processing.sound.*;
import cc.arduino.*;

int time = 0;
int new_time = 0;

Arduino arduino;
BottleDropper dropper;
ScaleModel model;
//Button[] buttons = new Button[7];
Sensor[] sensors = new Sensor[1];
//int[] button_nums = {1,10,100,1000,2000,5000,10000};
int[] pin_nums = {5};
int[] bottle_nums = {1000};
SoundFile[] sounds = new SoundFile[1];
int[] sound_start_times = {3};
SoundFile current_sound;

int h = 600;
int model_w = 200;
int dropper_w = 600;

void setup() {
  size(800,600);
  stroke(1.0);
  fill(1.0);
  textSize(text_size);
  
  //println(Arduino.list());
  
  arduino = new Arduino(this, "/dev/tty.usbmodem1411", 57600);

  PImage bottle_img = loadImage("bottle_img.png");
  PImage person_img = loadImage("person_img_2.png");
  dropper = new BottleDropper(bottle_img,model_w,0,    // upper left corner
                                         dropper_w,h); // lower right corner
  model = new ScaleModel(bottle_img,person_img,0,0,    // upper left corner
                                               200,600,// lower right corner
                                               15);
  //for(int i = 0; i < buttons.length; i++){
  //  buttons[i] = new Button(width-75,25+75*i);
  //}
  
  sounds[0] = new SoundFile(this,"waterfall.mp3"); // start_time should be 0
  //sounds[?] = new SoundFile(this,"brook.mp3"); // start_time should be 0
  //sounds[?] = new SoundFile(this,"faucet.mp3"); // start_time should be 49
  //sounds[?] = new SoundFile(this,"trickle.mp3"); // start_time should be 3
  
  for(int i = 0; i < sensors.length; i++){
    sensors[i] = new Sensor(pin_nums[i], bottle_nums[i], arduino, sounds[i], sound_start_times[i]);
  }

  
    
}
      
void draw() {
  
  // wipe the screen
  background(255,255,255);

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
  line(200,0,200,height);
  
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
//void mouseClicked(){
//  for (int i = 0; i < buttons.length; i++){
//    if (buttons[i].inside(mouseX,mouseY)) {
//      dropper.drop_n_bottles(button_nums[i]);
//    }
//  }
//}
     