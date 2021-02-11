/*
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
*/

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
#include <stdio.h>

#include "anonimisation.hpp"

using namespace cv;
using namespace std;

int main(int argc, char *argv[])
{
    if (argc < 2) {
        cout << "Usage:" << argv[0] << " <video> <color-from> <color-to>" << endl;
    }

    Mat frame;
    // Initialize videocapture
    VideoCapture cap;
    int apiID = cv::CAP_ANY;      // 0 = autodetect default API
    // open file using selected API
    const string path = argv[1];
    cap.open(path, apiID);
    // check if we succeeded
    if (!cap.isOpened()) {
        cerr << "ERROR! Unable to open file\n";
        return -1;
    }

    int frame_width = cap.get(CAP_PROP_FRAME_WIDTH);
    int frame_height = cap.get(CAP_PROP_FRAME_HEIGHT);
    // Create video writer
    //VideoWriter video("output.avi", VideoWriter::fourcc('M', 'J', 'P', 'G'),24,Size(frame_width,frame_height));

    // Frame grab and write loop
    cout << "Start grabbing" << endl
        << "Press any key to terminate" << endl;
    for (;;)
    {
        // wait for a new frame from camera and store it into 'frame'
        cap.read(frame);
        // check if we succeeded
        if (frame.empty()) {
            cerr << "ERROR! blank frame grabbed\n";
            break;
        }
        // BGR
        for (int x = 0; x < frame_width; x++) {
            for (int y = 0; y < frame_height; y++) {
                cv::Vec3b color = frame.at<Vec3b>(Point(x,y));
                if ((color[0] >= 100 && color[1] >= 100 && color[2] >= 100) /* White */
                        || (color[0] <= 50 && color[1] <= 150 && color[2] >= 0)) /* Red */ {
                color[0] = 0; //255-color[0];
                color[1] = 0; //255-color[1];
                color[2] = 0; //255-color[2];
                frame.at<Vec3b>(Point(x,y)) = color;
                }
            }
        }
        // show live and wait for a key with timeout long enough to show images
        imshow("Live", frame); // Display frame
        //video.write(frame); // Write frame

        char pressed = (char)waitKey(20);
        if (pressed == 27) { break; } // Check ESC char
    }
    cap.release();

    destroyAllWindows();
    
    return 0;
}
