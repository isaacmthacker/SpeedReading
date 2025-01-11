final int FPS = 60;
int frameCounter = 0;
int frameUpdate = 0;
//Word change speed - how often to update line on page to start
float UpdateTime = 3.0; //Update time in seconds
float UpdateTimeStep = 0.25;


//TODO: Go by words per minute
//TODO: Handle resizing
//    why could not stretch window?

//TODO: Line by line in middle
//TODO: Line by line by in different places
//TODO: Paragraph and highlight / gray out words as go

BufferedReader reader;
String line = null;

boolean PAUSED = false;
final String PAUSED_TEXT = "Paused";

boolean TIMER_ENABLED = true;

final float leftControlSize = 0.1;
final float bottomControlSize = 0.1;


DisplayMethod display;
CrazyLine crazyLine;
NormalLine normalLine;
Passage passage;
DisplayMethod[] methods;
int methodIndex = 0;


DisplayControl displayControl;
SingleLineControl singleLineControl;

//=====================================================================

//Draws the back, start/stop, and next controls
//TODO: Maybe tie back/next to paragraphs?
//  for line by line, can have queue of seen indicies and just rebuild the line
void DrawControls() {
  noFill();
  String timerStatusText;
  if (TIMER_ENABLED) {
    if (PAUSED) {
      timerStatusText = "Resume";
    } else {
      timerStatusText = "Pause";
    }
  } else {
    timerStatusText = "Disabled";
  }
  text(timerStatusText, width/2.0 - textWidth(timerStatusText)/2.0, height-(height*bottomControlSize)/2.0);

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


void DrawErrorScreen() {
  String errorText = "Could not find file";
  textSize(12);
  background(255);
  fill(0);
  text(errorText, 0, height/2.0);
  text("\"place-text-here.txt\" expected to be in this folder:", 0, height/2.0 + 30);
  text(System.getProperty("user.dir"), 0, height/2.0 + 60);
}

//==============================================================================
//Initial Window setup
void setup() {
  size(800, 800);
  windowResizable(true);
  frameRate(FPS);
  CalculateDrawingTime();
  reader = createReader("place-text-here.txt");
  //TODO: Add error message if cannot open file
  if (reader == null) {
    DrawErrorScreen();
    noLoop();
  } else {
    ArrayList<String> document = ReadFile();
    println("Total words in document: " + document.size());

    int fontSize = 30;
    PFont myFont = createFont("opendyslexic-0.910.12-rc2-2019.10.17\\OpenDyslexic-Regular.otf", 30);
    textFont(myFont);

    SingleLineControl singleLineControl = new SingleLineControl(0, 0, width*leftControlSize, height);
    displayControl = singleLineControl;

    crazyLine = new CrazyLine(document, width*leftControlSize, 0, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), fontSize);
    normalLine = new NormalLine(document, width*leftControlSize, 0, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), fontSize);
    passage = new Passage(document, width*leftControlSize, 0, width*(1.0-leftControlSize), height*(1.0-bottomControlSize), fontSize);

    methods = new DisplayMethod[] { crazyLine, normalLine, passage };

    display = crazyLine;
  }
}

//Draw loop
void draw() {
  background(255);
  fill(0);
  DrawControls();
  if (!PAUSED) {
    if (TIMER_ENABLED) {
      SecondDelay();
    }
  } else {
    DrawPauseScreen();
  }
  //Run the display method
  display.Display();
  text("Delay: " + UpdateTime + "s", width*(leftControlSize/2.0), height-(height*bottomControlSize)/2.0);

  String modeStr = "Mode: " + methodIndex;
  text(modeStr, width - textWidth(modeStr), height-(height*bottomControlSize)/2.0);
}

//On mouse click
void mouseClicked() {
  if (TIMER_ENABLED) {
    PAUSED = !PAUSED;
  } else {
    display.GetNextChunk();
  }
}

void ForceDisplayUpdate() {
  frameCounter = frameUpdate;
}

void keyPressed() {
  if (key == 'm') {
    println("Changing mode");
    methodIndex = (methodIndex + 1) % methods.length;
    display = methods[methodIndex];
    ForceDisplayUpdate();
  }
  if (key == 'r') {
    //restart
    display.Restart();
    //Force immediate update
    ForceDisplayUpdate();
    if (PAUSED) {
      //Force display to show beginning
      display.GetNextChunk();
    }
  }
  if (key == 't') {
    TIMER_ENABLED = !TIMER_ENABLED;
    PAUSED = false;
  }
  //println(keyCode);
  if (keyCode == 38) {
    //UP
    UpdateTime += UpdateTimeStep;
    CalculateDrawingTime();
  }
  if (keyCode == 40) {
    //DOWN
    UpdateTime -= UpdateTimeStep;
    UpdateTime = max(UpdateTimeStep, UpdateTime);
    CalculateDrawingTime();
  }
  if (keyCode == 32) {
    //SPACE
    if (TIMER_ENABLED) {
      PAUSED = !PAUSED;
    }
  }
  if (keyCode == 37) {
    //Left Arrow
    //TODO: See why display isn't updating if timer is disabled
    display.Back();
    if (PAUSED || !TIMER_ENABLED) {
      display.GetNextChunk();
    }
    ForceDisplayUpdate();
  }
  if (keyCode == 39) {
    //Right Arrow
    display.GetNextChunk();
    ForceDisplayUpdate();
  }
}

void windowResized() {
  println("Window resized");
  //todo: check this matches initialization

  //Update all methods, not just active one
  for (int i = 0; i < methods.length; ++i) {
    methods[i].Resize(width*0.1, 0, width*0.9, height*0.9);
  }
}
