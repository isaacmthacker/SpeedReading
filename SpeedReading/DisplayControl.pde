abstract class DisplayControl {
  float x, y, w, h;
  abstract void Display();
  void Resize(float xx, float yy, float ww, float hh) {
    x = xx;
    y = yy;
    w = ww;
    h = hh;
  }
}
