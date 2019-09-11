PVector boatSpawnPoint;
color backgroundColor = color(342, 222, 122);

Boat boat;

void setup() {
  size(860, 700);  
  
  boatSpawnPoint = new PVector(0, height/2);
  
  boat = new Boat();
  boat.speed = 5;
  boat.SetPosition(boatSpawnPoint.x, boatSpawnPoint.y);
  boat.size = new PVector(190, 40);
  boat.bottomRectVertexScale = new PVector(20, -20);
  
  boat.middleRectPosition = new PVector(30, 30);
  boat.middleRectSize = new PVector(130, 30);
  
  boat.topRectPosition = new PVector(50, 60);
  boat.topRectSize = new PVector(90, 30);
  
  boat.chimneyRectSizes = new PVector[] {
    new PVector(20, 60),
    new PVector(20, 25)
  };
  boat.chimneyRectPositions = new PVector[] {
    new PVector(70, 110),
    new PVector(100, 80)
  };
}

void draw() {
  background(backgroundColor);
  
  boat.Render();
  boat.Sail();
}

class Boat {
  
  // The position of the top left point of the 'bottom rect'
  // exclusive size and scale
  // Modify the position of the boat based of this vector
  public PVector position;
  
  // The length and height of the 'bottom rect'
  public PVector size;
  
  // Scales the position of the bottom-left and bottom-right vertex 
  public PVector bottomRectVertexScale;
  
  // The length and heigth of the 'middle rect'
  public PVector middleRectSize;
  // The boat's 'middle rect' position relative to 'bottom rect'
  public PVector middleRectPosition;
  
  // The length and height of the 'top rect'
  public PVector topRectSize;
  
  // The boat's 'top rect' position relative to 'bottom rect'
  public PVector topRectPosition;
  
  // The length and height of the boat's chimneys
  public PVector[] chimneyRectSizes;
  
  // The boat's chimneys position relative to 'bottom rect'
  public PVector[] chimneyRectPositions;
  
  private PVector cabinTopRelativeSize = new PVector(100, 30);
  private PVector cabinMidleRelativeSize = new PVector(60, 30);
  
  private float timer;
  public float speed;  
  
  public void Render() {
    for (int i = 0; i < chimneyRectSizes.length; i++) {
      rect(position.x+chimneyRectPositions[i].x, position.y-chimneyRectPositions[i].y, chimneyRectSizes[i].x, chimneyRectSizes[i].y);
    }

    rect(position.x+(cabinTopRelativeSize.x/2), position.y-cabinTopRelativeSize.y-cabinMidleRelativeSize.y, 
         size.x-cabinTopRelativeSize.x, cabinTopRelativeSize.y);
         
    rect(position.x+(cabinMidleRelativeSize.x/2), position.y-cabinMidleRelativeSize.y, 
         size.x-cabinMidleRelativeSize.x, cabinMidleRelativeSize.y);
    
    beginShape();
      vertex(position.x, position.y); // top -> left
      vertex(position.x+size.x, position.y); // top -> right
      vertex(position.x+size.x+bottomRectVertexScale.y, 
             position.y+size.y); // bottom -> left
      vertex(position.x+bottomRectVertexScale.x, position.y+size.y); // bottom -> right
    endShape(CLOSE); 
  }
  
  public void Sail() {
    timer++;
    if (timer >= speed) {
      position.x += speed;
      
      if (position.x > width+size.x) {
        position.x -= width-size.x; 
      }
    }
  }
  
  public void SetPosition(float x, float y) {
    position = new PVector(x, y);
  }
}
