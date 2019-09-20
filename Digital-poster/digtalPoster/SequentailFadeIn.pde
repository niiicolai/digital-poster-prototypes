final int SEQUENTIALLINE = 0;
final int SEQUENTIALRECT = 1;
class SequentailFadeIn {
  
  // returns true if the animation is done
  public boolean finished;
  
  // the animation's velcocity
  private PVector velocity;

  // Determines the shape
  private int shape;
  
  // the animation's current positions
  private PVector[] animationPosition;
  
  private int animationIndex;
  
  // the animation's positions
  // LINE
  // 0 => start position
  // 1 => end position
  // RECT
  // 0 => top left corner
  // 1 => top right corner
  // 2 => bottom left corner
  // 3 => bottom right corner
  private PVector[] positions;
  
  private boolean[] drawedElement;
  
  // the shape's stroke color
  private color strokeColor;
  
  // the shape's fill color
  // can be 'null' if the shape is a line
  private color fillColor;
  
  // the size of the stroke
  private float strokeSize;

  SequentailFadeIn(int tempShape, PVector[] tempPositions, PVector tempVelocity, color tempStrokeColor, color tempFillColor, float tempStrokeSize) {
    shape = tempShape;
    positions = tempPositions;    
    velocity = tempVelocity;
    strokeColor = tempStrokeColor;
    fillColor = tempFillColor;
    strokeSize = tempStrokeSize;
    
    drawedElement = new boolean[tempPositions.length];
    animationPosition = new PVector[tempPositions.length];
    for (int i = 0; i < tempPositions.length; i++) {
       animationPosition[i] = new PVector(tempPositions[i].x, tempPositions[i].y); 
    }
  }
  
  // run display until a sequential animation 'finished' returns true
  public void display() {
    // set stroke color
    stroke(strokeColor);
    
    // set stroke size
    strokeWeight(strokeSize);
    
    // if the shape is not a line
    if (shape != SEQUENTIALLINE) {
      // Set a fill color
      fill(fillColor); 
    }
    
    // if we selected a sequential line
    if (shape == SEQUENTIALLINE) {
      // run the draw line function
      drawLine();
    // if we selected a sequential rect
    } else if (shape == SEQUENTIALRECT) {
      // run the draw rect function
      drawRect();
    }
  }
  
  private void drawLine() {
    if (finished) {
      return; 
    }
    
    animationPosition[0].add(velocity);        
    
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y) {
      finished = true;
    }
  }
  
  private void drawRect() {
    if (finished) {
      return; 
    }        
    
    boolean drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    if (!drawedAll) {
      int nextPointIndex = (animationIndex+1 >= positions.length ? 0 : animationIndex+1);
      
      boolean moveOnYAxis = animationPosition[animationIndex].x == positions[nextPointIndex].x;
      boolean increase = (moveOnYAxis && animationPosition[animationIndex].y < positions[nextPointIndex].y) ||
                         (!moveOnYAxis && animationPosition[animationIndex].x < positions[nextPointIndex].x);
      float speed = (increase ? 1 : -1);
      PVector tempVelocity = (moveOnYAxis ? new PVector(0, speed*velocity.y) : new PVector(speed*velocity.x, 0));
      
      boolean velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
      if (velocityTooHighOnX) {
        tempVelocity.x = speed;
      }
      
      boolean velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                            animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
      if (velocityTooHighOnY) {
        tempVelocity.y = speed;
      }
      
      animationPosition[animationIndex].add(tempVelocity);       
    }
    
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y &&
        !drawedElement[0]) {
      drawedElement[0] = true;
      animationIndex++;
    }
    
    if (drawedElement[0]) {
      line(positions[1].x, positions[1].y, animationPosition[1].x, animationPosition[1].y);
    
      if (animationPosition[1].x == positions[2].x &&
        animationPosition[1].y == positions[2].y &&
        !drawedElement[1]) {
        drawedElement[1] = true;
        animationIndex++;
      }
    }
    
    if (drawedElement[1]) {
      line(positions[2].x, positions[2].y, animationPosition[2].x, animationPosition[2].y);
    
      if (animationPosition[2].x == positions[3].x &&
        animationPosition[2].y == positions[3].y &&
        !drawedElement[2]) {
        drawedElement[2] = true;
        animationIndex++;
      }
    }
    
    if (drawedElement[2]) {
      line(positions[3].x, positions[3].y, animationPosition[3].x, animationPosition[3].y);
    
      if (animationPosition[3].x == positions[0].x &&
        animationPosition[3].y == positions[0].y &&
        !drawedElement[3]) {
        drawedElement[3] = true;
        animationIndex++;
      }
    }
    
    drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    if (drawedAll) {
      finished = true;
    }
  }
}
