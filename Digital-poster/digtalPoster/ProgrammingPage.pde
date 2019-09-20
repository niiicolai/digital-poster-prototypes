class ProgrammingPage {
  // label used to navigate between pages
  public String label = "PROGRAMMING";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "assets/images/programming.png";
  
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
    "Medialogi består af en række forskellige programmeringskurser, hvor du starter med grundlæggende programmering. Det er derfor ikke en forudsætning at du kan programmere før du begynder. I de første år vil du primært arbejde med Java og processing libraries.",
    "Senere hen vil du lære mere avanceret teorier som udvikling af komplekse systemer, programmering af interaktion og indenfor kunstig intelligens. Her vil du få en større forståelse for sammensætningen af systemer og du vil efterfølgende have kompetencerne til arbejde som programmør.",
    "Programmering på medialogi er lidt anderledes end på f.eks. softwareudvikling hvor de udelukkende arbejder med meget tungt kodningsarbejde, hvorimod på medialogi kommer du til at arbejde meget mere visuelt med programmering og i samarbejde med de andre kurser. "
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
    
    // Draw the character image
    image(characterImage, characterPosition.x-characterSize.x, characterPosition.y, 
                          characterSize.x, characterSize.y);
  }

  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    // if the user clicks the left side of the screen
    if (Utility.clickedLeftSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the avs Page
      navigate(avsPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the graphic design Page
      navigate(projectPage.label);
    }
  }
}
