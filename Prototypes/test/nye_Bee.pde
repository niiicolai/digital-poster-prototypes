int Xbee = 950;
int Ybee = 500;
int speed = -5;
float bbr = 245; //Body Color R
float bbg = 229; //Body Color G
float bbb = 47;  //Body Color B

float bgr = 136; //Background color G
float bgg = 160; //Background color R
float bgb = 245; //Background color b
 
  int bbws = 0;     //Bee Back Wings stroke
  int bbwf = 200;   //Bee Back Wing fill
  int bbwsw = 1;    //Bee Back WIng StrokeWeight
  int bbwcx = 15;   //Bee Back Wing Center X
  int bbwcy = -30;  //Bee Back Wing Center Y
  int bbwh = 40;    //Bee Back Wing Height
  int bbwl = 60;    //Bee Back Wing Length
  
  int bblsw = 3;    //Bee Back Leg StrokeWeight
  int bbl1x1 = 0;   //First Bee Back Leg x1
  int bbl1y1 = 0;   //First Bee Back Leg y1
  int bbl1x2 = -10; //First Bee Back Leg x2
  int bbl1y2 =  45; //First Bee Back Leg y2
  
  int bbl2x1 = 7;   //Second Bee Back Leg x1
  int bbl2y1 = 0;   //Second Bee Back Leg y1
  int bbl2x2 = 10;  //second Bee Back Leg x2
  int bbl2y2 =  45; //Second Bee Back Leg y2
  
  int bbl3x1 = 20;  //Third Bee Back Leg x1
  int bbl3y1 = 0;   //Third Bee Back Leg y1
  int bbl3x2 = 30;  //Third Bee Back Leg x2
  int bbl3y2 = 43;  //Third Bee Back Leg y2

  int bbsw = 1;     //Bee Body StrokeWeight
  int bbl = 50;     //Bee Body Lenght
  int bbw = 90;     //Bee Body Width

  int bssw = 5;     //Bee Stripes StrokeWeight
  int bs1x1 = 0;    //Bee stripe 1 x1
  int bs1y1 = 23;   //Bee stripe 1 y1
  int bs1x2 = 0;    //Bee stripe 1 x2
  int bs1y2 = -21;  //Bee stripe 1 y2
  
  int bs2x1 = -15;  //Bee stripe 2 x1
  int bs2y1 = 22;   //Bee stripe 2 y1
  int bs2x2 = -15;  //Bee stripe 2 x2
  int bs2y2 = -22;  //Bee stripe 2 y2
  
  int bs3x1 = 15;   //Bee stripe 3 x1
  int bs3y1 = 22;   //Bee stripe 3 y1
  int bs3x2 = 15;   //Bee stripe 3 x2
  int bs3y2 = -22;  //Bee stripe 3 y2
  
  int bs4x1 = 30;   //Bee stripe 4 x1
  int bs4y1 = 17;   //Bee stripe 4 y1
  int bs4x2 = 30;   //Bee stripe 4 x2
  int bs4y2 = -17;  //Bee stripe 4 y2
  
  int bfwf = 200;   //Bee Front Wing Fill
  int bfwsw = 1;    //Bee Front Wing StrokeWeight
  int bfwcx = 0;    //Bee front Wing center X
  int bfwcy = -30;  //Bee Front Wing Center Y
  int bfwh = 60;    //Bee Front Wing Height
  int bfww = 40;    //Bee Front Wing Width
  
  int bfesw = 5;    //Bee Face Eye StrokeWeight
  int bflex1 = -30; //Bee Face Eye x1
  int bfley1 = -10; //Bee Face Eye y1
  
  int bfmsw = 2;    //Bee Face Mouth StrokeWeight
  int bflmx1 = -40; //Bee Face Mouth x1
  int bflmy1 = 5;   //Bee Face Mouth y1
  int bflmx2 = -32; //Bee Face Mouth x2
  int bflmy2 = 0 ;  //Bee Face Mouth y2
  
void setup() {
  size(1000,1000);
}

void mouseClicked() { //Changes the Bees color
   bbr = random(0,255);
   bbg = random(0,255);
   bbb = random(0,255);
}

void keyPressed() { //Background color changer
  bgr = random(0,255);
  bgg = random(0,255);
  bgb = random(0,255);
}
  
