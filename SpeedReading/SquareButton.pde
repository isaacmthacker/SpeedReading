abstract class SquareButton extends Button {
  float w, h;
  void Display() {
    //x, y represent the center of the square
    //Draw accordingly
    rect(x-w/2.0, y-h/2.0, w, h);
  }
  abstract void OnClick();
  boolean Clicked() {
    //x, y middle of rectangle
    return (x-w/2.0 <= mouseX && mouseX <= x+w/2.0) && (y-h/2.0 <= mouseY && mouseY <= y+h/2.0);
  }
}
