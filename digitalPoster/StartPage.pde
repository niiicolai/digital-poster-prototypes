class StartPage {
  // Label used to navigate between pages
  public String label = "START";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  Gif backgroundImageGif;
  // The path to the background gif
  String backgroundImagePath = "frontPage.gif";
  
  // The page's background color
  color backgroundColor = color(33, 26, 82);
  
  // The start page's character
  PImage characterImage;
  // The path to the character image
  String characterImagePath = "demo-character.png";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(70, 190);
  
  // The number of alpha applied to all images
  int imageTintAlpha = 0;  
  // How fast the alpha should increment
  int imageTintAlphaIncrement = 30;
  // The maximum image alpha
  int imageTintAlphaMax = 255;
  // Image tint rgb color
  color imageTintRgb = color(255);
  
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
    characterPosition = new PVector(width/2-characterSize.x/2, height/1.58);
  }
  
  // the global navigate(string) function
  // call beforeDisplay on active page before display
  public void beforeDisplay() {
    // set image tint alpha to zero
    // in order to fade in the background image
    imageTintAlpha = 0;
    
    // set to false so we can display this page another time
    isDisplaying = false;
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    
      
    // if the page isn't displayed
    if (!isDisplaying) {

      // set background color
      background(backgroundColor);
      
      // set image tint
      tint(imageTintRgb, imageTintAlpha);
      
      // increment 'imageTint' to fade in images
      // as long its value is less than image tint alpha max
      if (imageTintAlpha < imageTintAlphaMax) {
        imageTintAlpha += imageTintAlphaIncrement; 
      } else {
        // if the images are faded in, which is the last draw task
        // we set isDisplay to true
        isDisplaying = true;
        
        g.removeCache(backgroundImageGif);
        g.removeCache(characterImage);
      }
    
    }
    
    // Draw the background image
    // This have to execute every frame through draw
    // to ensure the gif to play
    image(backgroundImageGif, 0, 0, width, height);          
    
    // Draw the character image
    image(characterImage, characterPosition.x, characterPosition.y, 
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
