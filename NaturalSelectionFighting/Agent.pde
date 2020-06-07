class Agent {
  public float xPos = width / 2; // Current Location
  public float yPos = height / 2; // Current Location
  
  public float strength = 1; //Strength
  public float speed = .05; //Speed
  
  public float health = 10; //HP the agent currently has
  
  public float size = 100; //size of the agent
  
  public boolean isActive = true; //did the agent die yet
  
  color c = color(0, 255,255); //color of the agent
  
  public Agent() { } //Generic Constructor
  
  public Agent(float x, float y, float st, float sp, color Color) { //Constructor to set values
    xPos = x; //set xpos
    yPos = y; //set ypos
    strength = st; //set strength
    speed = sp; //set speed
    c = Color; //set color
  }
  
  public void toDest() { //go to a place
    float dX = random(5, width - 5) - xPos; //random xpos
    xPos += dX * speed; //set x

    float dY = random(5, height - 5) - yPos; //random ypos
    yPos += dY * speed; //set y
  }
  
  public void render() { //show the agent
    if(isActive) { //if the agent is active
      ellipseMode(CENTER); //center the ellipse
      fill(c); //color the ellipse
      ellipse(xPos, yPos, size, size); //draw the ellipse
      if(health <= 0) { //check agent health
        isActive = false; //don't run the agent anymore
      }
    }
  }
  
}
