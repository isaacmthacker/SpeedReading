public class CrazyLine extends DisplayMethod {

  CrazyLine(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
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
    idealLength = w * 0.75;
  }

  void Display() {
    if (curLine.length() > 0) {
      textSize(fontSize);
      text(curLine, x - textWidth(curLine)/2.0, y);
    }
  }

  void LimitTextToDisplayArea() {
    float halfTextWidth = textWidth(curLine)/2.0;
    //Limit horizontal
    x = max(minX + halfTextWidth, x);
    x = min(minX + w - halfTextWidth, x);
    //Limit vertical
    y = max(minY + fontSize, y);
    y = min(minY + h - fontSize/2.0, y);
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
    println(curLine);
    x = random(w);
    y = random(h);
    
    println("Before limit: ", x, y);

    LimitTextToDisplayArea();
    println("After limit: ", x, y);

    println(x, y);
  }
  void Back() {
    println("Back Not implemented");
  }
  void Forward() {
    println("Forward Not implemented");
  }
  void SetFontSize(int fS) {
    fontSize = fS;
  }
}
