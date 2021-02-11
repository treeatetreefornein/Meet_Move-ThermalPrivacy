#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>
#include <stdio.h>

using namespace cv;
using namespace std;

int main(int, char**)
{
    const int width = 8, 
                height = 8,
                videoWidth = 800,
                videoHeight = 800,
                frameCount = 300;
    //VideoWriter video("output.avi", VideoWriter::fourcc('M', 'J', 'P', 'G'),24,Size(100,100));
    VideoWriter video("output.avi", VideoWriter::fourcc('M', 'J', 'P', 'G'),30,Size(videoWidth, videoHeight));

    uint8_t frameSnapshot[64] = { //create Mat from array
        0,  0,  0,  0,  0,  0,  0,  0,
        0,  0,  255,  0,  0,  255,  0,  0,
        0,  0,  0,  0,  0,  0,  0,  0,
        0,  0,  0,  0,  0,  0,  0,  0,
        0,  255,  0,  0,  0,  0,  255,  0,
        0,  0,  255,  0,  0,  255,  0,  0,
        0,  0,  0,  255,  255,  0,  0,  0,
        0,  0,  0,  0,  0,  0,  0,  0
    };
    // row, column, CV_[#bits/item], signed/unsigned, type, C, channel number 
    //Mat frame(8,8,CV_8UC3, Scalar(0,0,0));
    Mat frame(8,8,CV_8UC1, frameSnapshot);
    cout << "Mat frame = " << endl << " " << frame << endl << endl;

    imshow("Initial Frame", frame); // Display frame
    waitKey(0);

    for (int i = 0; i < frameCount; i++) {     // 100 Frames
        if (i < frameCount/3) { // Do Nothing 
        } else {
            for (int x = 0; x < width; x++) {   // 8x8 px
                for (int y = 0; y < height; y++) {
                    cv::Vec3b color = frame.at<Vec3b>(Point(x,y));
                    if (x%2) {
                        color[0] = i+150;
                    } else if (y%5) {
                            color[0] = i+100;
                    } else {
                        color[0] = 0;
                    }
                    frame.at<Vec3b>(Point(x,y)) = color;
                }
            }
            if (frame.empty()) {
                cerr << "ERROR! blank frame grabbed\n";
                break;
            }
        }
        // Write frame
        Mat finalFrame;
        cvtColor(frame, finalFrame, COLOR_GRAY2BGR);
        resize(finalFrame, finalFrame, Size(videoWidth, videoHeight));
        video.write(finalFrame);

        waitKey(10);
        imshow("Frame Output", finalFrame); // Display frame
    }

    destroyAllWindows();

    return 0;
}
