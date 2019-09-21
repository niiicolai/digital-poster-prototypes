class StartPage {
  // Label used to navigate between pages
  public String label = "START";
  
  // The page's background image
  Gif backgroundImageGif;
  // The path to the background gif
  String backgroundImagePath = "assets/images/frontPage.gif";
  
  // The start page's character
  PImage characterImage;
  // The path to the character image
  String characterImagePath = "assets/images/demo-character.png";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(150, 190);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes = new SequentailFadeIn[0];
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {                                        
    // Load the gif from our assets folder
    backgroundImageGif = new Gif(pApplet, backgroundImagePath);
    backgroundImageGif.play();
    
    // Load the image from the assets folder
    characterImage = loadImage(characterImagePath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2, height/1.5);
  }
  
  // the global navigate(string) function
  // call beforeDisplay on active page before display
  public void beforeDisplay() {
    for (int i = 0; i < sequentialShapes.length; i++) {
       sequentialShapes[i].reset(); 
    }
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    tint(255);
    // Draw the background image
    image(backgroundImageGif, 0, 0, width, height);
    
    // Draw the character image
    image(characterImage, characterPosition.x-characterSize.x, characterPosition.y, 
                          characterSize.x, characterSize.y);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    
    // if the user clicks somewhere on the screen
    if (Utility.isPointInsideRect(new PVector(mouseX, mouseY), 0, width, 0, height)) {
      // navigate to the avs Page
      navigate(avsPage.label);
    }
  }
}
