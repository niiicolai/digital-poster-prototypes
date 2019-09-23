import gifAnimation.*;  
import processing.sound.*;

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
void setup() {
  // Set size
  size(595, 842);
  
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
}

// Run forever
void draw() {
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

void mousePressed() {
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
