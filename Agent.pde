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

  public float xPos = width / 2; //Default x-position is middle
  public float yPos = height / 2; //Default y-position is middle



   

  /*
   * Characteristic values here
   */

  public float Size = 100; //Size of agent

  public float speed = .05; //default speed

  public float strength = 1; //default strength

  public boolean run = true; //always run

  public boolean foodFound = false; //has the agent decided which food to nav to?

  private Food food; //Create a new food that is null, as it will be set to nearest food

  /*
   * State values here
   */
  public int foodAmount = 0; //amt of food eaten

  //Generic empty constructor to use default vals
  public Agent() {

  }

  //Custom values into constructors
  public Agent(float x, float y, float Strength, float Speed) {
    xPos = x;
    yPos = y;
    strength = Strength;
    speed = .08;
  }

  //Path find to food
  public void toFood() {
    if(food != null) { //if the agent has decided food
      float dx = food.xPos - xPos; //Direction btwn agent and food
      xPos += dx * speed; //add direction by speed to agent's position

      float dy = food.yPos - yPos; //Direction btwn agent and food
      yPos += dy * speed; //add direction by speed to agent's position
    }

  }

  public void findFood(ArrayList<Food> foodList) { //Find the nearest food to the agent
    if(!foodFound && foodList.size() > 0) { //If food has not been found and the list of food is greater than 0
      float shortDist = 0.0; //The shortest distance set to default val
      Food newFood = new Food(); //New food to be set via logic later
      for(int i = 0; i < foodList.size(); i++) { //for each food in the list
        float Dist = dist(xPos, yPos, foodList.get(i).xPos, foodList.get(i).yPos); //distance between agent and food
        if(shortDist == 0.0) { //if shortDist is the default value (0.0), then this is the first iteration
          shortDist = Dist; //set shortest distance to the current distance
          newFood = foodList.get(i); //Set food to current iteration
        }
        else if(Dist < shortDist) { //This is not the first iteration and there is a closer food
          shortDist = Dist; //shortest distance is current distance
          newFood = foodList.get(i); //Set food to current location
        }
      }
      if(newFood != null) { //If a food was found via the process (sometimes breaks)
        foodFound = true; //Agent has decided where to go
        food = newFood; //Set global food val
      }
      else { //No food was found
        randomWalk(); //Randomly move across the map
      }
    }
    else { 
      if(foodList.size() <= 0) { //Make sure this was not running between food refill
        randomWalk(); //Randomly move across the map
      }
      else {
        toFood(); //Go to global food
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

  public void reset() { //Between days
    run = false; //Do not run
    if(foodAmount >= 2) { //If it ate 2 food
      reproduce(); //do da deed
    }
    else if(foodAmount >= 1) { //If it ate one food
      return; //Do nothing
    }
    else if(foodAmount <= 0) { //If it ate no food
      //TODO: Implement death
    }
    foodAmount = 0; //reset food eaten for the day
  }

  private void reproduce() {
    //TODO: Implement reproduction
  }

}
