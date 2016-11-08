/**********************************************************************************
* ESP8266 REMOTE for GoPro by Robert Stefanowicz - euerdesign.de 28 Dec 2015 *
*********************************************************************************/

#include <WiFi.h>

/*********************************
* YOUR SETTINGS *
*********************************/

const char* ssid = "Go1337Pro"; //Your Wifi name (SSID)
const char* password = "PASSWORD"; //Your WiFi password
/*********************************
* DO NOT CHANGE BELOW THIS LINE *
*********************************/
const char* host = "10.5.5.9";
int delshort = 50;
int dellong = 500;
const int buttonPin = 0;
int value;
int buttonstate;
int buttonstates;
int camstates;
int checked;
const int buttonPins = 2;
int values;
int valuess;
void setup() {
  Serial.begin(115200);
  delay(100);
  pinMode(buttonPin, INPUT);
  pinMode(buttonPins, INPUT);
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}
void loop() {
  delay(delshort);
  values = digitalRead(buttonPins);
  
  if (buttonstates != values){
    buttonstates = values;
    if (values == 1){ 
      checked = 0;
      if (camstates == 1){camstates = 0; checked = 1;}
      if (camstates == 0){
        if (checked == 0) {camstates = 1;}
      }
      Serial.println("Aenderung");
      Serial.print("connecting to ");
      Serial.println(host);
      WiFiClient client;
      const int httpPort = 80;
      if (!client.connect(host, httpPort)) {
        Serial.println("connection failed");
        return;
      }
      String url = "/gp/gpControl/command/shutter?p=";
      url += camstates;
      Serial.print("Requesting URL: ");
      Serial.println(url);
      client.print(String("GET ") + url + " HTTP/1.1\r\n" +
      "Host: " + host + "\r\n" +
      "Connection: close\r\n\r\n");
      delay(10);
      Serial.println();
      Serial.println("closing connection");
  
    }
    delay(dellong);
    valuess = digitalRead(buttonPins);
    if (valuess == 1){
      camstates = 0;
      while(valuess == 1){
      delay(delshort);
      Serial.println("WHILE-LOOP");
      Serial.println(valuess);
      valuess = digitalRead(buttonPins);
    }
  
    Serial.println("BUTTON STATE CHANGE ");
    Serial.print("connecting to ");
    Serial.println(host);
    WiFiClient client;
    const int httpPort = 80;
    if (!client.connect(host, httpPort)) {
      Serial.println("connection failed");
      return;
    }
    String url = "/gp/gpControl/command/shutter?p=0";
    Serial.print("Requesting URL: ");
    Serial.println(url);
    client.print(String("GET ") + url + " HTTP/1.1\r\n" +
    "Host: " + host + "\r\n" +
    "Connection: close\r\n\r\n");
    delay(10);
    Serial.println();
    Serial.println("closing connection");
  }
  
  }

}
