// The utility class
// holds helper functions for all classes to use
static class Utility {
  
  // Return true if a vector points is inside a rect based on
  // topLeft corner x position, topRight corner x position
  // topLeft corner y position, bottomLeft corner y position
  public static boolean isPointInsideRect(PVector point, float topLeftX, float topRightX, 
                                   float topLeftY, float bottomLeftY) {
    // Check if the point is inside the rect on x axis
    boolean isInsideOnXAxis = (point.x >= topLeftX && point.x <= topRightX);
    // Check if the point is inside the rect on y axis
    boolean isInsideOnYAxis = (point.y >= topLeftY && point.y <= bottomLeftY);
    // Return true if both conditions are true
    return (isInsideOnXAxis && isInsideOnYAxis);
  }
  
  public static boolean clickedLeftSideOfTheScreen(PVector mousePosition, float _width, float _height) {
    return isPointInsideRect(
      mousePosition, 
      0, _width/2, 
      0, _height
    );
  }
  
  public static boolean clickedRightSideOfTheScreen(PVector mousePosition, float _width, float _height) {
    return isPointInsideRect(
      mousePosition, 
      _width/2, _width, 
      0, _height
    );
  }
}
