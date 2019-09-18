class GraphicDesignPage {
  // label used to navigate between pages
  public String label = "GRAPHICDESIGN";
  
  // The background color for this page
  private color backgroundColor = color(67, 35, 216);
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    
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
    
    // demo line
    line(width/2, 0, width/2, height);
    // demo text
    fill(0);
    text(label, 100, 100);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    // if the user clicks the left side of the screen
    if (Utility.clickedLeftSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the programming Page
      navigate(programmingPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the info Page
      navigate(infoPage.label);
    }
  }
}
