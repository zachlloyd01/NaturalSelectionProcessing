import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class NaturalSelection extends PApplet {

/*
 * KNOWN BUGS:
 * - really, really, really ugly
 */

ArrayList<Food> foodList = new ArrayList<Food>(); //Agents in the scene
ArrayList<Agent> agentList = new ArrayList<Agent>(); //Food in the scene

public void setup() {
   //Fairly large window


  //Add two initial, random agents
  agentList.add(
    new Agent(
      900,
      900,
      PApplet.parseInt(random(5)),
      1
    )
  );

  agentList.add(
    new Agent(
      100,
      900,
      PApplet.parseInt(random(5)),
      5
    )
  );
  addFood();
}

public void addFood() {
  for(int i = 0; i < 2; i++) {
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

public void draw() {
  background(0, 255, 0);
  if(millis() >= 1000) {
    foodPlace();
    agentRun();
  }
}

public void foodPlace() {
  for(int i = 0; i < foodList.size(); i++) {
    foodList.get(i).place();
  }
}

public void agentRun() {
  for(int i = 0; i < agentList.size(); i++) {
    Agent agent = agentList.get(i);
    if(!agent.foodFound) {
      agent.findFood(foodList);
    }
    else {
      agent.toFood();
    }
  }
}
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

  public float speed = .05f;

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
    speed = (Speed * .01f);
  }

  //Path find to food
  public void toFood() {
    float dx = food.xPos - xPos;
    xPos += dx * speed;

    float dy = food.yPos - yPos;
    yPos += dy * speed;
  }

  public void findFood(ArrayList<Food> foodList) {
    for(int i = 0; i < foodList.size(); i++) {

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
  public void settings() {  size(1000,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "NaturalSelection" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
