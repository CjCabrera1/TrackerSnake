  import  processing.video.*;
  Capture webcam;
  color trackingColor;
  float threshold =150;
  int loc;
  String score;
   float triggerX = random(0,640);
  float triggerY = random(0,360);
  // balls
float ballx;
float bally; 
float xSpeed =3;
float ySpeed =3;
int ballWidth = 40;
int ballHeight = 40;

// Point system
int totalP = 0;
int points = 20;
int negPoints = 5;
  void setup(){
   size(640,360);
   webcam = new Capture(this,640,360,Capture.list()[29]);
   webcam.start();
 ballx = random(21, width-21);
bally = random(21, height/2);
  noStroke();
  fill(255, 204);
   printArray(Capture.list());
  }
  void captureEvent(Capture webcam){
   webcam.read(); 
   loadPixels();
  
  }
  int counter;
  void draw(){
    image(webcam,0,0);
  float matchX = 0;
  float matchY = 0;
  threshold = 80;   
  
  
    for(int x =0 ;x < webcam.width;x++){
      for (int y = 0; y < webcam.height;y++){     
        
        loc = x + y * webcam.width;
        color currentColor = webcam.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        
        float r2 = red(trackingColor);
        float g2 = green(trackingColor);
        float b2 = blue(trackingColor);
        
        float colorDiff = dist(r1,g1,b1,r2,g2,b2);
        
        if(colorDiff < threshold){
          stroke(255);
          strokeWeight(1);
          matchX = x;
          matchY = y;
          counter++;
          }
          
        }
      }
      
   if (counter > 0){
     fill(trackingColor);
     ellipse(matchX,matchY,40,40);
    }
    fill(1,244,12);

    
    // if balls collide with the matchX and Match Y then collide the 2
    ballx = ballx+xSpeed;
    bally = bally+ySpeed;
    ellipse(ballx, bally, ballWidth, ballHeight);
    fill(126);
    ellipse(triggerX,triggerY,40,40);
    if(dist(matchX,matchY,triggerX,triggerY) < 20){
    totalP += points;
     triggerX = random(0,640);
    triggerY = random(0,360);
    }
    if(dist(matchX,matchY,ballx,bally) < 20){
    totalP -= negPoints;
     
    }
    text("Score:" + totalP + " Points", 20,20);
    if (ballx > width-ballWidth/2 || ballx < ballWidth/2) {
    xSpeed = -xSpeed;
    }

    if (bally < ballHeight/2 || bally > height-ballHeight/2) {
    ySpeed = - ySpeed;
    }

  
  }// end draw
  
  void mousePressed(){
    loc = mouseX + mouseY * webcam.width;
    trackingColor = webcam.pixels[loc];
  }
  
