class Textbox {
  // The top left point of the rect
  private PVector position;
  // The rect's length and height relative to the position
  private PVector size;
  
  // The text's fill color
  private color textColor;
  // The rect's fill color 
  private color rectFillColor;
  // The rect's stroke color
  private color rectStrokeColor;
  
  // The message this textbox should display
  private String message;
  // The number of pixels between the top left point and the text
  private float textIndent;
  // The size of the text
  private float textSize;
  // The way the text should align
  private int textAlignment;
  // The font of the text box
  // Set to the global textbox by default
  public PFont textFont = textboxFont;
  
  Textbox(PVector tempPosition, PVector tempSize, color tempTextColor, 
          color tempRectFillColor, color tempRectStrokeColor, 
          String tempMessage, float tempTextIndent, float tempTextSize,
          int tempTextAlign) {
    
    position = tempPosition;
    size = tempSize;
    textColor = tempTextColor;
    rectFillColor = tempRectFillColor;
    rectStrokeColor = tempRectStrokeColor;
    message = tempMessage;
    textIndent = tempTextIndent;
    textSize = tempTextSize;
    textAlignment = tempTextAlign;
  }
 
  // Draw the textbox
  public void display() {
    // Set rect fill color
    fill(rectFillColor);
    
    // Set rect stroke color
    stroke(rectStrokeColor);
    
    // Draw a rect
    rect(position.x, position.y, size.x, size.y);
    
    // Set text color
    fill(textColor);
    
    // Set the text size
    textSize(textSize);
    
    // Set text alignment
    textAlign(textAlignment);
    
    // Set the text font
    textFont(textFont);
    
    // Draw text
    text(message, position.x+textIndent, position.y+textIndent, size.x-textIndent*2, size.y-textIndent);
  }
}
