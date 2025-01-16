public class CrazyLine extends DisplayMethod {

  CrazyLine(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;
    Resize(xx, yy, ww, hh, fS);
    textSize(fontSize);

    curLine = "";
    history = new Stack<Integer>();
    //Always make sure start is in the stack
    history.push(0);
  }

  void Resize(float newX, float newY, float newW, float newH, int newFontSize) {
    minX = newX;
    minY = newY;
    w = newW;
    h = newH;
    idealLength = w * 0.75;
    SetFontSize(newFontSize);
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
    //println("Get next chunk");
    if (history.peek() != curIndex) {
      history.push(curIndex);
    }
    //println(history);
    curLine = "";
    boolean lineUpdated = false;
    while (curIndex < document.size()) {
      if (textWidth(curLine + document.get(curIndex)) < idealLength) {
        curLine += document.get(curIndex) + " ";
        ++curIndex;
        lineUpdated = true;
      } else {
        break;
      }
    }
    if (!lineUpdated) {
      curLine = "All done :)";
    }
    //println(curLine);
    x = random(w);
    y = random(h);

    //println("Before limit: ", x, y);

    LimitTextToDisplayArea();
    //println("After limit: ", x, y);

    //println(x, y);
  }
  void Back() {
    if (!history.empty()) {
      history.pop();
      //Ensure something is left in the stack
      if (history.empty()) {
        history.push(0);
      }
      curIndex = history.peek();
      //println("Back: new index: ", curIndex);
    }
  }
  void Forward() {
    println("Forward Not implemented");
  }
  void SetFontSize(int fS) {
    fontSize = fS;
  }
}
