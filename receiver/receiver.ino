#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
#include "HX711.h"
#include <EEPROM.h>
#include <SoftwareSerial.h>



#define calibration_factor 16000.0
#define LOADCELL_DOUT_PIN  3
#define LOADCELL_SCK_PIN  2
#define WEIGHT_SETTING_ADDRESS 0
#define PERCENTAGE_SETTING_ADDRESS 1

HX711 scale;
RF24 radio(7, 8); // CE, CSN
SoftwareSerial hc06(4, 5);
const byte address[6] = "00001";
void setup() {
  Serial.begin(9600);
  pinMode(10,OUTPUT);
  //Setup for receiver
  radio.begin();
  radio.setDataRate(RF24_1MBPS);
  radio.setPayloadSize(4);
  radio.disableAckPayload();
  radio.setAutoAck(false);
  radio.openReadingPipe(1, address);
  radio.setPALevel(RF24_PA_HIGH);
  radio.startListening();

  //Setup for HC-06
  hc06.begin(9600);
  
  //Setup for sensor
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  scale.set_scale(calibration_factor); 
  scale.tare();
  
  
}


float weightAdder = 0;
float weightBuffer = 0;
int cycleCounter = 0;

void loop() {
  //float weight = scale.get_units();
  //Serial.println(weight);

  
  
  if (radio.available() > 0) {
    float slaveWeight = getSlaveWeight();
    float masterWeight = getMasterWeight();
    if(slaveWeight < 0){
      slaveWeight = 0;
    }
    if(masterWeight < 0){
      
      masterWeight = 0;
    }
    readData();
    warnUser(slaveWeight,masterWeight);
    sendWeight(slaveWeight, masterWeight);
    //output(slaveWeight, masterWeight);

    
    
    
 
   }
  else{
    Serial.println("---------------- No Signal -------------------");
    
    
    
  } 

  
  delay(250);
}


float getSlaveWeight(){
  float slaveWeight = -1337;
  radio.read(&slaveWeight, sizeof(slaveWeight));
  return slaveWeight;
}

float getMasterWeight(){
  float masterWeight = -1337;
  masterWeight = scale.get_units();
  return masterWeight;
}

void output(float slaveWeight, float masterWeight){
  Serial.print("Slave: ");
    Serial.print(slaveWeight, 2);
    Serial.print(" || Master: ");
    Serial.print(masterWeight, 2);
    Serial.print(" || Total: ");
    Serial.println(slaveWeight + masterWeight);
}

void sendWeight(float slaveWeight, float masterWeight){
    String str;
    str.concat(slaveWeight);
    str.concat(';');
    str.concat(masterWeight);
    hc06.println(str);
    hc06.flush();
//    Serial.println(str);
      
    //hc06.print(slaveWeight);
    //hc06.print(";");
    //hc06.println(masterWeight);
    
}
void readData(){
  String inputString = "";
  char input;
  while(hc06.available() > 0){
    input = hc06.read();
    inputString.concat(input);
  }
  if(inputString != ""){
      Serial.println(inputString);

    String weight;
    String belastung;
    // Convert from String Object to String.
    char buf[sizeof(inputString)];
    inputString.toCharArray(buf, sizeof(buf));
    char *p = buf;
    char *str;
    int i = 0;
    while ((str = strtok_r(p, ";", &p))){ // delimiter is the semicolon
      String temp = String(str);
      EEPROM.put(i,atoi(str));
      i += sizeof(int);
    }
  }
}
void warnUser(float slaveWeight,float masterWeight){
  int weight;
  int belastung;
  EEPROM.get(0,weight);
  EEPROM.get(sizeof(int),belastung);
  if(belastung == 0){
    digitalWrite(10,LOW);
  }else{
    if(((slaveWeight+masterWeight)/weight < (float(belastung)/100))){
    Serial.println("warning");
    digitalWrite(10,LOW);
  }
  else{
    if(belastung > 0){
      digitalWrite(10,HIGH);
    }
  }
  }
  
}


//bool setUserWeight(){
  //int userWeight = 80;
  
  //EEPROM.put(WEIGHT_SETTING_ADDRESS, userWeight);
//}
