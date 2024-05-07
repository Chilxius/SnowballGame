class Pickup
{
  float xPos, yPos;
  float size;
  
  int type;
  
  boolean done;
  
  public Pickup( int t )
  {
    type = t;
    size = sizeByType();
    xPos = random(width);
    yPos = height+size*2;
  }
  
  int sizeByType()
  {
    if( type == 0 ) return 20;
    if( type == 1 ) return 20;
    if( type == 2 ) return 20;
    
    return 0;
  }

  void moveAndDraw()
  {
    yPos -= gameSpeed;
    
    if( yPos < -size*2 )
      done = true;
    if( dist( xPos, yPos, s.xPos, s.yPos ) < (s.size+size)/2 )
    {
      cash+=type+1;
      done = true;
    }
    
    //Draws the item
    fill(255,255,0);
    circle( xPos, yPos, size ); //TEMP
    //image( pickupImage[type], xPos, yPos );
  }
}
