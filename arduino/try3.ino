#include <SPI.h>
#include <SD.h>
File dataFile;
#include "Wire.h"
#include <MPU6050_light.h>
MPU6050 mpu(Wire);
unsigned long timer = 0;
long randNumber;
char FileName[40];

void setup() {
  SD.begin(4);  // pin number 4
  Serial.begin(9600);
  Wire.begin();
  byte status = mpu.begin();
  Serial.print(F("MPU6050 status: "));
  Serial.println(status);
  while (status != 0) {}  // stop if could not connect to MPU6050
  Serial.println(F("Calculating offsets, don't move MPU6050"));
  delay(1000);
  mpu.calcOffsets(true, true);  // gyro and accelero
  Serial.println("Done!\n");
  randomSeed(0);
  //randNumber = random(3000);
  //Serial.println(randNumber);
  sprintf(FileName, "testdata.txt", randNumber);
  dataFile = SD.open(FileName,FILE_WRITE);
}

int i = 0;
void loop() {
  mpu.update();
  if (i < 340) {
    if (millis() - timer > 100) {
      // ACCELERO
      dataFile.print(mpu.getAccX());
      dataFile.print(" ");
      dataFile.print(mpu.getAccY());
      dataFile.print(" ");
      dataFile.print(mpu.getAccZ());
      dataFile.print(" ");
      timer = millis();
      dataFile.println(millis());
      i++;
      if (i == 340) {
        dataFile.close();
        Serial.println("Data collection completed!");
        delay(10); // Wait for a moment before starting a new session
      }
    }
  }
}
