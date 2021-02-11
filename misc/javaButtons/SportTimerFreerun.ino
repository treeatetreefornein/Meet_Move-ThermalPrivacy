
#define INPUTMODE INPUT_PULLUP    // INPUT or INPUT_PULLUP
#define BOUNCETIME 5              // bouncing time in milliseconds
byte buttonPins[]={2, 3, 4, 5, 6, 9};// pin numbers of all buttons
#define NUMBUTTONS sizeof(buttonPins) // number of buttons (automatically calculated)
byte buttonState[NUMBUTTONS];  // array holds the actual HIGH/LOW states
byte buttonChange[NUMBUTTONS]; // array holds the state changes when button is pressed or released
enum{UNCHANGED,BUTTONUP,BUTTONDOWN};

void input(){
// read the input state and state changes of all buttons
  static unsigned long lastButtonTime; // time stamp for remembering the time when the button states were last read
  memset(buttonChange,0,sizeof(buttonChange)); // reset all old state changes
  if (millis()-lastButtonTime<BOUNCETIME) return;  // within bounce time: leave the function
  lastButtonTime=millis(); // remember the current time
  for (int i=0;i<NUMBUTTONS;i++)
  {
    byte curState=digitalRead(buttonPins[i]);        // current button state
    if (INPUTMODE==INPUT_PULLUP) curState=!curState; // logic is inverted with INPUT_PULLUP
    if (curState!=buttonState[i])                    // state change detected
    {
      if (curState==HIGH) buttonChange[i]=BUTTONDOWN;
      else buttonChange[i]=BUTTONUP;
    }
    buttonState[i]=curState;  // save the current button state
  }
}


void output(){
// send a message to Serial if a button state (pressed/released) has changed
// button pressed: Send button pin number with minus sign
// button released: Send button pin number
  byte action;
  for (int i=0;i<NUMBUTTONS;i++)
  {
    switch (buttonChange[i])  
    {
      case BUTTONUP: Serial.print(buttonPins[i]);break;
      //case BUTTONDOWN: Serial.println(-buttonPins[i]);break;
    }
  }
}


void setup() {
  Serial.begin(9600); // initialize Serial at 9600 baud
  // then initialize all buttons
  for (int i=0;i<NUMBUTTONS;i++) pinMode(buttonPins[i],INPUTMODE);
}

void loop() {
  input();
  // processing(); // if you need any processing, write a function for it!  
  output();
}
