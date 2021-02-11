#include "anonimize.hpp"
//
// Color palette used in thermal video

enum COLOR_MODES {
    GRAYSCALE,
    COLOR
} color_modes;

// TODO get float values
// TODO Transferfunction/Interpolation (>#32 degrees C in array)
float bodyPartTemperatures[32][2] = {{ 34, 35}, {1, 2}, {3, 4}};

int digitizeFrame(cv::Mat &frame, uint frame_width, uint frame_height, cv::Vec2d humanRange, int ambientTemperature) {
    if (frame.empty()) {    // Check if frame is empty
        return -1;
    }

    // Find correct temperature
    for (int i = 0; i < 32; i++) {
        
    }

    cv::Vec3b pixelColor;   // Colors are stored in the format BGR 
    for (uint x = 0; x < frame_width; x++) {
        for (uint y = 0; y < frame_height; y++) {
            pixelColor = frame.at<cv::Vec3b>(cv::Point(x,y));
            // TODO convert between R255 G255 B255 to R9 G9 B9
                // => map?
                // TODO un-hardcode
if ((pixelColor[0] >= 100 && pixelColor[1] >= 100 && pixelColor[2] >= 100) /* White */
                    || (pixelColor[0] <= 50 && pixelColor[1] <= 150 && pixelColor[2] >= 0)) /* Red */ {
//            if ((pixelColor[0] >= humanRange[0] && pixelColor[1] >= humanRange[0] && pixelColor[2] >= 100) /* White */
//                    || (pixelColor[0] <= 50 && pixelColor[1] <= 150 && pixelColor[2] >= 0)) /* Red */ {
                pixelColor[0] = 0; //255-pixelColor[0];
                pixelColor[1] = 0; //255-pixelColor[1];
                pixelColor[2] = 0; //255-pixelColor[2];
                frame.at<cv::Vec3b>(cv::Point(x,y)) = pixelColor;
            }
        }
    }
    return 0;
}

// TODO Fusion
int exposeFrame(cv::Mat &frame, uint frame_width, uint frame_height, float exposureAmount) {
    if (frame.empty()) {    // Check if frame is empty
        return -1;
    }

    cv::Vec3b pixelColor;   // Colors are stored in the format BGR 
    for (uint x = 0; x < frame_width; x++) {
        for (uint y = 0; y < frame_height; y++) {
            pixelColor = frame.at<cv::Vec3b>(cv::Point(x,y));
            pixelColor[0] = pixelColor[0]*(pow(2, exposureAmount));
            pixelColor[1] = pixelColor[1]*(pow(2, exposureAmount));
            pixelColor[2] = pixelColor[2]*(pow(2, exposureAmount));
            frame.at<cv::Vec3b>(cv::Point(x,y)) = pixelColor;
        }
    }
    return 0;
}

int noiseFrame(cv::Mat &frame, uint frame_width, uint frame_height, float strength) {
    if (frame.empty()) {    // Check if frame is empty
        return -1;
    }

    cv::Vec3b pixelColor;   // Colors are stored in the format BGR 
    for (uint x = 0; x < frame_width; x++) {
        for (uint y = 0; y < frame_height; y++) {
            pixelColor = frame.at<cv::Vec3b>(cv::Point(x,y));
            pixelColor[0] += strength * SimplexNoise::noise(0.01f + pixelColor[0]);
            pixelColor[1] += strength * SimplexNoise::noise(0.02f + pixelColor[1]);
            pixelColor[2] += strength * SimplexNoise::noise(0.03f + pixelColor[2]);
            frame.at<cv::Vec3b>(cv::Point(x,y)) = pixelColor;
        }
    }

    return 0;
}
