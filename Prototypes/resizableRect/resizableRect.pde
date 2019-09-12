// Position of collision text
PVector collisionTextPosition = new PVector(50, 50);

// Text color
color textColor = color(15, 250, 0);

// The display window's background color
color backgroundColor = color(0);

// A reference to the player
Player player;

// The fill color of the player
color playerFillColor = color(0, 68, 250);

// The player's top left point
PVector playerPosition = new PVector(100, 100);

// The player's size
PVector playerSize = new PVector(70, 70);

// A reference to the resizable rect
ResizableRect resizableRect;

// The fill color of the rect
color rectFillColor = color(255);

// Space between the rect and the processing display window
float rectPadding = 10;

// The rect's scale speed
PVector rectScaleSpeed = new PVector(.1, .1);

// Possible minSize (350, 350) due to scale resizing to the center
PVector rectMinSize = new PVector(10, 10);

// A float that should keep increasing every frame 
float timer;

// The number of frames that should run before the timer resets
float timerSpeed = .5;

// A float which is used to increase timerSpeed over time 
float timerSpeedMultiplier = .01;

void setup() {
  // In a program that has the setup(), the size() function must be the first line
  // of code inside setup(), and the function must appear in the code tab with the
  // same name as your sketch
  //
  // The size() function can only be used once inside a sketch, and it cannot be used
  // for resizing. 
  size(700, 700); 
  
  // Declare a new instance of the class 'ResizeableRect'
  // to do that, it needs a min size
  resizableRect = new ResizableRect(rectMinSize);
  // Declare a start position for our rect at the same point as our wanted padding
  resizableRect.position = new PVector(rectPadding, rectPadding);
  // Declare a size with the length of the screen subtracted by (padding*2)
  // The variable 'width' gives a float which is the screen's max x position
  // subtract this value by padding times 2 to get the position of the rect's top right point
  resizableRect.size = new PVector(width-rectPadding*2, height-rectPadding*2);
  // Declare the rect's fill color
  resizableRect.fillColor = rectFillColor;
  
  // Declare a new instance of the class 'Player'
  player = new Player();  
  // Declare the player's fill color
  player.fillColor = playerFillColor;  
  // Declare the player's position
  player.position = playerPosition;
  // Declare the player's size
  player.size = playerSize;
}

void draw() {
  // Declare the background color of the processing display window
  background(backgroundColor);
  
  // Execute the rect's render function 
  resizableRect.render();  
  
  // Increase the timer by 1 everytime draw is executed
  timer++;
  // Run the block of code between the brackets if the timer is equal or greater than timerSpeed
  if (timer >= timerSpeed) {
    // Reset the timer by setting it to zero
    timer = 0;
    // Decrease the value of timerSpeed to run this block of code more often
    timerSpeed -= (timerSpeed*timerSpeedMultiplier);  
    // Execute the rect's scale function by inserting a value of 
    // how much it should scale on the x and y points
    resizableRect.scale(rectScaleSpeed.x, rectScaleSpeed.y);
  }
  
  // Set the player to follow the cursor
  player.position = new PVector(mouseX, mouseY);
  // Execute the render function
  player.render();
  
  // Set the text color
  fill(textColor);
  // Declare a string with a start msg for debugging
  String playerCollisionMessage = "The player is ";
  // Adds a text saying 'inside the rect' or 'outside the rect'
  // based on the 'IsThePlayerInsideTheRect()' function
  playerCollisionMessage += (player.IsThePlayerInsideTheRect() ? "inside the rect" : "outside the rect");
  // Show the text
  text(playerCollisionMessage, collisionTextPosition.x, collisionTextPosition.y);
}

// Declare a class called 'Player'
class Player {
  // The player's fill color
  public color fillColor;
  // The top left point of the player
  public PVector position;
  // Defines how much the player should increase on the x and y points
  public PVector size;
  
  // A function that draws the actual player
  public void render() {
    // Declare the fill color of the player
    fill(fillColor);
    // Declare a shape block
    beginShape();
      // Defines the top left point
      vertex(topLeft().x, topLeft().y); 
      // Defines the top right point
      vertex(topRight().x, topRight().y);
      // Defines the bottom right point
      vertex(bottomRight().x, bottomRight().y);
      // Defines the bottom left point
      vertex(bottomLeft().x, bottomLeft().y);
    // Declare that the shape is done
    endShape(CLOSE);
  }
  
