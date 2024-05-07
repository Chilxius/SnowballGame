class Snowball
{
  float xPos, yPos;
  float xSpd;
  boolean lf, rt; //direction pressed
  float size;
  
  //Growth data
  int nextGrow = 1000;
  int category = 0;
  
  public Snowball( float x, float y )
  {
    xPos = x;
    yPos = y;
    size = 50;
  }
  
  void moveSnowball()
  {
    //Add speed
    if(lf)
      xSpd-=0.4;
    if(rt)
      xSpd+=0.4;
      
    //Friction
    xSpd *= 0.95;
    
    xPos += xSpd;
    if( xPos > width ) xPos = width;
    if( xPos < 0 ) xPos = 0;
  }
  
  void drawSnowball()
  {
    fill(255);
    stroke(0);
    circle(xPos,yPos,size);
    trails.add( new Trail( xPos+random(-3,3), yPos+size/8, size*.75 ) );
  }
  
  void growSnowball()
  {
    if( millis() > nextGrow )
    {
      nextGrow += 500;
      size+=0.1;
    }
  }
}
