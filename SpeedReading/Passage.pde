public class Passage extends DisplayMethod {
  int numLines = 3;
  String[] lines = new String[numLines];
  Passage(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;

    Resize(xx, yy, ww, hh);
    SetFontSize(fS);
    textSize(fontSize);
    for (int i = 0; i < numLines; ++i) {
      lines[i] = "";
    }
  }

  void Resize(float newX, float newY, float newW, float newH) {
    minX = newX;
    minY = newY;
    w = newW;
    h = newH;
    idealLength = w;
  }

  void Display() {
    for (int i = 0; i < numLines; ++i) {
      textSize(fontSize);
      text(lines[i], x - textWidth(lines[i])/2.0, y + (2.0*fontSize*i));
    }
  }

  void GetNextChunk() {
    curLine = "";
    println(curIndex);
    for (int i = 0; i < numLines; ++i) {
      while (curIndex < document.size()) {
        if (textWidth(curLine + document.get(curIndex)) < idealLength) {
          curLine += document.get(curIndex) + " ";
          ++curIndex;
        } else {
          lines[i] = curLine;
          curLine = "";
          break;
        }
      }
    }
    x = w/2.0 + minX;
    y = h/2.0 + minY;
  }
  void Back() {
    println("Back Not implemented");
  }
  void Forward() {
    println("Forward Not implemented");
  }
  void Resize() {
  }
  void LimitTextToDisplayArea() {
  }
}
