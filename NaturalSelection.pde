/*
 * KNOWN BUGS:
 * - really, really, really ugly
 */


ArrayList<Food> foodList = new ArrayList<Food>(); //Agents in the scene
ArrayList<Agent> agentList = new ArrayList<Agent>(); //Food in the scene

/*
 * Timer stuffs
 */
 
 int dayTime; //current time elapsed
 int dayWait = 45000; //time for day cycle


void setup() {
  size(1000,1000); //Fairly large window
  
  dayTime = millis();
  
  addFood();
  
  //Add two initial, random agents
  agentList.add(
    new Agent(
      900,
      900,
      int(random(5)),
      1
    )
  );
  
  agentList.add(
    new Agent(
      100,
      900,
      int(random(5)),
      5
    )
  );
  
}

void draw() {
  background(0, 255, 0);
  //Check for time
  if(millis() - dayTime >= dayWait) {
    foodList = new ArrayList<Food>();
    dayTime = millis();
    for(int i = 0; i < agentList.size(); i++) {
       Agent agent = agentList.get(i);
       
       if(agent.foodAmount <= 0) {
         agentList.remove(i);
         break;
       }
       
       agent.reset();
       
    }
    for(int i = 0; i < agentList.size(); i++) {
      agentList.get(i).run = true;
    }
  }
  
  //Day cycle code
  for(int i = 0; i < foodList.size(); i++) {
    
    if(!foodList.get(i).isActive) { //if the food is no longer active (will be set by agents)
      foodList.remove(i); //remove it from the list (will be deleted on next update)
      break; //break from the loop
    }
    
    else { //If it is active
      foodList.get(i).place(); //put it in the scene
    } 
  }
  
  for(int i = 0; i < agentList.size(); i++) {
    agentList.get(i).display(); //every agent display
    agentList.get(i).toFood(foodList); //every agent go to food
  }
}

void addFood() {
  for(int i = 0; i < 10; i++) {
    float foodX = random(5, width - 5);
    float foodY = random(5, height - 5);
    
    for(int j = 0; j < agentList.size(); j++) {
      while(agentList.get(j).xPos == foodX || agentList.get(j).yPos == foodY) {
        foodX = random(5, width - 5);
        foodY = random(5, height - 5);
      }
    }
    foodList.add(
      new Food(
        foodX,
        foodY
      )
    );
  }
}
