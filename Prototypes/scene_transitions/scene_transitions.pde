// a reference to all our wanted scenes
Scene[] scenes;

String[] sceneNames = new String[] {
  "FRONTPAGE",
  "WHAT",
  "WHY",
  "HOW"
};

int sceneIndex;

// default scene name
String defaultScene = "FRONTPAGE";

// Initialize the project. Runs only one time.
void setup() {
  // Defines the height and width of the proccesing display window
  size(1024, 768);
  
  // Declare scenes
  Scene frontPage = new Scene(sceneNames[0], #0099cc, new FrontPage());
  Scene what = new Scene(sceneNames[1], #ffffff, new What());
  Scene why = new Scene(sceneNames[2], #0cefff, new Why());
  Scene how = new Scene(sceneNames[3], #0299cc, new How());
  
  // Declares an array of scenes used for navigation 
  scenes = new Scene[]{frontPage, what, why, how};
  
  // Show start scene
  showScene(defaultScene);
}

void draw() {
  // loops through scenes and render only scenes with 'visible=true'
  for (int i = 0; i < scenes.length; i++) {
    scenes[i].render();
  }
}

void keyPressed() {
  showScene(sceneNames[sceneIndex]);
  sceneIndex++;
  if (sceneIndex == sceneNames.length) {
    sceneIndex = 0; 
  }
}

// sets the visibility of all scene where the label doesn't match
// and activating the one matching
void showScene(String label) {
  for (int i = 0; i < scenes.length; i++) {
    scenes[i].visible = (scenes[i].label == label);
  }
}
