//Snowball

//import processing.sound.*;

Snowball s = new Snowball( 450, 200 );

ArrayList<Trail> trails = new ArrayList<Trail>(); //What the ball leaves behind it
ArrayList<Debris> debris = new ArrayList<Debris>(); //Random items (for decoration)
ArrayList<Pickup> goodies = new ArrayList<Pickup>(); //Good things
ArrayList<Obstacle> stuff = new ArrayList<Obstacle>(); //Bad things

//Game Data
float gameSpeed = 3; //How fast the ball moves down the map
int cash = 0; //Gained from pickups

//Timing
int nextThing = 1000; //Next obstacle
int nextDebris = 100; //Next decoration
int nextGoodThing = 2000; //Next pickup

//Images
PImage [] debrisImage = new PImage[5];
PImage [] pickupImage = new PImage[5];
PImage [] obstacleImage = new PImage[5];
PImage [] brokenImage = new PImage[5];  //Destroyed version of obstacles

//SOUND
//SoundFile SFX[] = new SoundFile[3];

void setup()
{
  size(1500,900);
  imageMode(CENTER);
  setupImages();
  //setupSounds();
}

void draw()
{
  background(255);
  handleDebris();
  handleTrails();
  handlePickups();
  handleBroken();
  handleObstaclesBottom(); // <- draws below the snowball
  handleSnowball();
  handleObstaclesTop(); // <- draws above the snowball
  handleMouseControl();
  handleHUD();
}

void setupImages()
{
  debrisImage[0] = loadImage("debris1.png"); debrisImage[0].resize(30,0);
  debrisImage[1] = loadImage("debris1.png"); debrisImage[1].resize(30,0);
  debrisImage[2] = loadImage("debris3.png"); debrisImage[2].resize(30,0);
  debrisImage[3] = loadImage("debris3.png"); debrisImage[3].resize(30,0);
  debrisImage[4] = loadImage("debris5.png"); debrisImage[4].resize(30,0);

  pickupImage[0] = loadImage("copperPiece.png"); pickupImage[0].resize(20,0);
  pickupImage[1] = loadImage("silverPiece.png"); pickupImage[1].resize(20,0);
  pickupImage[2] = loadImage("goldPiece.png");   pickupImage[2].resize(20,0);
  pickupImage[3] = loadImage("goldPiece.png");   pickupImage[3].resize(30,0);
  pickupImage[4] = loadImage("goldPiece.png");   pickupImage[4].resize(30,0);

  brokenImage[0] = loadImage("treeX.png"); brokenImage[0].resize(40,0);
  brokenImage[1] = loadImage("treeX.png"); brokenImage[1].resize(70,0);
  brokenImage[2] = loadImage("treeX.png"); brokenImage[2].resize(100,0);
  brokenImage[3] = loadImage("treeX.png"); brokenImage[3].resize(30,0);
  brokenImage[4] = loadImage("treeX.png"); brokenImage[4].resize(30,0);

  obstacleImage[0] = loadImage("tree1.png"); obstacleImage[0].resize(40,0);
  obstacleImage[1] = loadImage("tree1.png"); obstacleImage[1].resize(70,0);
  obstacleImage[2] = loadImage("tree1.png"); obstacleImage[2].resize(100,0);
  obstacleImage[3] = loadImage("tree1.png"); obstacleImage[3].resize(30,0);
  obstacleImage[4] = loadImage("tree1.png"); obstacleImage[4].resize(30,0);
}

void setupSounds()
{
  //SFX[0] = new SoundFile(this, "treeCrunch1.wav");
  //SFX[1] = new SoundFile(this, "treeCrunch2.wav");
  //SFX[2] = new SoundFile(this, "treeCrunch3.wav");
}

void handleHUD()
{
  textSize(40);
  fill(0);
  text( "$:" + cash, 20, 40 );
}

void handleDebris()
{
  for( Debris d: debris ) //Move and draw
    d.moveAndDraw();
  for( int i = debris.size()-1; i >= 0; i-- ) //Remove
    if( debris.get(i).done )
      debris.remove(i);
      
  if( millis() > nextDebris ) //Trigger next debris
  {
    nextDebris = millis() + int(random(500,1000));
    debris.add( new Debris( int( random(5) ) ) );
  }
}

void handleSnowball()
{
  s.moveSnowball();
  s.drawSnowball();
  s.growSnowball();
}

void handleTrails()
{
  for( Trail t: trails ) //Move and draw
    t.moveAndDrawTrail();

  if( trails.size() > 100 ) //remove old trails
    trails.remove(0);
}

void handleBroken() //Draw broken items
{
  for( Obstacle o: stuff )
    if(o.broken)
      o.moveAndDrawBroken();
}

void handleObstaclesTop() //Removing and triggering next handled here
{
  for( Obstacle o: stuff )
    if(!o.broken && s.yPos < o.yPos+o.size/2 )
      o.moveAndDrawActive();
      
  for( int i = stuff.size()-1; i >= 0; i-- )
    if( stuff.get(i).done )
      stuff.remove(i);
      
  if( millis() > nextThing )
  {
    nextThing = millis() + int(random(100,300));
    stuff.add( new Obstacle( int( random(3) ) ) );
  }
}

void handleObstaclesBottom()
{
  for( Obstacle o: stuff )
    if(!o.broken && s.yPos >= o.yPos+o.size/2 )
      o.moveAndDrawActive();
}

void handlePickups()
{
  for( Pickup p: goodies ) //Move and draw
    p.moveAndDraw();
    
  for( int i = goodies.size()-1; i >= 0; i-- ) //Remove
    if( goodies.get(i).done )
      goodies.remove(i);
      
  if( millis() > nextGoodThing ) //Trigger next
  {
    nextGoodThing = millis() + int(random(1000,4000));
    goodies.add( new Pickup( int( random(3) ) ) );
  }
}

void handleMouseControl() //Lets the mouse control
{
  if( mousePressed )
  {
    if( mouseX > s.xPos )
    {
      s.rt=true;
      s.lf=false;
    }
    if( mouseX < s.xPos )
    {
      s.lf=true;
      s.rt=false;
    }
  }
  if( !mousePressed && !keyPressed )
    s.rt = s.lf = false;
}

void keyPressed()
{
  if( keyCode == RIGHT || key == 'd' || key == 'D' )
    s.rt=true;
  if( keyCode == LEFT || key == 'a' || key == 'A' )
    s.lf=true;
}

void keyReleased()
{
  if( keyCode == RIGHT || key == 'd' || key == 'D'  )
    s.rt=false;
  if( keyCode == LEFT || key == 'a' || key == 'A'  )
    s.lf=false;
}
