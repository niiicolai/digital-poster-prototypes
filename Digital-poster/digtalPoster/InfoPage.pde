class InfoPage {
  // label used to navigate between pages
  public String label = "INFO";
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImageUrl = "assets/images/Info.jpg";
  
  // The footer rect's fill color 
  color footerRectFillColor = color(33, 26, 82);
  // The footer rect's stroke color
  color footerRectStrokeColor = color(33, 26, 82);
  // footer height divider
  float footerRectHeightDivider = 1.5;
  
  // Footer title text
  String footerTitle = "Medialogi";
  // Footer title padding on the y axis
  float footerTitleYPadding = 55;
  // Footer title text size
  float footerTitleTextSize = 50;
  
  // Footer message text
  String footerMessage = "Hvis du vil læse mere gå da ind på aau.dk og find Medialogy eller gå direkte ind på\nhttps://www.aau.dk/uddannelser/bachelor/medialogi.\nDu kan læse medialogy i både København og Aalborg.\nHusk at ansøg senest d. 5. juli kl. 12:00\nDu kan møde os til åbent hus d. 6 februar 13:00 til 17:00!\nFredrik Bajers Vej 7K\nPostboks 159 9100 Aalborg\nTelefon: 9940 9940\nMail: aau@aau.dk\n\n(facebook logo): https://www.facebook.com/AalborgUniversitet/\n(ig logo): https://www.instagram.com/aaustudieliv/\n(Snapchat logo): aauuni";
  // Footer message padding y the y axis
  float footerMessageYPadding = 90;
  // footer message text size;
  float footerMessageTextSize = 10;
  
  // Footer text alignment
  public int footerTextAlignment = CENTER;
  // Footer text color
  color footerTextColor = 255;
  
  
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
