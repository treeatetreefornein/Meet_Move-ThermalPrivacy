#ifndef ANONIMISERING_HPP
#define ANONIMISERING_HPP

#include <opencv2/core.hpp>

//###########################################
//#  MCU
//###########################################

// Fetch MCU array (uint8_t)

// Convert array to MAT
cv::Mat frameFromArray(*uint8_t array, int width, int height, auto color);

//###########################################
//#  Vid/Camera
//###########################################

// -

//###########################################
//#  Anonimisation
//###########################################

// Loop through Mat

// Fetch settings anonimisation method

// Execute 3x methods => no switch
anonimise(function** methods?/ int methods);

//### Digitization
digitize(int ambientTemp, Mat frame)

//### Exposure
//                      Over/Under/Fuse/Other Exposure algorithm
digitize(int intensity, int exposureMethod, Mat frame)

//### Noise
digitize(int intensity, int noiseMethod, Mat frame)

#endif
