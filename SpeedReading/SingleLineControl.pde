class SingleLineControl extends DisplayControl {

  public SingleLineControl(float xx, float yy, float ww, float hh) {
    Resize(xx, yy, ww, hh);
  }
  void Display() {
    rect(x, y, w, h);
  }

  void Resize(float xx, float yy, float ww, float hh) {
    super.Resize(xx, yy, ww, hh);
  }
  //speed
  //font size
}
