public class Passage extends DisplayMethod {
  int numLines = 5;
  String[] lines = new String[numLines];
  Passage(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;

    Resize(xx, yy, ww, hh, fS);
    textSize(fontSize);
    for (int i = 0; i < numLines; ++i) {
      lines[i] = "";
    }
    history = new Stack<Integer>();
    //Always make sure start is in the stack
    history.push(0);
  }

  void Resize(float newX, float newY, float newW, float newH, int newFontSize) {
    minX = newX;
    minY = newY;
    w = newW;
    h = newH;
    idealLength = w;
    SetFontSize(newFontSize);
  }

  void Display() {
    //middle of page: minY + h/2.0
    //number of lines
    //font size
    //number of lines * 2 = lines and space between
    //total height is fontSize * numLines * 2
    //Y step is startingY + yStep
    //StartingY =
    //yStep = 2*fontSize (for empty lines)
    //Get middle location, then subtract half of the block of text's height
    //-1 for no empty line at the bottom of the text
    float yPos = (minY + h/2.0) - (2 * (numLines-1) * fontSize)/2.0;
    float yStep = 2.0*fontSize;
    for (int i = 0; i < numLines; ++i) {
      textSize(fontSize);
      text(lines[i], x - textWidth(lines[i])/2.0, yPos);
      yPos += yStep;
    }
  }

  void GetNextChunk() {
    //println("Passage GetNextChunk");
    if (history.peek() != curIndex) {
      history.push(curIndex);
    }
    //println(history);
    curLine = "";
    //println(curIndex, document.size());
    int updatedLines = 0;
    for (int i = 0; i < numLines; ++i) {
      lines[i] = "";
      while (curIndex < document.size()) {
        if (textWidth(curLine + document.get(curIndex)) < idealLength) {
          curLine += document.get(curIndex) + " ";
          ++curIndex;
          if (curIndex == document.size()) {
            lines[i] = curLine;
            ++updatedLines;
          }
        } else {
          lines[i] = curLine;
          curLine = "";
          ++updatedLines;
          break;
        }
      }
    }
    if (updatedLines == 0) {
      lines[0] = "All done :)";
    }
    x = w/2.0 + minX;
    y = h/2.0 + minY;
  }
  void Back() {
    //println("Passage Back");
    if (!history.empty()) {
      //println("Before pop: ");
      //println(history);
      history.pop();
      //Ensure something is left in the stack
      if (history.empty()) {
        history.push(0);
      }
      //println("After pop:");
      //println(history);
      curIndex = history.peek();
      //println("Back: new index: ", curIndex);
    }
  }
  void Forward() {
    println("Forward Not implemented");
  }
  void Resize() {
  }
  void LimitTextToDisplayArea() {
  }
}
