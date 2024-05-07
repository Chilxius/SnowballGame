class Debris
{
  float xPos, yPos;
  int type;
  boolean done;
  
  public Debris( int t )
  {
    type = t;
    xPos = random(width);
    yPos = height+100;
  }
  
  public void moveAndDraw()
  {
    yPos -= gameSpeed;
    
    if( yPos < -200 )
      done = true;
      
    //Draws the item
    fill(200);
    circle( xPos, yPos, 10 ); //TEMP
    //image( debrisImage[type], xPos,yPos );
  }
}
