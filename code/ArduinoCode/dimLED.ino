// To set brightness pass integer '1' along with brightness value
// To get brightness pass integer '2'
// Run LED test sequency pass integer '3'

const int ledPin = 11;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin, LOW);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  // Variable to store current brightness
  static int brightnessLevel = 0;
    
  if (Serial.available() > 0)
  {
    int instruction = Serial.parseInt();
    
    // Set the brightness level
    if (instruction == 1)
    {
      int brightness = Serial.parseInt();
            
      if (Serial.read() == '\n') 
      {
        if (brightness >= 0 && brightness <= 255)
        {
          analogWrite(ledPin, brightness);
          brightnessLevel = brightness;
        }
        else
        {
          Serial.write("Please enter a brightness value from 0-255.\n");
        }
      }
    }
    
    // Get the current brightness level
    else if (instruction == 2)
    {
      Serial.println(brightnessLevel);
    }
    
    // Run LED test sequency
    else if (instruction == 3)
    {
      for(int i = 0 ; i <= 255; i+=1) 
      {
        analogWrite(ledPin, i);
        delay(4);
      }
      
      for(int i = 255 ; i >= 0; i-=1) 
      {
        analogWrite(ledPin, i);
        delay(4);
      }
      
      delay(250);
      // Setting brightness back to original level
      analogWrite(ledPin, brightnessLevel);
    }
  }
}
