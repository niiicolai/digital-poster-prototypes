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
  Gif characterGif;
  // The path to the character image
  String characterGifPath = "characterStartPage.gif";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(350, 320);
  
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
    
    // Load the image from the assets folder
    characterGif = new Gif(pApplet, characterGifPath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2-characterSize.x/2, height/2);
  }
  
  // the global navigate(string) function
  // call beforeDisplay on active page before display
  public void beforeDisplay() {
    // set image tint alpha to zero
    // in order to fade in the background image
    imageTintAlpha = 0;
    
    // set to false so we can display this page another time
    isDisplaying = false;
    
    // Set the gifs to start playing
    backgroundImageGif.play();
    characterGif.play();
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
      }
    
    }
    
    // Draw the background image
    // This have to execute every frame through draw
    // to ensure the gif to play
    image(backgroundImageGif, 0, 0, width, height);          
    
    // Draw the character image
    image(characterGif, characterPosition.x, characterPosition.y, 
                          characterSize.x, characterSize.y);
  }
  
  public void onHide() {
    // stop the gifs from playing
    backgroundImageGif.stop();
    characterGif.stop();
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
