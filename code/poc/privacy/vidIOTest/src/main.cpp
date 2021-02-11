#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
#include <stdio.h>

using namespace cv;
using namespace std;

int main(int, char**)
{
    Mat frame;
    // Initialize videocapture
    VideoCapture cap;
    int apiID = cv::CAP_ANY;      // 0 = autodetect default API
    // open file using selected API
    const string path = "./watjongwebsite.mp4";
    cap.open(path, apiID);
    // check if we succeeded
    if (!cap.isOpened()) {
        cerr << "ERROR! Unable to open file\n";
        return -1;
    }

    int frame_width = cap.get(CAP_PROP_FRAME_WIDTH);
    int frame_height = cap.get(CAP_PROP_FRAME_HEIGHT);
    // Create video writer
    VideoWriter video("output.avi", VideoWriter::fourcc('M', 'J', 'P', 'G'),24,Size(frame_width,frame_height));

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
        for (int x = 0; x < frame_width; x++) {
            for (int y = 0; y < frame_height; y++) {
                cv::Vec3b color = frame.at<Vec3b>(Point(x,y));
                if (color[0] >= 100 && color[1] >= 200 && color[2] >= 200) {
                color[0] = 250; //255-color[0];
                color[1] = 0; //255-color[1];
                color[2] = 0; //255-color[2];
                frame.at<Vec3b>(Point(x,y)) = color;
                }
            }
        }
        // show live and wait for a key with timeout long enough to show images
        imshow("Live", frame); // Display frame
        video.write(frame); // Write frame

        char pressed = (char)waitKey(1);
        if (pressed == 27) { break; } // Check ESC char
    }
    cap.release();

    destroyAllWindows();
    
    return 0;
}
