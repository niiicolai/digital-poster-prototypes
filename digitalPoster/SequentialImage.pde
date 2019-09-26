class SequentialImage {
 private String prefix;
 private String imageName;
 private PImage[] images;
 private int numberOfImages;
 
 private int currentIndex;
 
 private int frameCounter;
 private int updateEveryFrame = 5;
  
  
 SequentialImage(String tempImageName, String tempPrefix, int tempNumberOfImages) {
   imageName = tempImageName;
   prefix = tempPrefix;
   numberOfImages = tempNumberOfImages;
   
   images = new PImage[numberOfImages];
   for (int i = 0; i < numberOfImages; i++) {
     images[i] = loadImage(imageName+i+"."+prefix);
   }
 }
  
 
 public void reset() {
   currentIndex = 0;
 }
  
 public void display(float x, float y, float _length, float _height) {
  image(images[currentIndex], x, y, _length, _height);
 
   frameCounter++;
   if (frameCounter >= updateEveryFrame) {
     frameCounter = 0;
     
     g.removeCache(images[currentIndex]);
     
     currentIndex++;
     
     if (currentIndex == numberOfImages) {
       currentIndex = 0;
     }
     
     
   }
 }
}
