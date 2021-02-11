#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <fstream>  // File IO
#include <filesystem>   // List DIRS

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>  // Display images

#include "pose.hpp"

using namespace std;

//TODO use JSON parser
//#include <google/protobuf/util/json_util.h>
//using namespace google::protobuf::util;

vector<personMeasurement> dataTruth, dataModified;

std::vector <std::string> listDirectory(string directoryPath) {
    std::vector <std::string> fileNames;

    for (const auto & file: std::filesystem::directory_iterator(directoryPath)) {
        fileNames.push_back(file.path());
    }

    sort(fileNames.begin(), fileNames.end());

    return fileNames;
}

// TODO Multiperson support
int parseJSON(char* directory, vector<personMeasurement> &dataOut) {
    string json;

    vector<string> files = listDirectory(directory);

    // Loop through files in DIR
    for (const auto & file : files) {
        ifstream jsonData(file);
        // One line per person
        getline(jsonData, json);

        // Parse line
        dataOut.push_back(parsePerson(json));

//        printMeasurement(dataOut.back());
    }

    return 0;
}

void calculateALL() {
    int missingTruth = 0,
        missingModified = 0,
        totalMissingTruth= 0,
        totalMissingModified = 0;

    float truthConfidence = 0,
          modifiedConfidence = 0,
          differenceX = 0,
          differenceY = 0;
    float totalTruthConfidence = 0,
          totalModifiedConfidence = 0,
          totalDifferenceX = 0,
          totalDifferenceY = 0;
    cout << "Set:\t\t Part:\t\tMissing:\tConfidence:\t\tDifference X:\t\tDifference Y:" << endl;

    //Body
    for (int i = 0; i < dataTruth.size(); i++) {
        if (dataTruth[i].id == -2 || dataModified[i].id == -2) {
//            cout << "meeting missend" << endl;
        } else {
            calculatePartAverages(bodyCount, dataTruth[i].body, dataModified[i].body, &truthConfidence, &modifiedConfidence, &differenceX, &differenceY, &missingTruth, &missingModified);
            totalTruthConfidence += truthConfidence;
            totalModifiedConfidence += modifiedConfidence;

            totalMissingTruth += missingTruth;
            totalMissingModified += missingModified;

            totalDifferenceX += differenceX;
            totalDifferenceY += differenceY;
        }
    }
    truthConfidence = totalTruthConfidence/(dataTruth.size() - totalMissingTruth);
    differenceX = totalDifferenceX/(dataTruth.size() - totalMissingTruth);
    differenceY = totalDifferenceY/(dataTruth.size() - totalMissingTruth);
    cout << "Truth\t\t Body\t\t" << totalMissingTruth << "\t\t" << truthConfidence << "\t\t" << differenceX << "\t\t" << differenceY << endl;
    cout << " Modified\t Body\t\t" << totalMissingModified << "\t\t" << modifiedConfidence << "\t\t" << "\"" << "\t\t" << "\""<< endl;

    //Face
    totalTruthConfidence = 0;
    totalModifiedConfidence = 0;
    totalDifferenceX = 0;
    totalDifferenceY = 0;
    totalMissingTruth= 0;
    totalMissingModified = 0;
    for (int i = 0; i < dataTruth.size(); i++) {
        if (dataTruth[i].id == -2 || dataModified[i].id == -2) {
//            cout << "meeting missend" << endl;
        } else {
            calculatePartAverages(faceCount, dataTruth[i].face, dataModified[i].face, &truthConfidence, &modifiedConfidence, &differenceX, &differenceY, &missingTruth, &missingModified);
            totalTruthConfidence += truthConfidence;
            totalModifiedConfidence += modifiedConfidence;

            totalMissingTruth += missingTruth;
            totalMissingModified += missingModified;

            totalDifferenceX += differenceX;
            totalDifferenceY += differenceY;
        }
    }
    truthConfidence = totalTruthConfidence/(dataTruth.size() - totalMissingTruth);
    differenceX = totalDifferenceX/(dataTruth.size() - totalMissingTruth);
    differenceY = totalDifferenceY/(dataTruth.size() - totalMissingTruth);
    cout << "Truth\t\t Face\t\t" << totalMissingTruth << "\t\t" << truthConfidence << "\t\t" << differenceX << "\t\t" << differenceY << endl;
    cout << " Modified\t Face\t\t" << totalMissingModified << "\t\t" << modifiedConfidence << "\t\t" << "\"" << "\t\t" << "\""<< endl;

    //Left Hand
    totalTruthConfidence = 0;
    totalModifiedConfidence = 0;
    totalDifferenceX = 0;
    totalDifferenceY = 0;
    totalMissingTruth= 0;
    totalMissingModified = 0;
    for (int i = 0; i < dataTruth.size(); i++) {
        if (dataTruth[i].id == -2 || dataModified[i].id == -2) {
//            cout << "meeting missend" << endl;
        } else {
            calculatePartAverages(handCount, dataTruth[i].leftHand, dataModified[i].leftHand, &truthConfidence, &modifiedConfidence, &differenceX, &differenceY, &missingTruth, &missingModified);
            totalTruthConfidence += truthConfidence;
            totalModifiedConfidence += modifiedConfidence;

            totalMissingTruth += missingTruth;
            totalMissingModified += missingModified;

            totalDifferenceX += differenceX;
            totalDifferenceY += differenceY;
        }
    }
    truthConfidence = totalTruthConfidence/(dataTruth.size() - totalMissingTruth);
    differenceX = totalDifferenceX/(dataTruth.size() - totalMissingTruth);
    differenceY = totalDifferenceY/(dataTruth.size() - totalMissingTruth);
    cout << "Truth\t\t Left Hand\t" << totalMissingTruth << "\t\t" << truthConfidence << "\t\t" << differenceX << "\t\t" << differenceY << endl;
    cout << " Modified\t Left Hand\t" << totalMissingModified << "\t\t" << modifiedConfidence << "\t\t" << "\"" << "\t\t" << "\""<< endl;

    //Right Hand
    totalTruthConfidence = 0;
    totalModifiedConfidence = 0;
    totalDifferenceX = 0;
    totalDifferenceY = 0;
    totalMissingTruth= 0;
    totalMissingModified = 0;
    for (int i = 0; i < dataTruth.size(); i++) {
        if (dataTruth[i].id == -2 || dataModified[i].id == -2) {
//            cout << "meeting missend" << endl;
        } else {
            calculatePartAverages(handCount, dataTruth[i].rightHand, dataModified[i].rightHand, &truthConfidence, &modifiedConfidence, &differenceX, &differenceY, &missingTruth, &missingModified);
            totalTruthConfidence += truthConfidence;
            totalModifiedConfidence += modifiedConfidence;

            totalMissingTruth += missingTruth;
            totalMissingModified += missingModified;

            totalDifferenceX += differenceX;
            totalDifferenceY += differenceY;
        }
    }
    truthConfidence = totalTruthConfidence/(dataTruth.size() - totalMissingTruth);
    differenceX = totalDifferenceX/(dataTruth.size() - totalMissingTruth);
    differenceY = totalDifferenceY/(dataTruth.size() - totalMissingTruth);
    cout << "Truth\t\t Right Hand\t" << totalMissingTruth << "\t\t" << truthConfidence << "\t\t" << differenceX << "\t\t" << differenceY << endl;
    cout << " Modified\t Right Hand\t" << totalMissingModified << "\t\t" << modifiedConfidence << "\t\t" << "\"" << "\t\t" << "\""<< endl;
}

int main(int argc, char *argv[]) {
    std::cout << std::fixed <<std::setprecision(8) << std::endl;

    if (argc < 3 || argv == nullptr) {
        std::cout << "Usage: " << argv[0] << " <poseDIR> <poseDIR2>" << endl;
        return EXIT_FAILURE;
    }

    //TODO rm comment
    //Parse Truth
    parseJSON(argv[1], dataTruth);
    //Parse Anon
    parseJSON(argv[2], dataModified);

    if (dataTruth.size() != dataModified.size()) {
        std::cerr << "Error: Ongelijk aantal meetingen! (" << dataTruth.size() << " - " << dataModified.size() << ")" << std::endl;
        return EXIT_FAILURE;
    }
    
    calculateALL();

    return EXIT_SUCCESS;
}

// TODO:
// - Persoon onderscheid? => Afstand/verplaatsing, afstand tussen punten
