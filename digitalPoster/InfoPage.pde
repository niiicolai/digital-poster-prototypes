class InfoPage {
  // label used to navigate between pages
  public String label = "INFO";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "info.jpg";
  
  // The page's background color
  color backgroundColor = color(33, 26, 82);
  
  // The start page's character
  PImage characterImage;
  // The path to the character image
  String characterImagePath = "demo-character.png";
  // The position of the character image
  PVector characterPosition = new PVector(0, 30);
  // The size of the character image
  PVector characterSize = new PVector(70, 190);
  
  // An array of social media icons
  PImage[] socialMediaIconImages;
  // The path to the character image
  String[] socialMediaIconPaths =  new String[] {
    "f_logo_RGB-Blue_250.png",
    "glyph-logo-may_2016.png",
    "snap-ghost-yellow.png"
  };
  
  // The footer rect's stroke color
  color footerRectStrokeColor = color(33, 26, 82);
  // footer height divider
  float footerRectHeightDivider = 1.5;
  // The number of alpha applied to the footer's rect
  int footerRectAlpha = 0;  
  // How fast the alpha should increment
  int footerRectAlphaIncrement = 30;
  // The maximum footer's rect alpha
  int footerRectAlphaMax = 255;
  // footer's rect fill color rgb values
  PVector footerRectFillColorRgb = new PVector(33, 26, 82);
  
  // Footer title text
  String footerTitle = "Medialogi";
  // Footer title padding on the y axis
  float footerTitleYPadding = 55;
  // Footer title text size
  float footerTitleTextSize = 50;
  
  // Footer message text
  String footerMessage = 
    "Hvis du vil læse mere gå da ind på aau.dk og find Medialogy\n" +
    "eller gå direkte ind på https://www.aau.dk/uddannelser/bachelor/medialogi.\n" +
    "Du kan læse medialogy i både København og Aalborg.\n" +
    "Husk at ansøg senest d. 5. juli kl. 12:00\n" +
    "Du kan møde os til åbent hus d. 6 februar 13:00 til 17:00!\n" +
    "Frederik Bajers Vej 7K\nPostboks 159 9100 Aalborg\n" +
    "Telefon: 9940 9940\n" +
    "Mail: aau@aau.dk\n\n" +
    "facebook.com/AalborgUniversitet\n" +
    "instagram.com/aaustudieliv\n" +
    "Snapchat: aauuni";
  // Footer message padding y the y axis
  float footerMessageYPadding = 90;
  // footer message text size;
  float footerMessageTextSize = 10;
  
  // Footer text alignment
  public int footerTextAlignment = CENTER;
  // Footer text color
  color footerTextColor = 255;  
  
  // The number of alpha applied to all images
  int imageTintAlpha = 0;  
  // How fast the alpha should increment
  int imageTintAlphaIncrement = 20;
  // The maximum image alpha
  int imageTintAlphaMax = 255;
  // Image tint rgb color
  color imageTintRgb = color(255);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  // Sequential line stroke color
  color sequentialLineStrokeColor = color(89, 79, 191);
  // Sequential line velocity on x axis
  PVector sequentialLineVelocityX = new PVector(30, 0);
  // The number of pixels the sequential line should
  // be from the character on y axis
  float sequentialLineYPadding = 20;
  // Sequential stroke weight
  float sequentialStrokeWeight = 1;
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // Load the image from our assets folder
    bgImage = loadImage(backgroundImagePath);
    
    // Load the image from the assets folder
    characterImage = loadImage(characterImagePath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2-characterSize.x/2, height/2.7);
    
    // Find the positions for the sequential line
    PVector[] seqLinePositions = new PVector[]{
      new PVector(0, height/footerRectHeightDivider), 
      new PVector(width, height/footerRectHeightDivider)      
    };
    
    // Declare an array of sequential shape
    sequentialShapes = new SequentailFadeIn[1];
    
    // Create a new instances of a sequential line
    sequentialShapes[0] = new SequentailFadeIn(
      SEQUENTIALLINE, seqLinePositions, sequentialLineVelocityX, 
      sequentialLineStrokeColor, color(backgroundColor), sequentialStrokeWeight);
  }
  
  // the global navigate(string) function
  // call beforeDisplay on active page before display
  public void beforeDisplay() {
    // reset all sequential shapes
    // in order to show them on display
    for (int i = 0; i < sequentialShapes.length; i++) {
       sequentialShapes[i].reset(); 
    }
    
    // set image tint alpha to zero
    // in order to fade in the background image
    imageTintAlpha = 0;
    
    // set textbox alpha to zero
    // in order to fade textboxes in on page switch
    footerRectAlpha = 0;
    
    // set to false so we can display this page another time
    isDisplaying = false;
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    // stop executing display() if it's already is displayed
    if (isDisplaying) {
      return;
    }
    
    // set background color
    background(backgroundColor);
    
    // set image tint
    tint(imageTintRgb, imageTintAlpha);
    
    // increment 'imageTint' to fade in images
    // as long its value is less than image tint alpha max
    if (imageTintAlpha < imageTintAlphaMax) {
      imageTintAlpha += imageTintAlphaIncrement; 
    }
    
    // Draw the background image
    image(bgImage, 0, 0, width, height);
    
    // Draw the character image
    image(characterImage, characterPosition.x, characterPosition.y, 
                          characterSize.x, characterSize.y);

    // Declare a boolean which says all transitions is finished
    boolean sequentialTransitionFinished = true;
    // Loop through all sequential shapes
    for (int i = 0; i < sequentialShapes.length; i++) {
      // if one of the shapes is not finished
      if (!sequentialShapes[i].finished) {
        // set the boolean to false
        sequentialTransitionFinished = false;
        // and break the loop since our check is done
        break;
      }
    }
    
    // if all the sequential transitions wasn't finished
    // we keep display them
    if (!sequentialTransitionFinished) {
      // we loop through our array of sequential shapes
      for (int i = 0; i < sequentialShapes.length; i++) {
        // and call their display function
        sequentialShapes[i].display(); 
      }
      // we return 'this' display function
      // to stop running this function
      // until our sequential shapes are done drawing
      return;
    }
    // If all sequential transitions is finished
    // the code will continue running from this point
    // and otherwhise not
    
    // Set footer rect stroke color
    stroke(footerRectStrokeColor);
    
    // Declare a color based on rgb values and alpha
    color tempFooterRectFillColor = color(footerRectFillColorRgb.x, 
                                          footerRectFillColorRgb.y, 
                                          footerRectFillColorRgb.z, footerRectAlpha);
    
    // Set footer rect fill color
    fill(tempFooterRectFillColor);
    
    // Draw footer rect
    rect(0, height/footerRectHeightDivider, width, height);
    
    // increment 'footerRectAlpha' to fade in the footer rect
    // as long its value is less than footerRect alpha max
    if (footerRectAlpha < footerRectAlphaMax) {
      // increment footer rect's alpha
      footerRectAlpha += footerRectAlphaIncrement; 
      
      // return at this point if we are fading
      // in the footer rect
      return;
    } else {
      // if the footer rect are faded in, which is the last draw task
      // we set isDisplay to true
      isDisplaying = true;
      
      g.removeCache(bgImage);
      g.removeCache(characterImage);
    }
    // if the footer rect is done fading
    // the code will continue to from this point
    
    // Set text alignment
    textAlign(footerTextAlignment);
    
    // Set text color
    fill(footerTextColor);
    
    // Set footer title text size
    textSize(footerTitleTextSize);
    
    // Draw footer title text
    text(footerTitle, width/2, height/footerRectHeightDivider+footerTitleYPadding);
    
    // Set footer message text size
    textSize(footerMessageTextSize);    
    
    // Draw footer message text
    text(footerMessage, width/2, height/footerRectHeightDivider+footerMessageYPadding);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {

    // if the user clicks somewhere on the screen
    if (Utility.isPointInsideRect(new PVector(mouseX, mouseY), 0, width, 0, height)) {
      // navigate to the start Page
      navigate(startPage.label);
    }
  }
}
