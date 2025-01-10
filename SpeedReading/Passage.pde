public class Passage extends DisplayMethod {
  Passage(ArrayList<String> doc) {
    document = doc;
  }

  void Resize(float newX, float newY, float newW, float newH) {
    w = newW;
    h = newH;
  }

  void Display() {
  }
  void GetNextChunk() {
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
