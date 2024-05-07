class Trail
{
  float xPos, yPos;
  float size;
  
  public Trail( float x, float y, float s )
  {
    xPos = x;
    yPos = y;
    size = s;
  }
  
  public void moveAndDrawTrail()
  {
    noStroke();
    fill(200);
    circle(xPos,yPos,size);
    yPos-=gameSpeed;
  }
}
