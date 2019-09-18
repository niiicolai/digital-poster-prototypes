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
GraphicDesignPage graphicDesignPage = new GraphicDesignPage();
// A reference to the info page
InfoPage infoPage = new InfoPage();

// If an user haven't switch page
// before the timer hits maxIdleTime,
// automatically switch back to the start page
int maxIdleTime = ((60000)*5);
// keeps track of what the time is
// everyTime we wants to reset
int lastIdleReset;

// Run only once
void setup() {
  // Set size
  size(500, 500);
  
  // Set start page as default page
  defaultPage = startPage.label;
  // set current page to the default page
  currentPage = defaultPage;
  
  // Initialize pages
  startPage.init();
  avsPage.init();
  programmingPage.init();
  graphicDesignPage.init();
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
  } else if (currentPage == graphicDesignPage.label) {
    graphicDesignPage.display();
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

// called after a mouse button has been pressed and then released
void mouseClicked() {
  // call local mouse click function
  if (currentPage == startPage.label) {
    startPage.OnMouseClicked();
  } else if (currentPage == avsPage.label) {
    avsPage.OnMouseClicked();
  } else if (currentPage == programmingPage.label) {
    programmingPage.OnMouseClicked();
  } else if (currentPage == graphicDesignPage.label) {
    graphicDesignPage.OnMouseClicked();
  } else if (currentPage == infoPage.label) {
    infoPage.OnMouseClicked();
  }
}

// A function used to switch to a new page.
// Takes a string which needs to match a page label
public void navigate(String nextPage) {
  // Hide the old page
  if (currentPage == startPage.label) {
    startPage.hide();
  } else if (currentPage == avsPage.label) {
    avsPage.hide();
  } else if (currentPage == programmingPage.label) {
    programmingPage.hide();
  } else if (currentPage == graphicDesignPage.label) {
    graphicDesignPage.hide();
  } else if (currentPage == infoPage.label) {
    infoPage.hide();
  }
  
  // Set current scene to the new page
  currentPage = nextPage;
  
  // Reset the idle timer to ensure the user
  // don't get sent back to the frontpage
  // before they are done
  lastIdleReset = millis();
}
