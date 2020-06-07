/*
 * KNOWN BUGS:
 * - Pathfinding not random
 * - Food does not disappear
 */

ArrayList<Food> foodList = new ArrayList<Food>(); //Agents in the scene
ArrayList<Agent> agentList = new ArrayList<Agent>(); //Food in the scene

void setup() {
  size(1000,1000); //Fairly large window


  //Add two initial, random agents
  agentList.add( //List command
    new Agent( // New Agent instance
      900, //xpos
      900, //ypos
      int(random(5)), //speed and strength are random
      int(random(.01, .08))
    )
  );

  agentList.add(
    new Agent( // New Agent instance
      100, //xpos
      900, //ypos
      int(random(5)), //speed and strength are random
      int(random(.01, .08))
    )
  );
  addFood(); //Create food on the board
}

void addFood() { //Called @ beginning and after allotted run time
  for(int i = 0; i < 10; i++) { //Run 11 times
    float foodX = random(5, width - 5); //Create random pos on the board
    float foodY = random(5, height - 5); //Create random pos on the board

    for(int j = 0; j < agentList.size(); j++) { //For each agent on the board
      while(agentList.get(j).xPos == foodX || agentList.get(j).yPos == foodY) { //While food's new pos vars are the same as those of an agent
        foodX = random(5, width - 5); //Create random pos on the board
        foodY = random(5, height - 5); //Create random pos on the board
      }
    }
    foodList.add( //Add food at created position
      new Food( //new instance
        foodX, //xpos
        foodY //ypos
      )
    );
  }
}

void draw() { //Runs every frame
  background(0, 255, 0); //Green (grassy...?) background
  if(millis() >= 1000) { //Wait 1 second
    foodPlace(); //Put every food on the board
    agentRun(); //Run the agents
  }
}

void foodPlace() { //Runs every frame
  for(int i = 0; i < foodList.size(); i++) { //For each food in the list
    foodList.get(i).place(); //Draw the food
  }
}

void agentRun() { //Called every frame
  for(int i = 0; i < agentList.size(); i++) { //for each agent
    Agent agent = agentList.get(i); //create an agent instance assigned to the current iteration
    println(i, agent.foodFound); //print to see if the agent has found food
    agent.display(); //show the agent
    if(agent.food != null) { //If the agent's internal food variable is not null
      if(dist(agent.xPos, agent.yPos, agent.food.xPos, agent.food.yPos) <= 100) { //if the distance between agent and food is less than 100 "units"
        for(int j = 0; j < foodList.size(); j++) { //for each food
          if(foodList.get(i) == agent.food) { //if the food is the agent's food
            agent.food = null; //agent food is null
            foodList.remove(i); //remove the food from the scene (foodList)
            agent.foodAmount++; //agent has eaten a food
            agent.foodFound = false; //find a new food

          }
          else { //If the food is not the agent's (it found a new one)
            agent.foodFound = false; //Agent should find new food
          }
        }
      }
    }
    if(!agent.foodFound) { //If the agent hasn't found any food (or it ate one and needs more)
      agent.findFood(foodList); //Find more food
    }
    else { //If the agent has found food
      agent.toFood(); //Go to the food
    }
  }
}
