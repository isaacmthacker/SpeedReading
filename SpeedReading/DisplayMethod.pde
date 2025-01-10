abstract class DisplayMethod {
  //Methods:
  //-Draw
  //-Building next line
  //-Back and forward
  //-Interpretation of speed
  abstract void Display();
  abstract void GetNextChunk();
  abstract void Forward();
  abstract void Resize(float newX, float newY, float newW, float newH);
  abstract void LimitTextToDisplayArea();

  ArrayList<String> document;
  //The current piece of text being drawn
  String curLine = "";
  //Goal length for the line
  float idealLength;
  //Current word in document 
  int curIndex = 0;
  //Size of font
  int fontSize = 30;
  //Width and height of display area
  float w, h;
  //Minimum w and h for drawing text in
  float minX, minY;
   //Top-Left corner of
  float x, y;
  
  void Restart() {
    curIndex = 0;
  }
  void SetFontSize(int newFont) {
    fontSize = newFont;
  }
}
