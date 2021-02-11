#include "pose.hpp"

#include <cmath>
#include <iostream>
#include <sstream>
#include <iomanip>

struct personMeasurement;

float scientificToFloat(std::string& value) {
    std::stringstream ss(value);
    float conv = 0;
    ss >> conv;
    return conv;
}

int extractValues(cv::Vec3f dataOut[], int dataCount, std::string &data) {
    std::stringstream parse(data);
    std::string buffer;

    // Loop through delimited values
    for (int i = 0; i < dataCount; i++) {
        getline(parse, buffer, ',');
        dataOut[i][0] = scientificToFloat(buffer);
        getline(parse, buffer, ',');
        dataOut[i][1] = scientificToFloat(buffer);
        getline(parse, buffer, ',');
        dataOut[i][2] = scientificToFloat(buffer);
    }

    return 0;
}

// Set id = -2 if no person in frame found
personMeasurement parsePerson(std::string &jsonData) {
    personMeasurement pm;

    if (jsonData.length() < 30) { // Check if person has been detected
        pm.id = -2;
        return pm;
    }

    std::stringstream parse(jsonData);

    std::string buffer;
    
    // Ignore first two lines
    getline(parse, buffer, '[');
    getline(parse, buffer, '[');
    // Parse ID
    getline(parse, buffer, '[');
    pm.id = stoi(buffer.substr(0, buffer.find(']')));
    // Parse Pose values
    getline(parse, buffer, '[');
    std::string onlyData = buffer.substr(0, buffer.find(']'));
    extractValues(pm.body, bodyCount, onlyData);
    // Parse Face
    getline(parse, buffer, '[');
    onlyData = buffer.substr(0, buffer.find(']'));
    extractValues(pm.face, faceCount, onlyData);
    // Parse Left Hand
    getline(parse, buffer, '[');
    onlyData = buffer.substr(0, buffer.find(']'));
    extractValues(pm.leftHand, handCount, onlyData);
    // Parse Right Hand
    getline(parse, buffer, '[');
    onlyData = buffer.substr(0, buffer.find(']'));
    extractValues(pm.rightHand, handCount, onlyData);
    
    return pm;
}

void printMeasurement(personMeasurement pm) {
    std::cout << "Person ID: " << pm.id << std::endl;

    if (pm.id == -2) { return; }

    std::cout << "\t" << "Body:" << std::endl;
    for (auto &vec : pm.body) {
        std::cout << "\t\t" << vec << std::endl;
    }

    std::cout << "\t" << "Face:" << std::endl;
    for (auto &vec : pm.face) {
        std::cout << "\t\t" << vec << std::endl;
    }

    std::cout << "\t" << "Left Hand:" << std::endl;
    for (auto &vec : pm.leftHand) {
        std::cout << "\t\t" << vec << std::endl;
    }

    std::cout << "\t" << "Right Hand:" << std::endl;
    for (auto &vec : pm.rightHand) {
        std::cout << "\t\t" << vec << std::endl;
    }
}

int calculateAVG(int measurementCount, cv::Vec3f truth[], int *missingTruth, cv::Vec3f modified[], int *missingModified) { 
    if (missingTruth == nullptr || missingModified == nullptr) {
        return -1; 
    }
    
    float difference = 0;
    for (int i = 0; i < measurementCount; i++) {
        if (truth[i][0] == 0 && truth[i][1] == 0 && truth[i][2] == 0) {
            *missingTruth += 1;
        } else if (modified[i][0] == 0 && modified[i][1] == 0 && modified[i][2] == 0) {
            *missingModified += 1;
        } else {
            difference += truth[i][0] - modified[i][0];
        }
    }

    return 0;
}

int checkMeasurementFailed(cv::Vec3f &measurement) {
    if (measurement[0] == 0.0f && measurement[1] == 0.0f && measurement[2] == 0.0f) {
        return -1;
    }
    return 0;
}

// Calulate difference in position between two bodyparts
int calculatePartDeviation(cv::Vec3f &truth, cv::Vec3f &modified) {
    // check failed
    if (!checkMeasurementFailed(truth) && !checkMeasurementFailed(modified)) { return -1; }

    // x-x' + y-y'
    float deviation = truth[0] - modified[0];
    deviation += truth[1] - modified[1];

    return 0;
}

