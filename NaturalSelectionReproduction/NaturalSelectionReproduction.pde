public ArrayList<Agent> agents = new ArrayList<Agent>(); //List of all agents

void setup() {
  size(1000, 1000);
  agents.add(
    new Agent( //Add a random agent
      random(5, width - 5),
      random(5, height - 5),
      random(1, 6),
      random(.03, .09)
    )
  );
}

void draw() {
  background(0,0,200);
  for(int i = 0; i < agents.size(); i++) { //for each agent
    agents.get(i).render(); //render the agent
  }
}

void keyPressed() {
  ArrayList<Agent> newList = new ArrayList<Agent>();
  for(int i = 0; i < agents.size(); i++) { //for each agent
    Agent agent = agents.get(i);
    Agent newAgent = agent.Reproduce();
    newList.add(newAgent);
    println(
      "New Agent Stats:\n", 
       "Speed: ", newAgent.speed, "\n",
       "Strength: ", newAgent.strength, "\n"
    );
  }
  agents.addAll(newList);
}
