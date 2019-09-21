class AvsPage {
  // label used to navigate between pages
  public String label = "AVS";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "assets/images/audioVisualSketching.png";
  
  // The page's background color
  color backgroundColor = color(203, 222, 223);
  
  // The start page's character
  PImage characterImage;
  // The path to the character image
  String characterImagePath = "assets/images/demo-character.png";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(150, 190);
  
  // An array of all text messages
  String[] textMessages = new String[] {
    "Medialogi er en videregående uddannelse på AAU CPH som fokuserer på computerteknologi, kreativitet og praksis. Medialogi kombinerer viden om lyd, design, 3D, matematik, data, programmering og meget mere til at producere lærerige produkter, spil og software.",
    "I Audio Visuel Sketching kommer du til lære hvordan du kommunikerer din gode idé igennem skitser, grafisk design, fysiske prototyper, fotos, 3D-print, 3D-modellering, og animationer. ",
    "Derudover kommer du også til at arbejde med pipelines, storyboarding, pre-visualiseringer og animatic til at producere audiovisuelle kortfilm og animationsproduktioner. "
  };  
  
  // A reference to all text boxes on this page
  Textbox[] textboxes;
  // An array of all textbox positions
  PVector[] textboxPositions;
  // An array of all textbox sizes
  PVector[] textboxSizes;  
  // The number of pixels the textbox should indent on x axis
  float textboxPaddingX = 40;
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  
  int imageTint = 0;
  
  SequentailFadeIn sequentialLine;
  SequentailFadeIn sequentialRect;
  SequentailFadeIn sequentialRect1;
  SequentailFadeIn sequentialRect2;
  SequentailFadeIn sequentialRect3;
  color sequentialLineStrokeColor = color(89, 79, 191);
  PVector sequentialVelocity = new PVector(40, 40);
  PVector sequentialVelocity2 = new PVector(55, 50);
  float strokeWeight = 1;

  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // Load the image from our assets folder
    bgImage = loadImage(backgroundImagePath);  
    
    // Load the image from the assets folder
    characterImage = loadImage(characterImagePath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2, height/1.5);
    
    // Create an instance of a textbox array with same the length as 'textMessages'
    textboxes = new Textbox[textMessages.length];

    // Declare the size of the text boxes
    textboxSizes = new PVector[] {
      new PVector(240, 190),
      new PVector(240, 190),
      new PVector(width-textboxPaddingX*2, 70)
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
    
    PVector[] seqLinePositions = new PVector[]{
      new PVector(0, characterPosition.y+characterSize.y-45), 
      new PVector(width, characterPosition.y+characterSize.y-45)      
    };
    sequentialLine = new SequentailFadeIn(SEQUENTIALLINE, seqLinePositions, new PVector(20, 0), sequentialLineStrokeColor, color(backgroundColor), strokeWeight);
    
    PVector[] seqRectPositions = new PVector[]{
      // top left corner
      new PVector(textboxPositions[0].x, textboxPositions[0].y), 
      // bottom left corner
      new PVector(textboxPositions[0].x, textboxPositions[0].y+textboxSizes[0].y),
      // bottom right corner
      new PVector(textboxPositions[0].x+textboxSizes[0].x, textboxPositions[0].y+textboxSizes[0].y),
      // top right corner
      new PVector(textboxPositions[0].x+textboxSizes[0].x, textboxPositions[0].y)
    };
    sequentialRect = new SequentailFadeIn(SEQUENTIALRECT, seqRectPositions, sequentialVelocity, sequentialLineStrokeColor, color(backgroundColor), strokeWeight);
    
    PVector[] seqRect1Positions = new PVector[]{
      // top left corner
      new PVector(textboxPositions[1].x, textboxPositions[1].y), 
      // bottom left corner
      new PVector(textboxPositions[1].x, textboxPositions[1].y+textboxSizes[1].y),
      // bottom right corner
      new PVector(textboxPositions[1].x+textboxSizes[1].x, textboxPositions[1].y+textboxSizes[1].y),
      // top right corner
      new PVector(textboxPositions[1].x+textboxSizes[1].x, textboxPositions[1].y)
    };
    sequentialRect1 = new SequentailFadeIn(SEQUENTIALRECT, seqRect1Positions, sequentialVelocity, sequentialLineStrokeColor, color(backgroundColor), strokeWeight);
    
    PVector[] seqRect2Positions = new PVector[]{
      // top left corner
      new PVector(textboxPositions[2].x, textboxPositions[2].y), 
      // bottom left corner
      new PVector(textboxPositions[2].x, textboxPositions[2].y+textboxSizes[2].y),
      // bottom right corner
      new PVector(textboxPositions[2].x+textboxSizes[2].x, textboxPositions[2].y+textboxSizes[2].y),
      // top right corner
      new PVector(textboxPositions[2].x+textboxSizes[2].x, textboxPositions[2].y)
    };
    sequentialRect2 = new SequentailFadeIn(SEQUENTIALRECT, seqRect2Positions, sequentialVelocity2, sequentialLineStrokeColor, color(backgroundColor), strokeWeight);
    
    sequentialShapes = new SequentailFadeIn[] {
      sequentialLine, sequentialRect, sequentialRect1, sequentialRect2
    };
  }

  // the global navigate(string) function
  // call beforeDisplay on active page before display
  public void beforeDisplay() {
    for (int i = 0; i < sequentialShapes.length; i++) {
       sequentialShapes[i].reset(); 
    }
    imageTint = 0;
  }

  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {  
    image(bgImage, 0, 0, width, height);
    tint(imageTint);
    if (imageTint<255)
      imageTint+=5;
    boolean sequentialTransitionFinished = true;
    for (int i = 0; i < sequentialShapes.length; i++) {
      if (!sequentialShapes[i].finished) {
        sequentialTransitionFinished = false;
        break;
      }
    }
    
    if (!sequentialTransitionFinished) {
      //background(backgroundColor);
      
      for (int i = 0; i < sequentialShapes.length; i++) {
        sequentialShapes[i].display(); 
      }
      
      return;
    }
    
    // Draw the background image
    

    // draw text boxes
    for (int i = 0; i < textboxes.length; i++) {
      textboxes[i].display();
    }
    
    // Draw the character image
    image(characterImage, characterPosition.x-characterSize.x, characterPosition.y, 
                          characterSize.x, characterSize.y);
  }

  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    // if the user clicks the left side of the screen
    if (Utility.clickedLeftSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {      
      // navigate to the start Page
      navigate(startPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the programming Page
      navigate(programmingPage.label);
    }
  }
}
