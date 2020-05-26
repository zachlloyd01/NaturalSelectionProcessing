//The creature
class Agent {
  
  /* TODO:
   * Implement fighting
   * Implement food taking (modify int, set food active to false
   * Make food and dist global vars and implement resetting on a day-by-day
   * Genetic algorithm (random vals, bias, bias based on vals, etc.
   * A 1-in-100000 of a super creature that kills everything else (JK, JK.... Unless...)
   */
  
  
  
  /*
   * Positioning variables here
   */
   
  public float xPos = width / 2;
  public float yPos = height / 2;
  
   //Create a new food that is null, as it will be set to nearest food
  
  /*
   * Characteristic values here
   */
   
  public float Size = 100;
  
  public float speed = .05;
  
  public float strength = 1;
  
  public boolean run = true;
  
  public Food food = new Food();
  
  /*
   * State values here
   */
  public int foodAmount = 0;
  
  //Generic empty constructor to use default vals
  public Agent() {
    
  }
  
  //Custom values into constructors
  public Agent(float x, float y, float Strength, float Speed) {
    xPos = x;
    yPos = y;
    strength = Strength;
    speed = (Speed * .01);
  }
  
  //Path find to food
  public void toFood(ArrayList<Food> foodList) {
    if(foodList.size() > 0) {
      Food newFood = null;
      Float shortDist = null; //shortest distance to food
      if(shortDist == null) { //If the distance to the food is null
        for(int i = 0; i < foodList.size(); i++) { //For every food on the board
          
         float distance = dist(xPos, yPos, foodList.get(i).xPos, foodList.get(i).yPos); //Get the distance to the food
         if(shortDist == null) { //if the short dist is null
           shortDist = distance; //set the distance to the nearest food
           newFood = foodList.get(i); //set the food to the nearest food
         }
         else if(distance < shortDist) { //else check if there is a closer food
           shortDist = distance; //set the distance to the closer one
           newFood = foodList.get(i); //set food to the closer one
         }
        float dx = newFood.xPos - xPos;
        xPos += dx * speed;
        
        float dy = newFood.yPos - yPos;
        yPos += dy * speed;
        
        food = newFood;
      }
    }
   }
   else {
     randomWalk();
   }
  }
  
  private void randomWalk() {
    float dX = random(5, width - 5) - xPos;
    xPos += dX * speed;
    
    float dY = random(5, height - 5) - yPos;
    yPos += dY * speed;
  }
  
  //Show the agent on the board
  public void display() {
    fill(255,0,0); //TODO: dynamic color based on speed and strength
    ellipseMode(CENTER);
    ellipse(xPos, yPos, Size, Size); //Create the ellipse
  }
  
  public void reset() {
    run = false;
    if(foodAmount >= 2) {
      reproduce();
    }
    foodAmount = 0;
  }
  
  private void reproduce() {
    
  }
  
  public void eatFood(Food newFood) {
    newFood.isActive = false;
    foodAmount++;
  }
}
