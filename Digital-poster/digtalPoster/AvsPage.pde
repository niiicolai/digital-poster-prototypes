class AvsPage {
  // label used to navigate between pages
  public String label = "AVS";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImageUrl = "assets/images/Audio_Visual_Sketching.png";
  
  // Text box color
  color textboxColor = color(0);
  // Text box fill color
  color textboxFillColor = color(255);
  // Text box stroke color
  color textboxStrokeColor = color(0);
  // Text box text indentation
  float textboxTextIndent = 25;
  // Text box text size
  float textboxTextSize = 10;
  // Text box text alignment
  int textboxTextAlignment = LEFT;
  // An array of all text messages
  String[] textMessages = new String[] {
    "Medialogi er en videregående uddannelse på AAU CPH som fokuserer på computerteknologi, kreativitet og praksis. Medialogi kombinerer viden om lyd, design, 3D, matematik, data, programmering og meget mere til at producere lærerige produkter, spil og software.",
    "I Audio Visuel Sketching kommer du til lære hvordan du kommunikerer din gode idé igennem skitser, grafisk design, fysiske prototyper, fotos, 3D-print, 3D-modellering, og animationer. Derudover kommer du til at arbejde med pipelines, storyboarding, pre-visualiseringer og animatic til at producere audiovisuelle kortfilm og animationsproduktioner. Disse projekter kan vare op til et helt semester hvor du arbejder i grupper af 5-6 personer.",
    "Allerede i dit første semester skal du producere en kortfilm ved brug af animationer, live-action optagelser, 3D-modeller og grafisk design. Det handler dog ikke kun om at lave film. Filmproduktionen er bare en, af mange måder, at lære tingene på. Hvis du vælger at gå på Medialogy kommer du helt klart til at lære en helt masse om grafisk design, farver, komposition og meget mere på AVS kurset. "
  };  
  
  // A reference to all text boxes on this page
  Textbox[] textboxes;
  // An array of all textbox positions
  PVector[] textboxPositions;
  // An array of all textbox sizes
  PVector[] textboxSizes;  

  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // Load the image from our assets folder
    bgImage = loadImage(backgroundImageUrl);        
    
    // Create an instance of a textbox array with same the length as 'textMessages'
    textboxes = new Textbox[textMessages.length];
    
    // Declare the position of the text boxes
    textboxPositions = new PVector[] {
      new PVector(200, 200),
      new PVector(200, 400),
      new PVector(200, 600)
    };
    
    // Declare the size of the text boxes
    textboxSizes = new PVector[] {
      new PVector(320, 190),
      new PVector(320, 190),
      new PVector(320, 190)
    };
    
    // Create an instance of a textbox for each message, position and size
    for (int i = 0; i < textMessages.length; i++) {
      textboxes[i] = new Textbox(
          textboxPositions[i], textboxSizes[i], textboxColor, 
          textboxFillColor, textboxStrokeColor, 
          textMessages[i], textboxTextIndent, textboxTextSize,
          textboxTextAlignment
      );
    }
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
    image(bgImage, 0, 0, width, height);

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
      // navigate to the start Page
      navigate(startPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the programming Page
      navigate(programmingPage.label);
    }
  }
}
