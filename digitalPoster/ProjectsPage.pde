class ProjectPage {
  // label used to navigate between pages
  public String label = "PROJECTPAGE";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "assets/images/projects.png";
  
  // The page's background color
  color backgroundColor = color(33, 26, 82);
  
  // The start page's character
  PImage characterImage;
  // The path to the character image
  String characterImagePath = "assets/images/demo-character.png";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(70, 190);
  
  // An array of all text messages
  String[] textMessages = new String[] {
    "Studiet følger Aalborg-modellen som er en læringsform udviklet på problembaseret læring (PBL). " +
    "Modellen stræber sig på at simulere et professionelt arbejdsmiljø. Projekterne støttes af forelæsninger, " +
    "workshops og en supervisor der kan kontaktes efter behov.",
    
    "Aalborg-modellen bygger på en række grundprincipper herunder, projektorganisering i grupper, samarbejde, vejleder, " +
    "eksterne parter, eksemplaritet og ansvar for egen læring. Modellen sørger for at de studerende har adgang til lokaler " +
    "og udstyr. ",
    
    "På Medialogi arbejdes der med lange projekter som normalt varer et helt semester. Det betyder at du vil have tid til at " +
    "sætte dig helt ind i et emne og fordybe dig i det. Da projekterne er tværfaglige er det nødvendigt at inddrage og kombinere " +
    "viden fra relevante kurser."
  };  
  
  // A reference to all text boxes on this page
  Textbox[] textboxes;
  // An array of all textbox positions
  PVector[] textboxPositions;
  // An array of all textbox sizes
  PVector[] textboxSizes;  
  // The number of pixels the textbox should indent on x axis
  float textboxPaddingX = 40;
  // The number of alpha applied to all images
  int textboxAlpha = 0;  
  // How fast the alpha should increment
  int textboxAlphaIncrement = 15;
  // The maximum textbox alpha
  int textboxAlphaMax = 255;
  // textbox rect fill color rgb values
  PVector rectFillColorRgb = new PVector(33, 26, 82);
  
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
  // Sequential rect velocity
  PVector sequentialRectVelocity = new PVector(70, 50);
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
    characterPosition = new PVector(width/2-characterSize.x/2, height/1.58);
    
     // Create an instance of a textbox array with same the length as 'textMessages'
    textboxes = new Textbox[textMessages.length];

    // Declare the size of the text boxes
    textboxSizes = new PVector[] {
      new PVector(240, 190),
      new PVector(240, 190),
      new PVector(width-textboxPaddingX*2, 90)
    };
    
    // Declare the position of the text boxes
    textboxPositions = new PVector[] {
      new PVector(textboxPaddingX, 150),
      new PVector(width-textboxPaddingX-textboxSizes[1].x, 150),
      new PVector(textboxPaddingX, 385)
    };
    
    // Create an instance of a textbox for each message, position and size
    for (int i = 0; i < textMessages.length; i++) {
      textboxes[i] = new Textbox(
          textboxPositions[i], textboxSizes[i], textMessages[i]);
    }
    
    // Declare an array of sequential shape
    sequentialShapes = new SequentailFadeIn[textboxPositions.length];
    for (int i = 0; i < textboxPositions.length; i++) {
      // Find the positions of our textboxes      
      PVector[] seqRectPositions = new PVector[]{
        // top left corner
        new PVector(textboxPositions[i].x, textboxPositions[i].y), 
        // bottom left corner
        new PVector(textboxPositions[i].x, textboxPositions[i].y+textboxSizes[i].y),
        // bottom right corner
        new PVector(textboxPositions[i].x+textboxSizes[i].x, textboxPositions[i].y+textboxSizes[i].y),
        // top right corner
        new PVector(textboxPositions[i].x+textboxSizes[i].x, textboxPositions[i].y)
      };
      
      // Create a new instances of a sequential rect 
      sequentialShapes[i] = new SequentailFadeIn(
        SEQUENTIALRECT, seqRectPositions, sequentialRectVelocity, 
        sequentialLineStrokeColor, color(backgroundColor), sequentialStrokeWeight);
    }
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
    textboxAlpha = 0;
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
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
    
    // increment 'imageTint' to fade in images
    // as long its value is less than image tint alpha max
    if (textboxAlpha < textboxAlphaMax) {
      
      // set rect fill color with the respective textbox alpha
      for (int i = 0; i < textboxes.length; i++) {
        textboxes[i].rectFillColor = color(rectFillColorRgb.x, rectFillColorRgb.y, rectFillColorRgb.z, textboxAlpha);
      }
      
      // increment textbox alpha
      textboxAlpha += textboxAlphaIncrement; 
    }

    // draw text boxes
    for (int i = 0; i < textboxes.length; i++) {
      textboxes[i].display();
    }
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
