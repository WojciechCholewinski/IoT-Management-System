#include "LedControl.h"
#include <Arduino.h>

const int ledPin = 13;
const int pwmPin = 5;     
const int pwmFrequency = 2000; 
const int pwmResolution = 8; 


int LedPins[] = { 13, 12, 14, 27, 26, 25, 33, 32, 18, 19 };
int pinCount = sizeof(LedPins) / sizeof(LedPins[0]); 

bool ledState = false; 
int animationStep = 0; 


void setupLed() {
  for (int i = 0; i < pinCount; i++) {
    pinMode(LedPins[i], OUTPUT);
  }
  pinMode(pwmPin, OUTPUT);
  ledcAttach(pwmPin, pwmFrequency, pwmResolution);
}


void turnOnLed() {
  ledState = true;   
  animationStep = 0; 
  Serial.println("Diody włączone");
}

void turnOffLed() {
  ledState = false; 
  for (int i = 0; i < pinCount; i++) {
    digitalWrite(LedPins[i], LOW); 
  }
  Serial.println("Diody wyłączone");
}


void updateLedAnimation() {
  if (ledState) { 
    for (int i = 0; i < pinCount; i++) {
      if (i % 2 == animationStep % 2) {
        digitalWrite(LedPins[i], HIGH);
      } else {
        digitalWrite(LedPins[i], LOW);
      }
    }
    ledcWrite(pwmPin, animationStep / 2);
    delay(250);
    ledcWrite(pwmPin, 0);
    delay(100);
    ledcWrite(pwmPin, animationStep / 3);
    delay(250);
    ledcWrite(pwmPin, 0);

    delay(1000);
    animationStep++; 
  }
}