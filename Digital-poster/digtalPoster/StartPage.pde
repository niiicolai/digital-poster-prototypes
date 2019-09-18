class StartPage {
  // Label used to navigate between pages
  public String label = "START";
  
  // The start button's position
  // This is set in init()
  private PVector startButtonPosition;
  // The start button's size
  private PVector startButtonSize = new PVector(200, 100);
  // The start button's fill color
  private color startButtonFillColor = color(255);
  // The start button's stroke color
  private color startButtonStrokeColor = color(93, 92, 88);
  // The start button's text
  private String startButtonLabel = "DRØMMER DU \nOM AT LÆSE IT?";
  // The start button's position
  // This is set in init() based on the button's position
  private PVector startButtonTextPosition;
  // The start button's text color
  private color startButtonTextColor = color(0);
  
  // The background color for this page
  private color backgroundColor = color(255);
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // center the start button in the middle of the screen
    startButtonPosition = new PVector((width/2)-(startButtonSize.x/2), 
                                      (height/2)-(startButtonSize.y/2));
    // center the start button text in the middle of the button
    startButtonTextPosition = new PVector(startButtonPosition.x+startButtonSize.x/4,
                                          startButtonPosition.y+startButtonSize.y/2);
  }
  
  // the global navigate(string) function
  // call hide on active pages before switch
  public void hide() {
    
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    // Set the background color
    background(backgroundColor);
    
    // draw start button
    stroke(startButtonStrokeColor);
    fill(startButtonFillColor);    
    rect(startButtonPosition.x, startButtonPosition.y,
         startButtonSize.x, startButtonSize.y);
         
    // draw start button text
    fill(startButtonTextColor);
    text(startButtonLabel, startButtonTextPosition.x, startButtonTextPosition.y);
    
    // demo text
    fill(0);
    text(label, 100, 100);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    
    // if the user clicks inside the start button
    if (Utility.isPointInsideRect(new PVector(mouseX, mouseY), startButtonPosition.x, startButtonPosition.x+startButtonSize.x, 
                                  startButtonPosition.y, startButtonPosition.y+startButtonSize.y)) {
      // navigate to the avs Page
      navigate(avsPage.label);
    }
  }
}
