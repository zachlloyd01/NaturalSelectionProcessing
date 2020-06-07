class Agent {
  public float xPos = width / 2; //Default x-position of the agent
  public float yPos = height / 2; //Default y-position of the agent
  public float speed = .05; //Default speed of the agent
  public float strength = 1; //Default stength of the agent
  public float size = 100; //Default size of the agent
 
  public Agent() { } //Constructor uses default values
  
  public Agent(float x, float y, float st, float sp) {
    xPos = x;
    yPos = y;
    strength = st;
    speed = sp;
  }
  
  public void render() { 
    ellipseMode(CENTER);
    ellipse(xPos, yPos, size, size); //render the agent
  }
  
  public Agent Reproduce() { //Called when agent is to duplicate
    Agent newAgent = new Agent(); //New agent created during reproduction
    
    //random position on the board
    newAgent.xPos = random(5, width - 5); 
    newAgent.yPos = random(5, height - 5);
    
    //Set new speed value
    int speedLower = int(random(1)); //increase or decrease
    if(speedLower == 1) { //Increase
      newAgent.speed = speed + random(speed * .09, speed * .5); //Increase the speed semi-randomly
    }
    else { //Decrease
      newAgent.speed = (speed + random(speed * .09, speed * .5)) * -1; //Decrease the speed semi-randomly
    }
    
    //Set new strength value
    if(newAgent.speed > speed) { //Decrease
      newAgent.strength = strength - random(strength * .09, strength * .5); //Decrease the strength semi-randomly
    }
    
    else if(newAgent.speed < speed) { //Increase
      newAgent.strength = strength + random(strength * .09, strength * .5); //Increase the strength semi-randomly
    }
    
    else { //Neither
      newAgent.strength = strength;
    }
    
    //Floor the values
    if(newAgent.speed < .01) {
      newAgent.speed = .01;
    }
    
    if(newAgent.strength < 1) {
      newAgent.speed = 1;
    }
    return newAgent;
    
  }

}
