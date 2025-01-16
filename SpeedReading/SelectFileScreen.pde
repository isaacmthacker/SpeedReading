public class SelectFileScreen extends DisplayMethod {

  public SelectFileScreen(int fS) {
    fontSize = fS;
  }
  void Display() {
    String openFileText = "Select file to open";
    textSize(fontSize);
    background(255);
    fill(0);
    text(openFileText, 0, height/2.0);
    text("Press 'o' at any time to select a new file", 0, height/2.0 + fontSize);
  }
  void GetNextChunk() {
  }
  void Back() {
  }
  void Forward() {
  }
  void Resize(float newX, float newY, float newW, float newH, int fontSize) {
  }
  void LimitTextToDisplayArea() {
  }
}
