#include <stdexcept>
#include <iostream>
#include <stdio.h>
#include <string.h>

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>  // Display images

#include "anonimize.hpp"

using namespace std;

cv::Mat frame;
// Initialize videocapture
cv::VideoCapture cap;
int apiID = cv::CAP_ANY;      // 0 = autodetect default API

// Variables
    // Video Properties
string writePath = "";
string readPath;
int frame_width;
int frame_height;
    // Video writer
uint codec = cv::VideoWriter::fourcc('M', 'J', 'P', 'G');
uint fps = 30;
cv::VideoWriter video;
    // Options
int display = 0;
bool exposureEnabled = 0,
        digitizationEnabled = 0,
        noiseEnabled = 0;
float exposureAmount = 0,
        noiseStrength = 0;

int parseInput(int argc, char *argv[]) {
    int argumentCount[] = { 1, 1, 1, 1, 1, 2, 1};
    std::string options[][2] = { 
        // [x][0] Option        [x][1] Possible value(s)
        {" --color",            "human color range [from-to] RGBRGB (0-255)"}, 
        {" --ambient-temp",     " "},
        {" --display",          "0: no display, 1: display anonimisation frame"},
        {" --video-out",        "Filename output"},

        {" --exposure",         "float [0-255]"},
        {" --digitization",     "rgb start, rgb end"},
        {" --noise",            "float [0-255]"},
    };
    int optionCount = sizeof(options)/sizeof(std::string)/2;
    if (argc < 2 || argv == nullptr) {
        std::cout << "Usage: " << argv[0] << " <video>" << endl;

        std::cout << "\t Optional flags:" << endl;
        for (int i = 0; i < optionCount; i++) {
            std::cout << "\t\t" << options[i][0] << "\t\t" << options[i][1] << std::endl;
        }
        return -1;
    }
    
    // Search through arguments
    for (int i = 2; i < argc; i++) {    // arguments, skip argv[0]
        bool match = false;
        int optionIndex = 0;

        do { // Detect option
            if (strstr(options[optionIndex][0].c_str(), argv[i])) {
                match = true;
            }
            optionIndex++;
        } while (!match && optionCount - 1 >= optionIndex);
        
        if (!match) {
            std::cout << "ERROR: Failed to parse: " << argv[i] << endl;
            return -1;
        } else {
            cout << "Detected settings: " << options[optionIndex-1][0] << " ";
            cout << " = ";
            for (int c = 0; c < argumentCount[optionIndex-1]; c++) {
                cout << argv[i+c+1];
                if (argumentCount[optionIndex-1] > 1) {
                    cout << ", ";
                }
            }
            cout << endl;

            switch (optionIndex) {
                case 1 : {  break; }
                case 2 : {  break; }
                case 3 : { display = stoi(argv[i+1]); break; };
                case 4 : { /* Video Out */
                    writePath = argv[i+1]; 
                    break;
                }
                case 5 : { 
                    exposureEnabled = 1; 
                    exposureAmount = std::stof(argv[i+1]);
                    break; 
                };
                case 6 : { digitizationEnabled = 1; break; };
                case 7 : { 
                    noiseEnabled = 1; 
                    noiseStrength = stof(argv[i+1]);
                    break; 
                };
            }
            i += argumentCount[optionIndex-1]; // Skip saved flag values
        }
    }
    return 0;
}

//### Color help
// TODO Add struct colorspace?
int colorToTemp(cv::Vec3b color, int colorSpace) { 
    // Map value to temp
    return -1;
}
 
//### Write ###############################################################################
// Width/Height = 0 || null; Original output size
int initializeVideoWriter(string& fileName, uint videoWidth, uint videoHeight) {
    video = cv::VideoWriter(fileName, codec, fps, cv::Size(videoWidth, videoHeight));

    return 0;
}

//### Video in ###############################################################################
int openVideo(char* file) {
// Open video 
    // open file using selected API
//const string path = file;
    cap.open(file, apiID);
    // check if we succeeded
    if (!cap.isOpened()) {
        std::cerr << "ERROR! Unable to open video\n";
        return -1;
    }

    frame_width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    frame_height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);

    return 0;
}

//### Anonimize ###############################################################################
int anonimizeVideo() {
    //Open video
    //Loop through frames
    //Call anonimisation functions
// Extract frame

//TODO move to header
// Anonimize frame 
    // Exposure: 
        // Over/Under: px=px*(2^exp)
        // Fusion: subtract? multiply? add?
    // Digitisation
        // Read outside temperature
        // px > outside temp?
    // Noise
        // Diff algorithms
 
    return 0;
}

int anonimizeImages() {
    return 0;
}

int grabFrame() {
    // wait for a new frame from src and store it into 'frame'
    cap.read(frame);

    if (frame.empty()) {    // check if we succeeded
        cerr << "ERROR! blank frame grabbed\n";
        std::cout << "Done! (probably)" << endl;
        return -1;
    }
    return 0;
}

void die() {
    cap.release();
    cv::destroyAllWindows();
}

int main(int argc, char *argv[]) {
    if (parseInput(argc, argv)) { return EXIT_FAILURE; }; // Parse input options

    if (openVideo(argv[1])) { return EXIT_FAILURE; }

    // Setup video output if enabled
    if (!writePath.empty()) { initializeVideoWriter(writePath, frame_width, frame_height); }

    // Frame grab and write loop
    if (display) {
        cout << "Start grabbing" << endl
            << "Press ESC key to terminate" << endl;
    }

    for (;;)
    {
        if (grabFrame()) { break; } // Empty frame grabbed, video done

        // Anonimisation
        // TODO Customizable order
        if (digitizationEnabled) { digitizeFrame(frame, frame_width, frame_height, cv::Vec2d(0.5, 0.1), 21); };
        if (exposureEnabled) { exposeFrame(frame, frame_width, frame_height, exposureAmount); };
        if (noiseEnabled) { noiseFrame(frame, frame_width, frame_height, noiseStrength); };
 
        // Display frame
        if (display) { 
            cv::imshow("Live", frame); 

            // User input
            char pressed = (char)cv::waitKey(fps);
            if (pressed == 27) { break; } // Check ESC char
        } 
 
        // Write current frame
        if (!writePath.empty()) { video.write(frame); }
    }
   
    die();
    return EXIT_SUCCESS;
}
