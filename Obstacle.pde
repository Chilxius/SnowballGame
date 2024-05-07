class Obstacle
{
  float xPos, yPos;
  float size;
  
  int type;
  
  boolean done = false;
  boolean broken = false;
  
  public Obstacle( int t )
  {
    type = t;
    size = sizeByType();
    xPos = random(width);
    yPos = height+size*2;
  }
  
  int sizeByType()
  {
    if( type == 0 ) return 40;
    if( type == 1 ) return 70;
    if( type == 2 ) return 100;
    
    return 0;
  }

  void moveAndDrawActive()
  {
    yPos -= gameSpeed;
    
    if( yPos < -size*2 )
      done = true;
      
    //test
    if( dist( xPos, yPos+size/2, s.xPos, s.yPos ) < s.size/2 ) //Check for hit
    {
      //HERE IS WHERE YOU WOULD CHECK IF PLAYER CRASHED
      //SFX[2].play();
      broken = true;
      yPos+=size;
    }
    else
    {
      //Draws the item
      fill(255,0,0);
      circle( xPos, yPos, size ); //TEMP
      //image( obstacleImage[type], xPos, yPos );
    }
  }
  
  void moveAndDrawBroken()
  {
    yPos -= gameSpeed;
    
    if( yPos < -size*2 )
      done = true;
    
    //Draws the item
    fill(0,0,255);
    circle( xPos, yPos, size ); //TEMP
    //image( brokenImage[type], xPos, yPos);
  }
}
