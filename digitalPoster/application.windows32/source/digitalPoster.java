import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import gifAnimation.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class digitalPoster extends PApplet {

  


PApplet pApplet = this;

// click sound file
SoundFile clickSoundFile;
// click sound file path
String clickSoundFilePath = "ui_menu_button_beep_16.wav";

// The code display a page based on currentScene
String currentPage;
// The label of the default page
String defaultPage;

// A reference to the start page
StartPage startPage = new StartPage();
// A reference to the AVS page
AvsPage avsPage = new AvsPage();
// A reference to the programming page
ProgrammingPage programmingPage = new ProgrammingPage();
// A reference to the graphic design page
ProjectPage projectPage = new ProjectPage();
// A reference to the info page
InfoPage infoPage = new InfoPage();

// If an user haven't switch page
// before the timer hits maxIdleTime,
// automatically switch back to the start page
int maxIdleTime = ((60000)*5);
// keeps track of what the time is
// everyTime we wants to reset
int lastIdleReset;

// global textbox font
PFont textboxFont;
// path to text box font
String textboxFontUrl = "AvenirLTStd-Medium.otf";
// the default size of all text
float defaultTextSize = 14;

// Run only once
public void setup() {
  // Set size
  
  
  // Load global text box font
  textboxFont = createFont(textboxFontUrl, defaultTextSize);
  
  // Load the click sound file
  clickSoundFile = new SoundFile(this, clickSoundFilePath);
  
  // Set start page as default page
  defaultPage = startPage.label;
  // set current page to the default page
  currentPage = defaultPage;
  
  // Initialize pages
  startPage.init();
  avsPage.init();
  programmingPage.init();
  projectPage.init();
  infoPage.init();
  
  // Run beforeDisplay on the first page
  startPage.beforeDisplay();
}

// Run forever
public void draw() {
  // Run a page's display() function
  // if currentScene is equal to their label  
  if (currentPage == startPage.label) {
    startPage.display();
  } else if (currentPage == avsPage.label) {
    avsPage.display();
  } else if (currentPage == programmingPage.label) {
    programmingPage.display();
  } else if (currentPage == projectPage.label) {
    projectPage.display();
  } else if (currentPage == infoPage.label) {
    infoPage.display();
  }
  
  // If is x time since anybody used the poster
  if (millis() > lastIdleReset+maxIdleTime) {
    // keep track of last reset
    lastIdleReset = millis();
    // ensure to only navigate to default page
    // if we isn't on the default page already
    if (currentPage != defaultPage) {
      // call navigate to show the default page
      navigate(defaultPage); 
    }
  }    
}

public void mousePressed() {
  // call local mouse click function
  if (currentPage == startPage.label) {
    startPage.OnMouseClicked();
  } else if (currentPage == avsPage.label) {
    avsPage.OnMouseClicked();
  } else if (currentPage == programmingPage.label) {
    programmingPage.OnMouseClicked();
  } else if (currentPage == projectPage.label) {
    projectPage.OnMouseClicked();
  } else if (currentPage == infoPage.label) {
    infoPage.OnMouseClicked();
  }
}

// A function used to switch to a new page.
// Takes a string which needs to match a page label
public void navigate(String nextPage) {  
  // play click sound
  clickSoundFile.play();
  
  if (currentPage == startPage.label) {
    startPage.onHide();
  } else if (currentPage == avsPage.label) {
    avsPage.onHide();
  } else if (currentPage == programmingPage.label) {
    programmingPage.onHide();
  } else if (currentPage == projectPage.label) {
    projectPage.onHide();
  } else if (currentPage == infoPage.label) {
    infoPage.onHide();
  }
  
  // Set current scene to the new page
  currentPage = nextPage;
  
  // call beforeDisplay()
  if (currentPage == startPage.label) {
    startPage.beforeDisplay();
  } else if (currentPage == avsPage.label) {
    avsPage.beforeDisplay();
  } else if (currentPage == programmingPage.label) {
    programmingPage.beforeDisplay();
  } else if (currentPage == projectPage.label) {
    projectPage.beforeDisplay();
  } else if (currentPage == infoPage.label) {
    infoPage.beforeDisplay();
  }
    
  // Reset the idle timer to ensure the user
  // don't get sent back to the frontpage
  // before they are done
  lastIdleReset = millis();
}
class AvsPage {
  // label used to navigate between pages
  public String label = "AVS";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "avsBgg.jpg";
  
  // The page's background color
  int backgroundColor = color(33, 26, 82);
  
  // The start page's character
  Gif characterGif;
  // The path to the character image
  String characterGifPath = "characterAVS.gif";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(260, 300);
  
  // An array of all text messages
  String[] textMessages = new String[] {
    "Medialogi er en videregående uddannelse på AAU CPH som fokuserer på computerteknologi, " +
    "kreativitet og praksis. Medialogi kombinerer viden om lyd, design, 3D, matematik, data, " +
    "programmering og meget mere til at producere lærerige produkter, spil og software.",
    
    "I Audio Visuel Sketching kommer du til lære hvordan du kommunikerer din gode idé igennem " + 
    "skitser, grafisk design, fysiske prototyper, fotos, 3D-print, 3D-modellering, og animationer. ",
    
    "Derudover kommer du også til at arbejde med pipelines, storyboarding, pre-visualiseringer og " +
    "animatic til at producere audiovisuelle kortfilm og animationsproduktioner. "
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
  int textboxAlphaIncrement = 30;
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
  int imageTintRgb = color(255);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  // Sequential line stroke color
  int sequentialLineStrokeColor = color(89, 79, 191);
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
    characterGif = new Gif(pApplet, characterGifPath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2-characterSize.x/4.1f, height/1.95f);
    
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
    
    // set to false so we can display this page another time
    isDisplaying = false;
    
    // Set the gif to start playing
    characterGif.play();
  }

  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() { 
                                     
    // stop executing display() if it's already is displayed
    //if (!isDisplaying) {

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
    image(characterGif, characterPosition.x, characterPosition.y, 
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
    
    // increment 'textboxAlpha' to fade in textboxes
    // as long its value is less than textbox alpha max
    if (textboxAlpha < textboxAlphaMax) {
      
      // set rect fill color with the respective textbox alpha
      for (int i = 0; i < textboxes.length; i++) {
        textboxes[i].rectFillColor = color(rectFillColorRgb.x, rectFillColorRgb.y, rectFillColorRgb.z, textboxAlpha);
      }
      
      // increment textbox alpha
      textboxAlpha += textboxAlphaIncrement;             
    } else {
      // if the textboxes are faded in, which is the last draw task
      // we set isDisplay to true
      isDisplaying = true;
      
    }

    // draw text boxes
    for (int i = 0; i < textboxes.length; i++) {
      textboxes[i].display();
    }
    
    //}
  }
  
  public void onHide() {
    // stop the gif from playing
    characterGif.stop();
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
class InfoPage {
  // label used to navigate between pages
  public String label = "INFO";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "info.jpg";
  
  // A reference to the logo
  PImage aauLogoImage;
  // The logo image's path
  String aauLogoImagePath = "AAU_LOGO_WHITE.png";
  // The position of the logo
  PVector aauLogoPosition = new PVector(10, 10);
  // The size of the logo
  PVector auuLogoSize = new PVector(180, 110);
  
  // The page's background color
  int backgroundColor = color(33, 26, 82);
  
  // The start page's character
  Gif characterGif;
  // The path to the character image
  String characterGifPath = "characterInfo.gif";
  // The position of the character image
  PVector characterPosition = new PVector(0, 30);
  // The size of the character image
  PVector characterSize = new PVector(350, 320);
  
  // The footer rect's stroke color
  int footerRectStrokeColor = color(33, 26, 82);
  // footer height divider
  float footerRectHeightDivider = 1.5f;
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
  int footerTextColor = 255;  
  
  // The number of alpha applied to all images
  int imageTintAlpha = 0;  
  // How fast the alpha should increment
  int imageTintAlphaIncrement = 20;
  // The maximum image alpha
  int imageTintAlphaMax = 255;
  // Image tint rgb color
  int imageTintRgb = color(255);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  // Sequential line stroke color
  int sequentialLineStrokeColor = color(89, 79, 191);
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
    // Load the image from our data folder
    bgImage = loadImage(backgroundImagePath);
    
    // Load the image from the assets folder
    characterGif = new Gif(pApplet, characterGifPath);
    
    // Load the logo from the data folder
    aauLogoImage = loadImage(aauLogoImagePath);
    
    // Set the position of the logo
    aauLogoPosition = new PVector(aauLogoPosition.x, 
                                  height-aauLogoPosition.y-auuLogoSize.y);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2-characterSize.x/2, height/3.2f);
    
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
    
    // Set the gif to start playing
    characterGif.play();
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    // stop executing display() if it's already is displayed
    //if (isDisplaying) {
    //  return;
    //}
    
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
    image(characterGif, characterPosition.x, characterPosition.y, 
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
    int tempFooterRectFillColor = color(footerRectFillColorRgb.x, 
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
    }
    // if the footer rect is done fading
    // the code will continue to from this point
    
    // Draw the logo image
    image(aauLogoImage, aauLogoPosition.x, aauLogoPosition.y, 
                        auuLogoSize.x, auuLogoSize.y);
    
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
  
  public void onHide() {
    // stop the gif from playing
    characterGif.stop();
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
class ProgrammingPage {
  // label used to navigate between pages
  public String label = "PROGRAMMING";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "programming.png";
  
  // The page's background color
  int backgroundColor = color(33, 26, 82);
  
  // The start page's character
  Gif characterGif;
  // The path to the character image
  String characterGifPath = "characterProgramming.gif";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(300, 280);    
  
  // An array of all text messages
  String[] textMessages = new String[] {
    "Medialogi består af en række forskellige kurser indenfor programmering, " +
    "hvor du starter med grundlæggende programmering. Det er derfor ikke en forudsætning " +
    "at du kan programmere før du begynder. I de første år vil du primært arbejde med Java og Processing.",
    
    "Senere hen vil du lære mere avanceret teorier som udvikling af komplekse systemer, programmering af " +
    "interaktion og indenfor kunstig intelligens. Du få en forståelse for sammensætningen af systemer og du " +
    "vil opnå kompetencerne til arbejde som programmør.",
    
    "Programmering på medialogi er lidt anderledes end på f.eks. softwareudvikling hvor de udelukkende arbejder " +
    "med meget tungt kodningsarbejde, hvorimod på medialogi kommer du til at arbejde meget mere visuelt med programmering " +
    "og i samarbejde med de andre kurser. "
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
  int textboxAlphaIncrement = 30;
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
  int imageTintRgb = color(255);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  // Sequential line stroke color
  int sequentialLineStrokeColor = color(89, 79, 191);
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
    characterGif = new Gif(pApplet, characterGifPath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2.5f, height/1.89f);
    
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
    
    // set to false so we can display this page another time
    isDisplaying = false;
    
    // Set the gif to start playing
    characterGif.play();
  }

  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    // stop executing display() if it's already is displayed
    //if (isDisplaying) {
    //  return;
    //}
    
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
    image(characterGif, characterPosition.x, characterPosition.y, 
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
    } else {
      // if the textboxes are faded in, which is the last draw task
      // we set isDisplay to true
      //isDisplaying = true;
    }

    // draw text boxes
    for (int i = 0; i < textboxes.length; i++) {
      textboxes[i].display();
    }
  }
  
  public void onHide() {
    // stop the gif from playing
    characterGif.stop();
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
class ProjectPage {
  // label used to navigate between pages
  public String label = "PROJECTPAGE";
  
  // used to check if a page is done drawing
  boolean isDisplaying;
  
  // The page's background image
  PImage bgImage;
  // The path to the background image
  String backgroundImagePath = "projects.png";
  
  // The page's background color
  int backgroundColor = color(33, 26, 82);
  
  // The start page's character
  Gif characterGif;
  // The path to the character image
  String characterGifPath = "characterProject.gif";
  // The position of the character image
  PVector characterPosition;
  // The size of the character image
  PVector characterSize = new PVector(300, 280);
  
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
  int imageTintRgb = color(255);
  
  // An array of sequentialShapes being drawned before display
  SequentailFadeIn[] sequentialShapes;
  // Sequential line stroke color
  int sequentialLineStrokeColor = color(89, 79, 191);
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
    characterGif = new Gif(pApplet, characterGifPath);
    
    // Set character position based on height and width
    characterPosition = new PVector(width/2-characterSize.x/4.8f, height/1.88f);
    
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
    
    // set to false so we can display this page another time
    isDisplaying = false;
    
    // Set the gif to start playing
    characterGif.play();
  }
  
  // the global draw() function
  // call this function if the global 'currentScene'
  // variable match its label
  // Use this function to display page elements
  public void display() {
    // stop executing display() if it's already is displayed
    //if (isDisplaying) {
    //  return;
    //}
    
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
    image(characterGif, characterPosition.x, characterPosition.y, 
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
    } else {
      // if the textboxes are faded in, which is the last draw task
      // we set isDisplay to true
      //isDisplaying = true;
    }

    // draw text boxes
    for (int i = 0; i < textboxes.length; i++) {
      textboxes[i].display();
    }
  }
  
  public void onHide() {
    // stop the gif from playing
    characterGif.stop();
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
final int SEQUENTIALLINE = 0;
final int SEQUENTIALRECT = 1;
class SequentailFadeIn {
  
  // returns true if the animation is done
  public boolean finished;
  
  // the animation's velcocity
  private PVector velocity;

  // Determines the shape
  private int shape;
  
  // the animation's current positions
  private PVector[] animationPosition;
  
  // used within sequential rects to 
  // keep track of which line to draw
  private int animationIndex;
  
  // used within sequential rects to
  // keep track of which lines is done drawing
  private boolean[] drawedElement;
  
  // the animation's positions
  // LINE
  // 0 => start position
  // 1 => end position
  // RECT
  // 0 => top left corner
  // 1 => top right corner
  // 2 => bottom left corner
  // 3 => bottom right corner
  private PVector[] positions;
  
  // the shape's stroke color
  private int strokeColor;
  
  // the shape's fill color
  // can be 'null' if the shape is a line
  private int fillColor;
  
  // the size of the stroke
  private float strokeSize;

  SequentailFadeIn(int tempShape, PVector[] tempPositions, PVector tempVelocity, int tempStrokeColor, int tempFillColor, float tempStrokeSize) {
    shape = tempShape;
    positions = tempPositions;    
    velocity = tempVelocity;
    strokeColor = tempStrokeColor;
    fillColor = tempFillColor;
    strokeSize = tempStrokeSize;
  }
  
  public void reset() {
    drawedElement = new boolean[positions.length];
    animationPosition = new PVector[positions.length];
    for (int i = 0; i < positions.length; i++) {
       animationPosition[i] = new PVector(positions[i].x, positions[i].y); 
    }
    
    animationIndex = 0;
    finished = false;
  }
  
  // run display until a sequential animation 'finished' returns true
  public void display() {
    // set stroke color
    stroke(strokeColor);
    
    // set stroke size
    strokeWeight(strokeSize);
    
    // if the shape is not a line
    if (shape != SEQUENTIALLINE) {
      // Set a fill color
      fill(fillColor); 
    }
    
    // if we selected a sequential line
    if (shape == SEQUENTIALLINE) {
      // run the draw line function
      drawLine();
    // if we selected a sequential rect
    } else if (shape == SEQUENTIALRECT) {
      // run the draw rect function
      drawRect();
    }
  }
  
  private void drawLine() {
    // if the line is finished drawing
    // return the function at the line below
    if (finished) {
      return; 
    }
    
    // Check if we are supposed to move on the y axis
    boolean moveOnYAxis = animationPosition[0].x == positions[1].x;
    
    // Check if we should either increase or decrease the position value
    boolean increase = (moveOnYAxis && animationPosition[0].y < positions[1].y) ||
                         (!moveOnYAxis && animationPosition[0].x < positions[1].x);
    
    // If we should increase we set speed to plus 1
    // if not, we set it to minus 1
    float speed = (increase ? 1 : -1);
    
    // Create a temporary vector used for velocity
    // which move either on x or y axis
    PVector tempVelocity = (moveOnYAxis ? new PVector(0, speed*velocity.y) : new PVector(speed*velocity.x, 0));

    if (moveOnYAxis) {
      // We check if the velocity is to high on the y axis
      // in order to end up at the correct point
      boolean velocityTooHighOnY = (increase ? animationPosition[0].y+tempVelocity.y > positions[1].y :
                                              animationPosition[0].y+tempVelocity.y < positions[1].y);
      
      // if it is too high, we apply a lower fixed velocity
      if (velocityTooHighOnY) {
        tempVelocity.y = speed*5;
      }
      
      // we do another check to see if its still too high
      velocityTooHighOnY = (increase ? animationPosition[0].y+tempVelocity.y > positions[1].y :
                                            animationPosition[0].y+tempVelocity.y < positions[1].y);
      
      // if it is we fall back to a very slow velocity
      if (velocityTooHighOnY) {
        tempVelocity.y = speed;
      }
    } else {
      
      // We check if the velocity is to high on the x axis
      // in order to end up at the correct point
      boolean velocityTooHighOnX = (increase ? animationPosition[0].x+tempVelocity.x > positions[1].x :
                                            animationPosition[0].x+tempVelocity.x < positions[1].x);
      
      // if it is too high, we apply a lower fixed velocity
      if (velocityTooHighOnX) {
        tempVelocity.x = speed*5;
      }
      
      // we do another check to see if its still too high
      velocityTooHighOnX = (increase ? animationPosition[0].x+tempVelocity.x > positions[1].x :
                                              animationPosition[0].x+tempVelocity.x < positions[1].x);
      
      // if it is we fall back to a very slow velocity
      if (velocityTooHighOnX) {
        tempVelocity.x = speed;
      }
    }
    
    // applies temporary velocity to the line's position
    animationPosition[0].add(tempVelocity);        
    
    // draw the line
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    // check if the line is done drawing by matching the equality of 
    // the current animation position and the end position
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y) {
      finished = true;
    }
  }
  
  private void drawRect() {
    // if the line is finished drawing
    // return the function at the line below
    if (finished) {
      return; 
    }        
    
    // check if all lines is done drawing
    boolean drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    // if they isn't all done
    if (!drawedAll) {
      
      // we find the next point
      int nextPointIndex = (animationIndex+1 >= positions.length ? 0 : animationIndex+1);
      
      // Check if we are supposed to move on the y axis
      boolean moveOnYAxis = animationPosition[animationIndex].x == positions[nextPointIndex].x;
      
      // Check if we should either increase or decrease the position value
      boolean increase = (moveOnYAxis && animationPosition[animationIndex].y < positions[nextPointIndex].y) ||
                         (!moveOnYAxis && animationPosition[animationIndex].x < positions[nextPointIndex].x);
      
      // If we should increase we set speed to plus 1
      // if not, we set it to minus 1
      float speed = (increase ? 1 : -1);
      
      // Create a temporary vector used for velocity
      // which move either on x or y axis
      PVector tempVelocity = (moveOnYAxis ? new PVector(0, speed*velocity.y) : new PVector(speed*velocity.x, 0));
      
      if (moveOnYAxis) {
        // We check if the velocity is to high on the y axis
        // in order to end up at the correct point
        boolean velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                            animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed*10;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                            animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed*5;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnY = (increase ? animationPosition[animationIndex].y+tempVelocity.y > positions[nextPointIndex].y :
                                              animationPosition[animationIndex].y+tempVelocity.y < positions[nextPointIndex].y);
        
        // // if it is we fall back to a very slow velocity
        if (velocityTooHighOnY) {
          tempVelocity.y = speed;
        }
      } else {
        
        // We check if the velocity is to high on the x axis
        // in order to end up at the correct point
        boolean velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed*10;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // if it is too high, we apply a lower fixed velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed*5;
        }
        
        // we do another check to see if its still too high
        velocityTooHighOnX = (increase ? animationPosition[animationIndex].x+tempVelocity.x > positions[nextPointIndex].x :
                                            animationPosition[animationIndex].x+tempVelocity.x < positions[nextPointIndex].x);
        
        // // if it is we fall back to a very slow velocity
        if (velocityTooHighOnX) {
          tempVelocity.x = speed;
        }                
      }  
      
      // applies temporary velocity to the line's position
      animationPosition[animationIndex].add(tempVelocity);
    }
    
    // draw the first line
    line(positions[0].x, positions[0].y, animationPosition[0].x, animationPosition[0].y);
    
    // check if the first line is done drawing
    if (animationPosition[0].x == positions[1].x &&
        animationPosition[0].y == positions[1].y &&
        !drawedElement[0]) {
      drawedElement[0] = true;
      animationIndex++;
    }
    
    // if the first line is done drawing
    if (drawedElement[0]) {
      // draw the second line
      line(positions[1].x, positions[1].y, animationPosition[1].x, animationPosition[1].y);
    
      // if the second line is done drawing
      if (animationPosition[1].x == positions[2].x &&
        animationPosition[1].y == positions[2].y &&
        !drawedElement[1]) {
        drawedElement[1] = true;
        animationIndex++;
      }
    }
    
    // if the second line is done drawing
    if (drawedElement[1]) {
      // draw the third line
      line(positions[2].x, positions[2].y, animationPosition[2].x, animationPosition[2].y);
    
      // if the third line is done drawing
      if (animationPosition[2].x == positions[3].x &&
        animationPosition[2].y == positions[3].y &&
        !drawedElement[2]) {
        drawedElement[2] = true;
        animationIndex++;
      }
    }
    
    // if the third line is done drawing
    if (drawedElement[2]) {
      // draw the fourth line
      line(positions[3].x, positions[3].y, animationPosition[3].x, animationPosition[3].y);
    
      // if the fourth line is done drawing
      if (animationPosition[3].x == positions[0].x &&
        animationPosition[3].y == positions[0].y &&
        !drawedElement[3]) {
        drawedElement[3] = true;
        animationIndex++;
      }
    }
    
    // if all elements is done drawing
    drawedAll = drawedElement[0] && drawedElement[1] && drawedElement[2] && drawedElement[3];
    if (drawedAll) {
      // finish the sequentialfadein
      finished = true;
    }
  }
}
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
  int backgroundColor = color(33, 26, 82);
  
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
  int imageTintRgb = color(255);
  
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
class Textbox {
  // The top left point of the rect
  private PVector position;
  // The rect's length and height relative to the position
  private PVector size;  
  
  // The text's fill color
  public int textColor = color(255);
  // The rect's fill color 
  public int rectFillColor = color(33, 26, 82);
  // The rect's stroke color
  public int rectStrokeColor = color(33, 26, 82);
  
  // The message this textbox should display
  private String message;
  // The number of pixels between the top left point and the text
  public float textIndent = 15;
  // Declare rounded corners on the rect
  public float rectRoundedCorner = 3;
  // The size of the text
  //private float textSize;
  // Declare the text alignment
  public int textAlignment = LEFT;
  // The font of the text box
  // Set to the global textbox by default
  public PFont textFont = textboxFont;
  
  Textbox(PVector tempPosition, PVector tempSize, String tempMessage) {
    position = tempPosition;
    size = tempSize;
    message = tempMessage;
  }
 
  // Draw the textbox
  public void display() {
    // Set rect fill color
    fill(rectFillColor);
    
    // Set rect stroke color
    stroke(rectStrokeColor);
    
    // Draw a rect
    rect(position.x, position.y, size.x, size.y+textIndent, rectRoundedCorner);
    
    // Set text color
    fill(textColor);
    
    // Set text alignment
    textAlign(textAlignment);
    
    // Set the text font
    textFont(textFont);
    
    // Draw text
    text(message, position.x+textIndent, position.y+textIndent, size.x-textIndent*2, size.y-textIndent);
  }
}
// The utility class
// holds helper functions for all classes to use
static class Utility {
  
  // Return true if a vector points is inside a rect based on
  // topLeft corner x position, topRight corner x position
  // topLeft corner y position, bottomLeft corner y position
  public static boolean isPointInsideRect(PVector point, float topLeftX, float topRightX, 
                                   float topLeftY, float bottomLeftY) {
    // Check if the point is inside the rect on x axis
    boolean isInsideOnXAxis = (point.x >= topLeftX && point.x <= topRightX);
    // Check if the point is inside the rect on y axis
    boolean isInsideOnYAxis = (point.y >= topLeftY && point.y <= bottomLeftY);
    // Return true if both conditions are true
    return (isInsideOnXAxis && isInsideOnYAxis);
  }
  
  // returns true if mousePosition is on the left side of the screen
  public static boolean clickedLeftSideOfTheScreen(PVector mousePosition, float _width, float _height) {
    return isPointInsideRect(
      mousePosition, 
      0, _width/2, 
      0, _height
    );
  }
  
  // returns true if mousePosition is on the right side of the screen
  public static boolean clickedRightSideOfTheScreen(PVector mousePosition, float _width, float _height) {
    return isPointInsideRect(
      mousePosition, 
      _width/2, _width, 
      0, _height
    );
  }
}
  public void settings() {  size(595, 842); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "digitalPoster" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
