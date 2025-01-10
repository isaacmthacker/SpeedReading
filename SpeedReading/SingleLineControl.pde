class SingleLineControl extends DisplayControl {
  
  float x, y, wid, hei;
  
  public SingleLineControl(float xx, float yy, float w, float h) {
    x = xx;
    y = yy;
    wid = w;
    hei = h;
  }
  void Display() {
    rect(x, y, wid, hei);
  }
  //speed
  //font size
}
