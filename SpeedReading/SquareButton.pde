abstract class SquareButton extends Button {
  float w, h;
  void Display() {
    rect(x-w/2.0, y-h/2.0, w, h);
    ellipse(x, y, 5, 5);
  }
  abstract void OnClick();
  boolean Clicked() {
    //x, y middle of rectangle
    return (x-w/2.0 <= mouseX && mouseX <= x+w/2.0) && (y-h/2.0 <= mouseY && mouseY <= y+h/2.0);
  }
}
