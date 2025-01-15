public class OpenFileButton extends SquareButton {
  
  String buttonText = "Open File";
  
  public OpenFileButton(float xx, float yy, float ww, float hh) {
    x = xx;
    y = yy;
    w = ww;
    h = hh;
  }

  void Display() {
    super.Display();
    text(buttonText, x-textWidth(buttonText)/2.0, y);
  }
  void OnClick() {
    selectInput("Choose a text file to open", "OpenSelectedFile");
  }
  //public void MyOpenSelectedFile(File selection) {
  //  if(selection != null) {
  //    println(selection.getAbsolutePath());
  //  }
  //}
}
