class InfoPage {
  // label used to navigate between pages
  public String label = "INFO";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImageUrl = "assets/images/Info.jpg";
  
  // The footer rect's fill color 
  public color footerRectFillColor = color(33, 26, 82);
  // The footer rect's stroke color
  public color footerRectStrokeColor = color(33, 26, 82);
  // footer height divider
  public float footerRectHeightDivider = 1.5;
  
  // called inside setup()
  // Use this function to setup variables
  // after setting processing display windows size() etc.
  public void init() {
    // Load the image from our assets folder
    bgImage = loadImage(backgroundImageUrl);
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
    
    // Set footer rect stroke color
    stroke(footerRectStrokeColor);
    
    // Set footer rect fill color
    fill(footerRectFillColor);
    
    // Draw footer rect
    rect(0, height/footerRectHeightDivider, width, height);
    
    textAlign(CENTER);
    
    fill(255);
    textSize(50);
    text("Medialogi", width/2, height/footerRectHeightDivider+80);
    
    textSize(10);    
    text("Hvis du vil læse mere gå da ind på aau.dk og find Medialogy eller gå direkte ind på\nhttps://www.aau.dk/uddannelser/bachelor/medialogi.\nDu kan læse medialogy i både København og Aalborg.\nHusk at ansøg senest d. 5. juli kl. 12:00\nDu kan møde os til åbent hus d. 6 februar 13:00 til 17:00!\nFredrik Bajers Vej 7K\nPostboks 159 9100 Aalborg\nTelefon: 9940 9940\nMail: aau@aau.dk\n\nDu kan også finde os på\n(facebook logo): https://www.facebook.com/AalborgUniversitet/\n(ig logo): https://www.instagram.com/aaustudieliv/\n(Snapchat logo): aauuni", width/2, height/footerRectHeightDivider+140);
  }
  
  // called inside mouseClicked()
  // Use to track mouse events local to this class
  public void OnMouseClicked() {
    // if the user clicks the left side of the screen
    if (Utility.clickedLeftSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the programming Page
      navigate(projectPage.label);
      // or if the user clicks the right side of the screen
    } else if (Utility.clickedRightSideOfTheScreen(new PVector(mouseX, mouseY), width, height)) {
      // navigate to the info Page
      navigate(startPage.label);
    }
  }
}
