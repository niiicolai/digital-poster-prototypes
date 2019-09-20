class AvsPage {
  // label used to navigate between pages
  public String label = "AVS";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImageUrl = "assets/images/Audio_Visual_Sketching.png";
  
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

  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // Load the image from our assets folder
    bgImage = loadImage(backgroundImageUrl);        
    
    // Create an instance of a textbox array with same the length as 'textMessages'
    textboxes = new Textbox[textMessages.length];

    // Declare the size of the text boxes
    textboxSizes = new PVector[] {
      new PVector(240, 190),
      new PVector(240, 190),
      new PVector(240, 160)
    };
    
    // Declare the position of the text boxes
    textboxPositions = new PVector[] {
      new PVector(textboxPaddingX, 130),
      new PVector(width-textboxPaddingX-textboxSizes[1].x, 130),
      new PVector(textboxPaddingX, 360)
    };
    
    // Create an instance of a textbox for each message, position and size
    for (int i = 0; i < textMessages.length; i++) {
      textboxes[i] = new Textbox(
          textboxPositions[i], textboxSizes[i], textMessages[i]);
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
