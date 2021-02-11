#ifndef ANONIMIZE_HPP
#define ANONIMIZE_HPP

#include <opencv2/core.hpp>

#include "SimplexNoise.h"

// TODO: Camera difference calibration

int digitizeFrame(cv::Mat &frame, uint frame_width, uint frame_height, cv::Vec2d humanRange, int ambientTemperature);

int exposeFrame(cv::Mat &frame, uint frame_width, uint frame_height, float exposureAmount);

int noiseFrame(cv::Mat &frame, uint frame_width, uint frame_height, float strength);

void anonimize_frame(int COLOR_MODES);
    // Ambient temp, body part temperatures

    // Specify 2d array length
//Frame digitize(int[][x] temperatures, int sensitivity, Frame frame);
//Frame noise(enum algorithm, uint64_t intensity, Frame frame);
//Frame exposure(int exposureAmount, Frame frame, bool fuse);

#endif
