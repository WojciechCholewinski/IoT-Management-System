#include <WiFi.h>
#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include "LedControl.h"
#include "config.h"

WiFiClientSecure espClient;
PubSubClient client(espClient);

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Łączenie z ");
  Serial.println(WIFI_SSID);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("Połączono z Wi-Fi");

  espClient.setInsecure(); 
}

void callback(char* topic, byte* message, unsigned int length) {
  Serial.print("Wiadomość przychodząca z tematu: ");
  Serial.println(topic);

  String messageTemp;

  for (int i = 0; i < length; i++) {
    messageTemp += (char)message[i];
  }

  Serial.print("Wiadomość: ");
  Serial.println(messageTemp);


  if (messageTemp == "ON") {
    turnOnLed();
  }

  else if (messageTemp == "OFF") {
    turnOffLed();
  }
}

void reconnect() {
  static unsigned long lastReconnectAttempt = 0;
  unsigned long now = millis();

  if (!client.connected()) {
    if (now - lastReconnectAttempt > 5000) { 
      lastReconnectAttempt = now;
      Serial.print("Próba połączenia z MQTT... ");

      if (client.connect("ESP32Client", MQTT_USERNAME, MQTT_PASSWORD)) {
        Serial.println("Połączono z MQTT!");
        client.subscribe(MQTT_TOPIC);
      } else {
        Serial.print("Błąd połączenia, rc=");
        Serial.print(client.state());
        Serial.println(" Próba ponownie za 5 sekund");
      }
    }
  }
}


void setup() {
  setupLed(); 
  Serial.begin(115200);
  setup_wifi();
  client.setServer(MQTT_BROKER, MQTT_PORT);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  updateLedAnimation();
}
