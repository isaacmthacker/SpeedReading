//TODO: have CrazyLine interhit from this, make DisplayMethod an interface
public class NormalLine extends DisplayMethod {
  NormalLine(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;
    Resize(xx, yy, ww, hh);
    SetFontSize(fS);
    textSize(fontSize);

    curLine = "";
    history = new Stack<Integer>();
    //Always make sure start is in the stack
    history.push(0);
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
    //println("Get next chunk");
    if (history.peek() != curIndex) {
      history.push(curIndex);
    }
    println(history);
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
    x = w/2.0 + minX;
    y = h/2.0 + minY;
  }
  void Back() {
    if (!history.empty()) {
      history.pop();
      //Ensure something is left in the stack
      if (history.empty()) {
        history.push(0);
      }
      curIndex = history.peek();
    }
  }
  void Forward() {
    println("Forward Not implemented");
  }

  void LimitTextToDisplayArea() {
  }
}
