abstract class DisplayMethod {
  //Methods:
  //-Draw
  //-Building next line
  //-Back and forward
  //-Interpretation of speed
  abstract void Display();
  abstract void GetNextChunk();
  abstract void Back();
  abstract void Forward();
  abstract void Resize();

  ArrayList<String> document;
  String curLine;
  float idealLength;
  int textHeight = 30; //todo: make better
  int curIndex = 0;
}
