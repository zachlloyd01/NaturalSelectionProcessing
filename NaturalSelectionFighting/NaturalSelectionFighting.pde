Agent strong, fast; //Two testing agents

void setup() {
 size(1000,1000); //big window
 strong = new Agent(100,900,3,.04,color(255,0,0)); //Agent instance
 
 fast = new Agent(900,900,1,.07,color(0,0,255)); //Agent instance
}

void draw() {
  background(0,255,0); //green background
  fast.render(); //render Agent
  strong.render(); //render Agent
  
  fast.toDest(); //go towards chosen point
  strong.toDest(); //go towards chosen point
  
  if(dist(fast.xPos, fast.yPos, strong.xPos, strong.yPos) <= 100) { //If agents in range
    if(strong.isActive) { //if agent active
      fast.health -= strong.strength; //hurt other agent
    }
    if(fast.isActive) { //if agent active
      strong.health -= fast.strength; //hurt other agent
    }
  }
}
