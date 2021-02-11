#ifndef POSE_HPP
#define POSE_HPP

#include <opencv2/core.hpp>

// Number of coordinates for each output group (=DEFAULT Body_25 output)
const uint bodyCount = 25, 
            faceCount = 69, 
            handCount = 20;

// [X][Y][Confidence]
struct personMeasurement {
    int id = 0;
    cv::Vec3f body[bodyCount];
    cv::Vec3f face[faceCount];
    cv::Vec3f leftHand[handCount];
    cv::Vec3f rightHand[handCount];
};

personMeasurement parsePerson(std::string &jsonData);

void printMeasurement(personMeasurement pm);

int calculatePartAverages(int measurementCount, cv::Vec3f *truth, cv::Vec3f *modified, float *truthConfidence, float *modifiedConfidence, float *differenceX, float *differenceY, int *missingTruth, int *missingModified);

int calculateBodyConfidence(std::vector<personMeasurement> &pm, float *confidence, int *missing);

int calculateAVGConfidence(int measurementCount, std::vector<personMeasurement> measurements, int *missing, float *poseConfidence, float *faceConfidence, float* leftHandConfidence, float* rightHandConfidence);

#endif
