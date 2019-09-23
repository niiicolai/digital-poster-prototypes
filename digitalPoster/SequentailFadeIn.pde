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
  
  // used within sequential rects to 
  // keep track of which line to draw
  private int animationIndex;
  
  // used within sequential rects to
  // keep track of which lines is done drawing
  private boolean[] drawedElement;
  
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
  }
  
  public void reset() {
    drawedElement = new boolean[positions.length];
    animationPosition = new PVector[positions.length];
    for (int i = 0; i < positions.length; i++) {
       animationPosition[i] = new PVector(positions[i].x, positions[i].y); 
    }
    
    animationIndex = 0;
    finished = false;
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
    // if the line is finished drawing
    // return the function at the line below
    if (finished) {
      return; 
    }
    
    // Check if we are supposed to move on the y axis
    boolean moveOnYAxis = animationPosition[0].x == positions[1].x;
    
    // Check if we should either increase or decrease the position value
    boolean increase = (moveOnYAxis && animationPosition[0].y < positions[1].y) ||
                         (!moveOnYAxis && animationPosition[0].x < positions[1].x);
    
    // If we should increase we set speed to plus 1
    // if not, we set it to minus 1
    float speed = (increase ? 1 : -1);
    
    // Create a temporary vector used for velocity
    // which move either on x or y axis
    PVector tempVelocity = (moveOnYAxis ? new PVector(0, speed*velocity.y) : new PVector(speed*velocity.x, 0));

    if (moveOnYAxis) {
      // We check if the velocity is to high on the y axis
      // in order to end up at the correct point
      boolean velocityTooHighOnY = (increase ? animationPosition[0].y+tempVelocity.y > positions[1].y :
                                              animationPosition[0].y+tempVelocity.y < positions[1].y);
      
      // if it is too high, we apply a lower fixed velocity
      if (velocityTooHighOnY) {
        tempVelocity.y = speed*5;
      }
      
      // we do another check to see if its still too high
      velocityTooHighOnY = (increase ? animationPosition[0].y+tempVelocity.y > positions[1].y :
                                            animationPosition[0].y+tempVelocity.y < positions[1].y);
      
      // if it is we fall back to a very slow velocity
      if (velocityTooHighOnY) {
        tempVelocity.y = speed;
      }
    } else {
      
      // We check if the velocity is to high on the x axis
      // in order to end up at the correct point
      boolean velocityTooHighOnX = (increase ? animationPosition[0].x+tempVelocity.x > positions[1].x :
                                            animationPosition[0].x+tempVelocity.x < positions[1].x);
      
      // if it is too high, we apply a lower fixed velocity
      if (velocityTooHighOnX) {
        tempVelocity.x = speed*5;
      }
      
      // we do another check to see if its still too high
      velocityTooHighOnX = (increase ? animationPosition[0].x+tempVelocity.x > positions[1].x :
                                              animationPosition[0].x+tempVelocity.x < positions[1].x);
      
      // if it is we fall back to a very slow velocity
      if (velocityTooHighOnX) {
        tempVelocity.x = speed;
      }
    }
    
    // applies temporary velocity to the line's position
    animationPosition[0].add(tempVelocity);        
    
    // draw the line
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    // check if the line is done drawing by matching the equality of 
    // the current animation position and the end position
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y) {
      finished = true;
    }
  }
  
  private void drawRect() {
    // if the line is finished drawing
    // return the function at the line below
    if (finished) {
      return; 
    }        
    
    // check if all lines is done drawing
    boolean drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    // if they isn't all done
    if (!drawedAll) {
      
      // we find the next point
      int nextPointIndex = (animationIndex+1 >= positions.length ? 0 : animationIndex+1);
      
      // Check if we are supposed to move on the y axis
      boolean moveOnYAxis = animationPosition[animationIndex].x == positions[nextPointIndex].x;
      
      // Check if we should either increase or decrease the position value
      boolean increase = (moveOnYAxis && animationPosition[animationIndex].y < positions[nextPointIndex].y) ||
                         (!moveOnYAxis && animationPosition[animationIndex].x < positions[nextPointIndex].x);
      
      // If we should increase we set speed to plus 1
      // if not, we set it to minus 1
      float speed = (increase ? 1 : -1);
      
      // Create a temporary vector used for velocity
      // which move either on x or y axis
      PVector tempVelocity = (moveOnYAxis ? new PVector(0, speed*velocity.y) : new PVector(speed*velocity.x, 0));
      
      if (moveOnYAxis) {
        // We check if the velocity is to high on the y axis
        // in order to end up at the correct point
        boolean velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                            animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed*10;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                            animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed*5;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                              animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // // if it is we fall back to a very slow velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed;
        }
      } else {
        
        // We check if the velocity is to high on the x axis
        // in order to end up at the correct point
        boolean velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed*10;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed*5;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // // if it is we fall back to a very slow velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed;
        }                
      }  
      
      // applies temporary velocity to the line's position
      animationPosition[animationIndex].add(tempVelocity);
    }
    
    // draw the first line
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    // check if the first line is done drawing
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y &&
        !drawedElement[0]) {
      drawedElement[0] = true;
      animationIndex++;
    }
    
    // if the first line is done drawing
    if (drawedElement[0]) {
      // draw the second line
      line(positions[1].x, positions[1].y, animationPosition[1].x, animationPosition[1].y);
    
      // if the second line is done drawing
      if (animationPosition[1].x == positions[2].x &&
        animationPosition[1].y == positions[2].y &&
        !drawedElement[1]) {
        drawedElement[1] = true;
        animationIndex++;
      }
    }
    
    // if the second line is done drawing
    if (drawedElement[1]) {
      // draw the third line
      line(positions[2].x, positions[2].y, animationPosition[2].x, animationPosition[2].y);
    
      // if the third line is done drawing
      if (animationPosition[2].x == positions[3].x &&
        animationPosition[2].y == positions[3].y &&
        !drawedElement[2]) {
        drawedElement[2] = true;
        animationIndex++;
      }
    }
    
    // if the third line is done drawing
    if (drawedElement[2]) {
      // draw the fourth line
      line(positions[3].x, positions[3].y, animationPosition[3].x, animationPosition[3].y);
    
      // if the fourth line is done drawing
      if (animationPosition[3].x == positions[0].x &&
        animationPosition[3].y == positions[0].y &&
        !drawedElement[3]) {
        drawedElement[3] = true;
        animationIndex++;
      }
    }
    
    // if all elements is done drawing
    drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    if (drawedAll) {
      // finish the sequentialfadein
      finished = true;
    }
  }
}
