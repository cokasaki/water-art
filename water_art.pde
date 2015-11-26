int time = 0;
int new_time = 0;

PImage bottle_img;
BottleDropper dropper;
ScaleModel model;

void setup() {
  size(800, 600);
  stroke(1.0);
  fill(1.0);
  
  bottle_img = loadImage("bottle_img.png");
  dropper = new BottleDropper(bottle_img,200,0,600,600);
  model = new ScaleModel(bottle_img,0,0,200,600,15);
  dropper.drop_n_bottles(300);
    
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

}
     