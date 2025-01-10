final int FPS = 60;
int frameCounter = 0;
int frameUpdate = 0;
//Word change speed - how often to update line on page to start
float UpdateTime = 1.5; //update every 2 seconds


//TODO: Move to separate files
//TODO: how to easily toggle between display methods?
//    split into classes with inheritance?
//TODO: Go by words per minute
//TODO: Dsylexic font
//TODO: Handle resizing
//    specific option to resize?
//    why could not stretch window?
//TODO: make things scalable
//TODO: Restart with chosen method

//TODO: Line by line in middle
//TODO: Line by line by in different places
//TODO: Paragraph and highlight / gray out words as go

BufferedReader reader;
String line = null;
int numLines = 5;
int numWordsInLine = 5;
int charsInLine = 0;

boolean PAUSED = false;
final String PAUSED_TEXT = "Paused";

final float leftControlSize = 0.1;
final float bottomControlSize = 0.1;


DisplayMethod display;
CrazyLine crazyLine;
NormalLine normalLine;
Passage passage;


DisplayControl displayControl;
SingleLineControl singleLineControl;

//=====================================================================

//Draws the back, start/stop, and next controls
//TODO: Maybe tie back/next to paragraphs?
//  for line by line, can have queue of seen indicies and just rebuild the line
void DrawControls() {
  noFill();
  String pauseText;
  if (PAUSED) {
    pauseText = "Resume";
  } else {
    pauseText = "Pause";
  }
  text(pauseText, width/2.0 - textWidth(pauseText)/2.0, height-(height*bottomControlSize)/2.0);
  
  //Bottom display control
  rect(width*leftControlSize, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), height);
  //left display control
  displayControl.Display();


  //TODO:
  //pause/play, back, forward
  //speed, font size, method
  //same control for crazy and normal lines
  //different control for passage
  //add draw space for each method
  //restart
}

//Reads document with content in it
//Splits into individual words
//TODO: Better paragraph splits
ArrayList<String> ReadFile() {
  println("ReadFile");
  int paragraphs = 0;
  ArrayList<String> document = new ArrayList<String>();
  do {
    try {
      line = reader.readLine();
      if (line == null) {
        println("end of file?");
      } else {
        println("Line: " + line);
        String[] parts = line.split(" ");
        ++paragraphs;
        //TODO: add paragraph checking as well
        //TODO: filter out blank lines
        for (int i = 0; i < parts.length; ++i) {
          document.add(parts[i]);
        }
        printArray(line);
      }
    }
    catch (IOException e) {
      println("Failed to open file");
    }
  } while (line != null);
  println("Paragraphs: " + paragraphs);
  return document;
}

//Tied to FPS
void SecondDelay() {
  ++frameCounter;
  if (frameCounter >= frameUpdate) {
    frameCounter = 0;
    //Once we hit our desired time, update line being drawn
    display.GetNextChunk();
  }
}

//Draws pause splash screen
void DrawPauseScreen() {
  text(PAUSED_TEXT, width/2.0 - textWidth(PAUSED_TEXT)/2.0, 30);
}

//Update how often we update the drawn line based on the update time
void CalculateDrawingTime() {
  frameUpdate = int(float(FPS) * UpdateTime);
}

//==============================================================================
//Initial Window setup
void setup() {
  size(800, 800);
  windowResizable(true);
  frameRate(FPS);
  CalculateDrawingTime();
  //reader = createReader("cats.txt");
  reader = createReader("abstract.txt");
  ArrayList<String> document = ReadFile();
  println("Total words in document: " + document.size());
  
  int fontSize = 30;
  PFont myFont = createFont("C:\\Users\\isaac\\Desktop\\Processing\\SpeedReading\\SpeedReading\\opendyslexic-0.910.12-rc2-2019.10.17\\OpenDyslexic-Regular.otf", 30);
  textFont(myFont);

  SingleLineControl singleLineControl = new SingleLineControl(0, 0, width*leftControlSize, height);
  displayControl = singleLineControl;

  crazyLine = new CrazyLine(document, width*leftControlSize, 0, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), fontSize);
  normalLine = new NormalLine(document, width*leftControlSize, 0, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), fontSize);
  passage = new Passage(document);
  //display = normalLine;
  display = crazyLine;
}

//Draw loop
void draw() {
  background(255);
  fill(0);
  DrawControls();
  if (!PAUSED) {
    SecondDelay();
  } else {
    DrawPauseScreen();
  }
  //Run the display method
  display.Display();
}

//On mouse click
void mouseClicked() {
  PAUSED = !PAUSED;
}

void windowResized() {
  println("Window resized");
  //todo: check this matches initialization
  display.Resize(width*0.1, 0, width*0.9, height*0.9);
}