  // A function that returns true if the player is inside the resizable rect
  // and false if not
  public Boolean IsThePlayerInsideTheRect() {
    if (!resizableRect.IsPointInsideRect(topLeft().x, topLeft().y)) {
      return false;
    } else if (!resizableRect.IsPointInsideRect(topRight().x, topRight().y)) {
      return false;
    } else if (!resizableRect.IsPointInsideRect(bottomLeft().x, bottomLeft().y)) {
      return false;
    } else if (!resizableRect.IsPointInsideRect(bottomRight().x, bottomRight().y)) {
      return false;
    } else {
      return true; 
    }
  }
  
  // A function that returns a vector with the top left point
  private PVector topLeft() {
    return new PVector(position.x, position.y);
  }
  
  // A function that returns a vector with the top right point
  private PVector topRight() {
    return new PVector(position.x+size.x, position.y);
  }
  
  // A function that returns a vector with the bottom left point
  private PVector bottomLeft() {
    return new PVector(position.x, position.y+size.y);
  }
  
  // A function that returns a vector with the bottom right point
  private PVector bottomRight() {
    return new PVector(position.x+size.x, position.y+size.y);
  }
}

// Declare a class called 'ResizeableRect'
class ResizableRect {
  // Public variables => Can be used outside the class
  // The rect's fill color
  public color fillColor;
  // The top left point of the rect
  public PVector position;
  // Defines how much the rect should increase on the x and y points
  public PVector size;
  
  // Private variables => Can only be used inside the class
  // Defines min size
  private PVector minSize; 
  
  // Constructor
  // Instructions on how to setup the class
  // https://processing.org/tutorials/objects/
  ResizableRect(PVector _minSize) {
    // Declare the value of min size
    minSize = _minSize;
  }
  
  // A function that draws the actual rect
  public void render() {
    // Declare the fill color of the rect
    fill(fillColor);
    // Declare a shape block
    beginShape();
      // Defines the top left point
      vertex(topLeft().x, topLeft().y); 
      // Defines the top right point
      vertex(topRight().x, topRight().y);
      // Defines the bottom right point
      vertex(bottomRight().x, bottomRight().y);
      // Defines the bottom left point
      vertex(bottomLeft().x, bottomLeft().y);
    // Declare that the shape is done
    endShape(CLOSE);
  }
  
  // A function that scales the rect until it reaches its min size
  public void scale(float x, float y) {
    // Executes the block of code inside the brackets if
    // the length is less or equal to min length
    // OR the height is less or equal to min height
    if (Length() <= minSize.x || Height() <= minSize.y) {
        return;        
    }
    
    // In order to move the rect to the center from the top left point
    // it needs to increase the top left point
    position.x += x;
    position.y += y;
    // In order to move the rect to the center from the bottom left point
    // it needs to decrease the bottom left point multiplied by 2
    size.x -= x*2;
    size.y -= y*2;
  }
  
  // Returns true if a given point is inside the rect
  public boolean IsPointInsideRect(float x, float y) {
   boolean betweenXPoints = (x >= topLeft().x && x <= topRight().x);
   boolean betweenYPoints = (y >= topLeft().y && y <= bottomLeft().y);
   return betweenXPoints && betweenYPoints; 
  }
  
  // A function that returns the length from the top left point to the top right point
  public float Length() {
    return PVector.dist(topLeft(), topRight());
  }
  
  // A function that returns the length from the top left point to the bottom left point
  public float Height() {
    return PVector.dist(topLeft(), bottomLeft());
  }
  
  // A function that returns a vector with the top left point
  private PVector topLeft() {
    return new PVector(position.x, position.y);
  }
  
  // A function that returns a vector with the top right point
  private PVector topRight() {
    return new PVector(position.x+size.x, position.y);
  }
  
  // A function that returns a vector with the bottom left point
  private PVector bottomLeft() {
    return new PVector(position.x, position.y+size.y);
  }
  
  // A function that returns a vector with the bottom right point
  private PVector bottomRight() {
    return new PVector(position.x+size.x, position.y+size.y);
  }
}
