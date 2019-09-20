class Textbox {
  // The top left point of the rect
  private PVector position;
  // The rect's length and height relative to the position
  private PVector size;  
  
  // The text's fill color
  public color textColor = color(255);
  // The rect's fill color 
  public color rectFillColor = color(33, 26, 82);
  // The rect's stroke color
  public color rectStrokeColor = color(33, 26, 82);
  
  // The message this textbox should display
  private String message;
  // The number of pixels between the top left point and the text
  public float textIndent = 15;
  // Declare rounded corners on the rect
  public float rectRoundedCorner = 3;
  // The size of the text
  //private float textSize;
  // Declare the text alignment
  public int textAlignment = LEFT;
  // The font of the text box
  // Set to the global textbox by default
  public PFont textFont = textboxFont;
  
  Textbox(PVector tempPosition, PVector tempSize, String tempMessage) {
    position = tempPosition;
    size = tempSize;
    message = tempMessage;
  }
 
  // Draw the textbox
  public void display() {
    // Set rect fill color
    fill(rectFillColor);
    
    // Set rect stroke color
    stroke(rectStrokeColor);
    
    // Draw a rect
    rect(position.x, position.y, size.x, size.y+textIndent, rectRoundedCorner);
    
    // Set text color
    fill(textColor);
    
    // Set the text size
    //textSize(textSize);
    
    // Set text alignment
    textAlign(textAlignment);
    
    // Set the text font
    textFont(textFont);
    
    // Draw text
    text(message, position.x+textIndent, position.y+textIndent, size.x-textIndent*2, size.y-textIndent);
  }
}
