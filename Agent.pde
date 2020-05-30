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

  public boolean foodFound = false;
  private Food food;

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
  public void toFood() {
    float dx = food.xPos - xPos;
    xPos += dx * speed;

    float dy = food.yPos - yPos;
    yPos += dy * speed;
  }

  public void findFood(ArrayList<Food> foodList) {
    if(!foodFound && foodList.size() > 0) {
      float shortDist = 0.0;
      Food newFood;
      for(int i = 0; i < foodList.size(); i++) {
        float Dist = dist(xPos, yPos, foodList.get(i).xPos, foodList.get(i).yPos);
        if(shortDist == 0.0) {
          shortDist = Dist;
          newFood = foodList.get(i);
        }
        else if(Dist < shortDist) {
          shortDist = Dist;
          newFood = foodList.get(i);
        }
      }
      if(newFood != null) {
        foodFound = true;
      }
      else {
        randomWalk();
      }
    }
    else {
      if(foodList.size() <= 0) {
        randomWalk();
      }
      else {
        toFood();
      }
    }
  }

  public void randomWalk() {
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

  public void eatFood() {

  }
}
