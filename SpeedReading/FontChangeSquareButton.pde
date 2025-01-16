public class FontChangeSquareButton extends SquareButton {
  boolean pos = true;
  final float lineSize = 0.75;
  FontChangeSquareButton(float xx, float yy, float ww, float hh, boolean increase) {
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    pos = increase;
  }
  void Display() {
    super.Display();
    if (pos) {
      line(x, y-h*lineSize/2.0, x, y+h*lineSize/2.0);
    }
    line(x-w*lineSize/2.0, y, x+w*lineSize/2.0, y);
  }
  void OnClick() {
  }
}
