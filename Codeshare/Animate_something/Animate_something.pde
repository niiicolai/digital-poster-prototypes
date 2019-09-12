// A reference to the boat
Boat boat;

// The boat's spawn position
PVector boatSpawnPoint;

// The boat's size
PVector boatSize = new PVector(190, 40);

// The scale of the bottom line of the boat's first rect
PVector bottomRectVertexScale = new PVector(20, -20);

// The boat's sail speed
float boatSailSpeed = 5;

// How often the boat's sail timer should reset
float boatSailTimerRate = 2;

// The color of the processing display window
color backgroundColor = color(255);

void setup() {
  // Declare the size of the processing display window
  size(860, 700);  
  
  // Declare the boat's spawn point
  // # IMPORTANT - should always run after size()
  boatSpawnPoint = new PVector(0, height/2);
  // Declare a new instance of the boat with the required parameters
  boat = new Boat(boatSpawnPoint, boatSize, bottomRectVertexScale,
                  boatSailSpeed, boatSailTimerRate);
}

void draw() {
  // Draw the processing window's background color 
  background(backgroundColor);
  
  // Execute the boat's 'render' function
  boat.render();
  // Execute the boat's 'sail' function
  boat.sail();  
}

// Declare a class called 'Boat'
class Boat {
  // The boat's stroke color
  private color strokeColor;
  // The boat's fill color
  private color fillColor;
  // The last rgb value
  private int lastRgbValue = 255;
  // The position of the top left point of the 'bottom rect'
  // exclusive size and scale
  // Modify the position of the boat based of this vector
  private PVector position;
  
  // The length and height of the 'bottom rect'
  private PVector size;
  
  // Scales the position of the bottom-left and bottom-right vertex 
  private PVector bottomRectVertexScale;
  
  // The boat's chimneys position relative to 'bottom rect'
  private PVector[] chimneyRectPositions = new PVector[] {
    new PVector(70, 110),
    new PVector(100, 80)
  };
  
  // The length and height of the boat's chimneys
  private PVector[] chimneyRectSizes = new PVector[] {
    new PVector(20, 60),
    new PVector(20, 25)
  };
  // The length and height of the top cabin relative to the 'bottom rect'
  private PVector cabinTopRelativeSize = new PVector(100, 30);
  // The length and height of the middle cabin relative to the 'bottom rect'
  private PVector cabinMidleRelativeSize = new PVector(60, 30);
  
  // A float which increase every frame
  // and resets every it reach 'sailTimerRate'
  private float sailTimer;
  // How often the sail timer should reset
  private float sailTimerRate;
  // The number of pixel's the boat should move every time 
  // the timer resets
  private float sailSpeed;
  
  // The 'Boat' class' constructor
  Boat(PVector _position, PVector _size, PVector _bottomRectVertexScale, float _sailSpeed, float _sailTimerRate) {
    position = _position;
    size = _size;
    bottomRectVertexScale = _bottomRectVertexScale;
    sailSpeed = _sailSpeed;
    sailTimerRate = _sailTimerRate;
  }
  
  // A function which draws the boat
  public void render() {
    
    // Set the boat's fill color
    fill(fillColor);
    // Set the boat's stroke color
    stroke(strokeColor);
    
    // Draw the boat's chimneys
    for (int i = 0; i < chimneyRectSizes.length; i++) {
      rect(position.x+chimneyRectPositions[i].x, position.y-chimneyRectPositions[i].y, 
           chimneyRectSizes[i].x, chimneyRectSizes[i].y);
    }

    // Draw the top rect with a position and size relative to the first and middle rect
    rect(position.x+(cabinTopRelativeSize.x/2), position.y-cabinTopRelativeSize.y-cabinMidleRelativeSize.y, 
         size.x-cabinTopRelativeSize.x, cabinTopRelativeSize.y);
    
    // Draw the middle rect with a position and size relative to the 'bottom rect'
    rect(position.x+(cabinMidleRelativeSize.x/2), position.y-cabinMidleRelativeSize.y, 
         size.x-cabinMidleRelativeSize.x, cabinMidleRelativeSize.y);
    
    // Begin a shape block
    beginShape();
      // Defines the boat's first rect's corners
      // Top left corner
      vertex(position.x, position.y);
      // Top right corner
      vertex(position.x+size.x, position.y);
      // Bottom right corner
      vertex(position.x+size.x+bottomRectVertexScale.y, 
             position.y+size.y);
      // Bottom left corner
      vertex(position.x+bottomRectVertexScale.x, position.y+size.y);
    // Close the shape block
    endShape(CLOSE); 
  }
  
  // Move the boat along x with a defined speed
  // and the position resets when it's outside the picture
  public void sail() {
    // Increment 'timer' by 1
    sailTimer++;
    // If the timer is greater or equal to speed
    if (sailTimer >= sailTimerRate) {
      // Reset the timer
      sailTimer = 0;
      // Move the boat's position along x by speed
      position.x += sailSpeed;
      
      // Execute the boat's 'randomnize color' function
      boat.RandomnizeColors();
      
      // if the boat's x position is greater than the display windows
      // size plus the boat's size
      if (position.x > width+size.x) {
        // Move the boat out just before the picture start's on left side
        // of the processing window
        position.x = -size.x; 
      }
    }
  }
  
  // Move the boat to a given position
  public void SetPosition(float x, float y) {
    position = new PVector(x, y);
  }
  
  private void RandomnizeColors() {
    fillColor = color(random(lastRgbValue), random(lastRgbValue), random(lastRgbValue));
    strokeColor = color(random(lastRgbValue), random(lastRgbValue), random(lastRgbValue));
  }
}
