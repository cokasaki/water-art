import processing.serial.*;
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
int[] bottle_nums = {10};


int h = 600;
int model_w = 200;
int dropper_w = 600;

void setup() {
  size(800,600);
  stroke(1.0);
  fill(1.0);
  textSize(text_size);
  
  arduino = new Arduino(this, "/dev/tty.usbmodem641", 57600);
  
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
  
  for(int i = 0; i < sensors.length; i++){
    sensors[i] = new Sensor(pin_nums[i], bottle_nums[i], arduino);
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
      dropper.drop_n_bottles(sensors[i].getNumBottles());
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

     