void draw(){
Xbee = Xbee+speed;

   if(Xbee<=5){
     speed = 5;
     //I know, I could just write variablex = -variableX; and it would have been easier...
     bbwcx = bbwcx-bbwcx*2;   //Bee Back Wing change
     bbl1x1 = bbl1x1-bbl1x1*2 ;   //First Bee Back Leg x1 change
     bbl1x2 = bbl1x2-bbl1x2*2 ;   //First Bee Back Leg x2 change
     bbl2x1 = bbl2x1-bbl2x1*2 ;   //Second Bee Back Leg x1 change
     bbl2x2 = bbl2x2-bbl2x2*2 ;   //Second Bee Back Leg x2 change
     bbl3x1 = bbl3x1-bbl3x1*2 ;   //Third Bee Back Leg x1 change
     bbl3x2 = bbl3x2-bbl3x2*2 ;   //Third Bee Back Leg x2 change
     bs1x1 = bs1x1-bs1x1*2;    //Bee stripe 1 x1 change
     bs1x2 = bs1x2-bs1x2*2;    //Bee stripe 1 x2 change
     bs2x1 = bs2x1-bs2x1*2;    //Bee stripe 2 x1 change
     bs2x2 = bs2x2-bs2x2*2;    //Bee stripe 2 x2 change
     bs3x1 = bs3x1-bs3x1*2;    //Bee stripe 3 x1 change
     bs3x2 = bs3x2-bs3x2*2;    //Bee stripe 3 x2 change
     bs4x1 = bs4x1-bs4x1*2;    //Bee stripe 4 x1 change
     bs4x2 = bs4x2-bs4x2*2;    //Bee stripe 4 x2 change
     bflex1 = bflex1-bflex1*2; //Bee Face Eye x1
     bflmx1 = bflmx1-bflmx1*2; //Bee Face Mouth x1
     bflmx2 = bflmx2-bflmx2*2; //Bee Face Mouth x2     
   }
   
   if(Xbee>=995){
     speed = -5;
     bbwcx = bbwcx-bbwcx*2;   //Bee Back Wing change 
     bbl1x1 = bbl1x1-bbl1x1*2 ;   //First Bee Back Leg x1 change
     bbl1x2 = bbl1x2-bbl1x2*2 ;   //First Bee Back Leg x2 change
     bbl2x1 = bbl2x1-bbl2x1*2 ;   //Second Bee Back Leg x1 change
     bbl2x2 = bbl2x2-bbl2x2*2 ;   //Second Bee Back Leg x2 change
     bbl3x1 = bbl3x1-bbl3x1*2 ;   //Third Bee Back Leg x1 change
     bbl3x2 = bbl3x2-bbl3x2*2 ;   //Third Bee Back Leg x2 change
     bs1x1 = bs1x1-bs1x1*2;    //Bee stripe 1 x1 change
     bs1x2 = bs1x2-bs1x2*2;    //Bee stripe 1 x2 change
     bs2x1 = bs2x1-bs2x1*2;    //Bee stripe 2 x1 change
     bs2x2 = bs2x2-bs2x2*2;    //Bee stripe 2 x2 change
     bs3x1 = bs3x1-bs3x1*2;    //Bee stripe 3 x1 change
     bs3x2 = bs3x2-bs3x2*2;    //Bee stripe 3 x2 change
     bs4x1 = bs4x1-bs4x1*2;    //Bee stripe 4 x1 change
     bs4x2 = bs4x2-bs4x2*2;    //Bee stripe 4 x2 change
     bflex1 = bflex1-bflex1*2; //Bee Face Eye x1
     bflmx1 = bflmx1-bflmx1*2; //Bee Face Mouth x1
     bflmx2 = bflmx2-bflmx2*2; //Bee Face Mouth x2  
   }
   

  
  background(bgr,bgg,bgb); //The starting color of the background
  
  //Bee back wings
  stroke(bbws);
  fill(bbwf);
  strokeWeight(bbwsw);
  ellipse(Xbee+bbwcx,Ybee+bbwcy,bbwh,bbwl);
  
  //Bee back legs
  strokeWeight(bblsw);
  line(Xbee+bbl1x1,Ybee+bbl1y1,Xbee+bbl1x2,Ybee+bbl1y2);
  line(Xbee+bbl2x1,Ybee+bbl2y1,Xbee+bbl2x2,Ybee+bbl2y2);
  line(Xbee+bbl3x1,Ybee+bbl3y1,Xbee+bbl3x2,Ybee+bbl3y2);
  
  //Bee body
  fill(bbr,bbg,bbb); //Bee body color
  strokeWeight(bbsw);
  ellipse(Xbee, Ybee, bbw, bbl);
  
  //Bee stripes
  strokeWeight(bssw);
  line(Xbee+bs1x1,Ybee+bs1y1,Xbee+bs1x2,Ybee+bs1y2);
  line(Xbee+bs2x1,Ybee+bs2y1,Xbee+bs2x2,Ybee+bs2y2);
  line(Xbee+bs3x1,Ybee+bs3y1,Xbee+bs3x2,Ybee+bs3y2);
  line(Xbee+bs4x1,Ybee+bs4y1,Xbee+bs4x2,Ybee+bs4y2);
  
  //Bee front wings
  fill(bfwf);
  strokeWeight(bfwsw);
  ellipse(Xbee+bfwcx,Ybee+bfwcy,bfww,bfwh);
  
  //Bee Face
  strokeWeight(bfesw);
  line(Xbee+bflex1,Ybee+bfley1,Xbee+bflex1,Ybee+bfley1);
  strokeWeight(bfmsw);
  line(Xbee+bflmx1,Ybee+bflmy1,Xbee+bflmx2,Ybee+bflmy2);
}
