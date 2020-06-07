Agent strong, fast;

void setup() {
 size(1000,1000); 
 strong = new Agent(100,900,3,.04,color(255,0,0));
 
 fast = new Agent(900,900,1,.07,color(0,0,255));
}

void draw() {
  background(0,255,0);
  fast.render();
  strong.render();
  
  fast.toDest();
  strong.toDest();
  
  if(dist(fast.xPos, fast.yPos, strong.xPos, strong.yPos) <= 100) {
    if(strong.isActive) {
      fast.health -= strong.strength;  
    }
    if(fast.isActive) {
      strong.health -= fast.strength;
    }
  }
}
