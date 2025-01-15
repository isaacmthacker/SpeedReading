public class PausePlayButton extends CircleControl {

  public PausePlayButton(float xx, float yy, float rr) {
    x = xx;
    y = yy;
    r = rr;
  }
  boolean paused = false;
  boolean disabled = false;
  void Display() {
    ellipse(x, y, r, r);
    if (paused) {
    } else {
    }
  }
  void OnClick() {
    println("Clicked");
  }
  
  //if separate classes for buttons, need to incorporate into overall DisplayControl method so can still get at
  //  the data
}
