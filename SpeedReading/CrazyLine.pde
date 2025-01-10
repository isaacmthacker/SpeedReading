public class CrazyLine extends DisplayMethod {

  float x = 0;
  float y = 0;

  CrazyLine(ArrayList<String> doc) {
    document = doc;
    idealLength = width*0.75;
    curLine = "";
  }

  void Display() {
    if (curLine.length() > 0) {
      text(curLine, x - textWidth(curLine)/2.0, y);
    }
  }
  void GetNextChunk() {
    curLine = "";
    while (curIndex < document.size()) {
      if (textWidth(curLine + document.get(curIndex)) < idealLength) {
        curLine += document.get(curIndex) + " ";
        ++curIndex;
      } else {
        break;
      }
    }
    println("Curline: " + curLine);
    x = min(random(width), width-textWidth(curLine));
    x = max(textWidth(curLine)/2.0, x);
    
    y = min(random(height), height-textHeight);
    y = max(textHeight, y);
    
    println(x, y);
  }
  void Back() {
    println("Back Not implemented");
  }
  void Forward() {
    println("Forward Not implemented");
  }
  void Resize() {
  }
}
