# Activity Recognition Hat 

This project implemented an activity recognition system using a hat fitted with sensors. The hat can recognize walking and running. This was the course project for "Measurement and Control Systems" course.

![](https://github.com/yaswhar/WalkRunHat/blob/main/images/photo_2024-01-29_22-22-18.jpg)

## Hardware

The hat uses the following hardware:

- Arduino UNO
- MPU-6050 accelerometer/gyroscope module
- MicroSD card module 
- Battery pack
- Wires and connectors

The Arduino UNO collects the acceleration data from the MPU-6050 and logs it to a MicroSD card using the MicroSD module.

## Data  

The acceleration data was collected only for the z-axis, as it provided the clearest signal for recognizing vertical movements like walking, running, ascending and descending stairs. Plots of this data over time can differentiate the activities well.

![](https://github.com/yaswhar/WalkRunHat/blob/main/images/signals-walking.jpg)

Sample z-axis acceleration data collected for walking and running is provided in the `data` folder in CSV format. 

## Software

The Arduino code in the `arduino` folder reads the MPU-6050 z-axis acceleration value and logs it to the SD card.  

The MATLAB code in the `matlab` folder loads the recorded acceleration data and trains a logistic regression classifier to recognize the activities. The trained classifier model is saved to disk.

![](https://github.com/yaswhar/WalkRunHat/blob/main/images/after_regression.jpg)

The test cases in the `test` folder contain sample z-axis acceleration data for testing the classifier.
