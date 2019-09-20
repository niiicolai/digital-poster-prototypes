class ProjectPage {
  // label used to navigate between pages
  public String label = "PROJECTPAGE";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImageUrl = "assets/images/Grafisk_Design.png";
  
  // An array of all text messages
  String[] textMessages = new String[] {
    "Studiet følger Aalborg-modellen som er en læringsform udviklet på problembaseret læring (PBL). Modellen stræber sig på at simulere et professionelt arbejdsmiljø. Projekterne støttes af forelæsninger, workshops og en supervisor der kan kontaktes efter behov.",
    "Aalborg-modellen bygger på en række grundprincipper herunder, projektorganisering i grupper, samarbejde, vejleder, eksterne parter, eksemplaritet og ansvar for egen læring. Modellen sørger for at de studerende har adgang til lokaler og udstyr. F.eks. har Aalborg universitet en række eksterne partnere med internationale virksomheder hvor der kan indhentes ressourcer til projekterne. F.eks. Samsung, hvor vi hurtigt kan få fat i de nyeste teknologier som de udbyder.",
    "På Medialogi arbejdes der med lange projekter som normalt varer et helt semester. Det betyder at du vil have tid til at sætte dig helt ind i et emne og fordybe dig i det. Da projekterne er tværfaglige er det nødvendigt at inddrage og kombinere viden fra relevante kurser. Projekterne støttes af forelæsninger, workshops og en vejleder. Projekterne er den del som fylder mest på dette studie, og vil til tider bestå udelukkende af projekterne."
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
      // navigate to the programming Page
      navigate(programmingPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the info Page
      navigate(infoPage.label);
    }
  }
}
