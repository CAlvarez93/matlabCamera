/* 
http://pulsedlight3d.com
This sketch demonstrates getting distance with the LIDAR-Lite Sensor
It utilizes the 'Arduino Wire Library'
*/

#include <Wire.h>
#define    LIDARLite_ADDRESS   0x62          // Default I2C Address of LIDAR-Lite.
#define    RegisterMeasure     0x00          // Register to write to initiate ranging.
#define    MeasureValue        0x04          // Value to initiate ranging.
#define    RegisterHighLowB    0x8f          // Register to get both High and Low bytes in 1 call.

int wait4TransmitTime = 20; //in usec

int reading = 0;
int average = 0;
int count = 0;
double speedofRada = 0;
double widthOfObject = 0;
double distance = 0;

void setup()
{
  Wire.begin(); // join i2c bus
  Serial.begin(38400); // start serial communication at 9600bps
  Serial.print("What is the speed of RADA? ");
  while(!Serial.available());
  speedofRada =  double(Serial.read());
}

void loop()
{
  Wire.beginTransmission((int)LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write((int)RegisterMeasure); // sets register pointer to  (0x00)  
  Wire.write((int)MeasureValue); // sets register pointer to  (0x00)  
  Wire.endTransmission(); // stop transmitting

  delay(20); // Wait 20ms for transmit

  Wire.beginTransmission((int)LIDARLite_ADDRESS); // transmit to LIDAR-Lite
  Wire.write((int)RegisterHighLowB); // sets register pointer to (0x8f)
  Wire.endTransmission(); // stop transmitting

  delay(20); // Wait 20ms for transmit

  Wire.requestFrom((int)LIDARLite_ADDRESS, 2); // request 2 bytes from LIDAR-Lite

  if(2 <= Wire.available()) // if two bytes were received
  {
    reading = Wire.read(); // receive high byte (overwrites previous reading)
    reading = reading << 8; // shift high byte to be high 8 bits
    reading |= Wire.read(); // receive low byte as lower 8 bits
    if(reading <= 50){
      if(count == 0){
        widthOfObject = 0;
        //This is the first edge of the object
        //send command to GoPro to shutter
        Serial.println("t");
      }
      average += reading;
      count++;
//      Serial.print("cur reading: "); // print the reading
//      Serial.println(reading);
    }else{
      if(count != 0)
      {
//        Serial.print("avg reading: ");
        distance = double(average) / double(count);
        Serial.println(distance);

        //Calculate width here
        widthOfObject = double(count * wait4TransmitTime * 0.001) * speedofRada;
//        Serial.print("width of object ");
        Serial.println(widthOfObject);
        average = 0;
        count = 0;
      }
    }
  }
}
