int time = 0;
int new_time = 0;
ArrayList<Bottle> bottles;
PImage bottle_img;
float bottles_per_sec = 10;
float milli_per_bottle = 1000/bottles_per_sec;
float t_minus = milli_per_bottle;

void setup() {
  size(400, 400);
  stroke(1.0);
  fill(1.0);
  
  bottle_img = loadImage("bottle_img.png");
  bottles = new ArrayList<Bottle>();
  for(int i = 0; i < bottles_per_sec; i++){
    bottles.add(new Bottle(bottle_img));
  }
    
}
      
void draw() {
  
  background(255,255,255);

  new_time = millis();
  int dt = new_time - time;
  t_minus = t_minus - dt;
  while(t_minus < 0){
    t_minus = t_minus + milli_per_bottle;
    bottles.add(new Bottle(bottle_img));
  }
  time = new_time;
  
  for(int i = bottles.size()-1; i >= 0; i--){
    Bottle bottle = bottles.get(i);
    bottle.update(dt);
    if(bottle.dead()){
      bottles.remove(i);
    } else {
      bottle.draw();
    }
  }
  
}
     