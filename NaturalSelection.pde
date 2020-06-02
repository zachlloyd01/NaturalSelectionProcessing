/*
 * KNOWN BUGS:
 * - really, really, really ugly
 */

ArrayList<Food> foodList = new ArrayList<Food>(); //Agents in the scene
ArrayList<Agent> agentList = new ArrayList<Agent>(); //Food in the scene

void setup() {
  size(1000,1000); //Fairly large window


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
  addFood();
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

void draw() {
  background(0, 255, 0);
  if(millis() >= 1000) {
    foodPlace();
    agentRun();
  }
}

void foodPlace() {
  for(int i = 0; i < foodList.size(); i++) {
    foodList.get(i).place();
  }
}

void agentRun() {
  for(int i = 0; i < agentList.size(); i++) {
    Agent agent = agentList.get(i);
    agent.display();
    if(agent.food != null) {
      if(dist(agent.xPos, agent.yPos, agent.food.xPos, agent.food.yPos) <= 100) {
        for(int j = 0; j < foodList.size(); j++) {
          if(foodList.get(i) == agent.food) {
            agent.food = null;
            foodList.remove(i);
            agent.foodAmount++;
            agent.foodFound = false;

          }
          else {
            agent.foodFound = false;
          }
        }
      }
    }
    if(!agent.foodFound) {
      agent.findFood(foodList);
    }
    else {
      agent.toFood();
    }
  }
}
