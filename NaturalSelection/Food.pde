//Fruit? Carcass? IDK smth edible. Mmmmmm I could go for a mango RN NGL. Professor can I have a mango?
public class Food {
  
  /*
   * Position variables here
   */
  float xPos = width / 2;
  
  float yPos = height / 2;

  
  /* 
   * characteristic variables here
   */
   
  public float Size = 100; //TODO: make nutrition a thing?
  
  /*
   * State variables here
   */
   
  boolean isActive = true;
  
  //Empty constructor to use default values
  public Food() {
    
  }
  
  //Set custom values
  public Food(float x, float y) {
    xPos = x;
    yPos = y;
  }

  public void place() {
    fill(0,0,255); //TODO: color based on nutrition?
    ellipseMode(CENTER);
    ellipse(xPos,yPos,Size,Size);
  }
  
}