// Calculate AVG: difference(X,Y) and confidence
int calculatePartAverages(int measurementCount, cv::Vec3f *truth, cv::Vec3f *modified, float *truthConfidence, float *modifiedConfidence, float *differenceX, float *differenceY, int *missingTruth, int *missingModified) {
    if (truthConfidence == nullptr || modifiedConfidence == nullptr || differenceX == nullptr || differenceY == nullptr || missingTruth == nullptr || missingModified == nullptr) { return -1; }

    bool truthFailed = true;
    bool modifiedFailed = true;

    *truthConfidence = 0;
    *modifiedConfidence = 0;
    *missingTruth = 0;
    *missingModified = 0;

    for (int i = 0; i < measurementCount; i++) {
        truthFailed = checkMeasurementFailed(truth[i]);
        modifiedFailed = checkMeasurementFailed(modified[i]);

        // Calculate confidence
        if (!truthFailed) {
            *truthConfidence += truth[i][2];
        } else { *missingTruth += 1; }
        if (!modifiedFailed) {
            *modifiedConfidence += modified[i][2];
        } else { *missingModified += 1; }

        // Calculate difference X & Y
        if (!truthFailed && !modifiedFailed) {

            *differenceX += truth[i][0] - modified[i][0];
            *differenceY += truth[i][1] - modified[i][1];
        }
    }
    

    // Calculate Averages
    // Confidence
    *truthConfidence = *truthConfidence/(measurementCount - *missingTruth);
    *modifiedConfidence = *modifiedConfidence/(measurementCount - *missingModified);
    // Position
    int missing = 0;
        // Only complete measurements were included in sum, therefore use the lowest missing number when calculating average 
    if (*missingTruth < *missingModified) { 
        missing = *missingTruth; 
    } else { 
        missing = *missingModified; 
    }
    *differenceX = *differenceX/(measurementCount - missing);
    *differenceY = *differenceY/(measurementCount - missing);

    return 0;
}

int calculateAverages() {
    float missingTruthParts = 0;
    return missingTruthParts;
}

int calculateBodyConfidence(std::vector<personMeasurement> &pm, float *confidence, int *missing) {
    if (missing == nullptr || confidence == nullptr) { return -1; }
    *missing = 0;
    *confidence = 0;

    for (int m  = 0; m < pm.size(); m++) {
        for (int k = 0; k < bodyCount; k++) {
            // Check if missing
            if (!checkMeasurementFailed(pm[m].body[k])) {
                *confidence += pm[m].body[k][2];
            } else {
                *missing += 1;
            }
        }
    }
    *confidence = *confidence/(pm.size() * bodyCount - *missing);
    return 0;
}

/*
int calculateDifference(int measurementCount, std::vector<personMeasurement> thruth, std::vector<personMeasurement> modified, int *missing, float *poseConfidence, float *faceConfidence, float* leftHandConfidence, float* rightHandConfidence) { 
    if (missing == nullptr || poseConfidence == nullptr || faceConfidence == nullptr || leftHandConfidence == nullptr || rightHandConfidence == nullptr) {
        return -1; 
    }
    
    *poseConfidence = 0;
    *faceConfidence = 0;
    *leftHandConfidence = 0;
    *rightHandConfidence = 0;
    *missing = 0;

    for (int i = 0; i < measurementCount; i++) {
        for ()
        if (measurements[i].body[0][0] == 0 && measurements.body[i][1] == 0 && measurements->body[i][2] == 0) {
            *missing += 1;
        } else {
            *poseConfidence += measurements->body[i][2];
        }
    }
    *poseConfidence = *poseConfidence/measurementCount;

    // for measurementCount
        // for Body
            // confidence
            // xThruth - xMod
            // yTruth - yMod
        // for Face
            // confidence
            // x
            // y
        // for L Hand
            // confidence
            // x
            // y
        // for R Hand
            // confidence
            // x
            // y

    return 0; 
}

int calculateSpeed() { return -1; }
*/
