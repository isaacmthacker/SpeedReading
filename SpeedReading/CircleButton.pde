abstract class CircleControl extends Button {
  float r;
  abstract void Display();
  abstract void OnClick();
  boolean Clicked() {

    //distance of mouseX, mouseY to center x, y
    //sqrt ((x2-x1)^2 + (y2-y1)^2) <= r
    return (mouseX-x)*(mouseX-x) + (mouseY-y)*(mouseY-y) <= r*r;
  }
}
