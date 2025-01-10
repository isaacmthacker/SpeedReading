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

ArrayList<String> document = new ArrayList<String>();
int curIndex = 0;
String curLine = "";

boolean PAUSED = false;
final String PAUSED_TEXT = "Paused";

CrazyLine cl;

//=====================================================================

//Draws the back, start/stop, and next controls
//TODO: Maybe tie back/next to paragraphs?
//  for line by line, can have queue of seen indicies and just rebuild the line
void DrawControls() {
  //fill(0);
  noFill();
  ellipse(width/2.0, height-30, 30, 30);
  if (PAUSED) {
    text("Resume", width/2.0, height-30);
  } else {
    text("Pause", width/2.0, height-30);
  }
}

//Reads document with content in it
//Splits into individual words
//TODO: Better paragraph splits
void ReadFile() {
  println("ReadFile");
  int paragraphs = 0;
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
}

//Builds the line from the document
void BuildLine() {
  //Get numWordsInLine from document array
  //curLine = "";
  //Going by num of words in a line
  //int end = min(curIndex+numWordsInLine, document.size());
  //for(int i = curIndex; i < end; ++i) {
  //  curLine += document.get(i);
  //  if(i != end-1) {
  //    curLine += " ";
  //  }
  //}
  //println(curLine);
  //println(curLine.length());
  ////Advance cur index
  //curIndex = end;

  //want to keep font size the same

  curLine = "";
  while (curIndex < document.size()) {
    if (textWidth(curLine + document.get(curIndex)) < width) {
      curLine += document.get(curIndex) + " ";
      ++curIndex;
    } else {
      break;
    }
  }
  println("Curline: " + curLine);
}

//1-second timer
//Tied to FPS
//Builds the line to be displayed
void SecondDelay() {
  ++frameCounter;
  if (frameCounter >= frameUpdate) {
    frameCounter = 0;
    //Once we hit our desired time, create a new line to be drawn
    BuildLine();
    cl.GetNextChunk();
  }
}

//Draws the current line of text
void DrawTextLine() {
  if (curLine.length() > 0) {
    text(curLine, width/2.0 - textWidth(curLine)/2.0, height/2.0);
  }
  cl.Display();
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
  println("hello");
  background(0);
  frameRate(FPS);
  CalculateDrawingTime();
  reader = createReader("C:\\temp\\2025-01-09-Test\\SpeedReading\\SpeedReading\\cats.txt");
  ReadFile();
  println("Total words in document: " + document.size());
  textSize(30);
  
  cl = new CrazyLine(document);
}

//Draw loop
void draw() {
  background(0);
  fill(255);
  rect(0, 0, width, height);
  fill(0);
  DrawControls();
  if (!PAUSED) {
    SecondDelay();
  } else {
    DrawPauseScreen();
  }
  DrawTextLine();
}

//On mouse click
void mouseClicked() {
  PAUSED = !PAUSED;
  if (mouseButton == RIGHT) {
    println("RIGHT BUTTON CLICKED");
  }
}

void windowResized() {
  println("RESIZES!!");
}

//windowResized

//https://processing.org/reference/windowResized_.html
