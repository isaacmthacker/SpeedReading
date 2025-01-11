public class Passage extends DisplayMethod {
  int numLines = 5;
  String[] lines = new String[numLines];
  Passage(ArrayList<String> doc, float xx, float yy, float ww, float hh, int fS) {
    document = doc;

    Resize(xx, yy, ww, hh);
    SetFontSize(fS);
    textSize(fontSize);
    for (int i = 0; i < numLines; ++i) {
      lines[i] = "";
    }
    history = new Stack<Integer>();
  }

  void Resize(float newX, float newY, float newW, float newH) {
    minX = newX;
    minY = newY;
    w = newW;
    h = newH;
    idealLength = w;
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
    curLine = "";
    println(curIndex, document.size());
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
