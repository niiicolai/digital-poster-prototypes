class StartPage {
  // Label used to navigate between pages
  public String label = "START";
  
  // The page's background image
  Gif backgroundImageGif;
  // The path to the background gif
  String backgroundImageUrl = "assets/images/frontPage.gif";
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {                                        
    // Load the image from our assets folder
    backgroundImageGif = new Gif(pApplet, backgroundImageUrl);
    backgroundImageGif.play();
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
    // Draw the background image
    image(backgroundImageGif, 0, 0, width, height);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    
    // if the user clicks inside the start button
    if (Utility.isPointInsideRect(new PVector(mouseX, mouseY), 0, width, 0, height)) {
      // navigate to the avs Page
      navigate(avsPage.label);
    }
  }
}
