//TODO: have CrazyLine interhit from this, make DisplayMethod an interface
public class NormalLine extends DisplayMethod {
  NormalLine(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;
    Resize(xx, yy, ww, hh);
    SetFontSize(fS);
    textSize(fontSize);

    curLine = "";
  }

  void Resize(float newX, float newY, float newW, float newH) {
    minX = newX;
    minY = newY;
    w = newW;
    h = newH;
    idealLength = w;
  }

  void Display() {
    if (curLine.length() > 0) {
      textSize(fontSize);
      text(curLine, x - textWidth(curLine)/2.0, y);
    }
  }
  
  void GetNextChunk() {
    println("Get next chunk");
    curLine = "";
    while (curIndex < document.size()) {
      if (textWidth(curLine + document.get(curIndex)) < idealLength) {
        curLine += document.get(curIndex) + " ";
        ++curIndex;
      } else {
        break;
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

  void LimitTextToDisplayArea() {
  }
}
