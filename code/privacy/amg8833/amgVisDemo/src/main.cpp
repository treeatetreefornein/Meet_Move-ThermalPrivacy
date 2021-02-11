// Get the Arduino code at:  https://github.com/adafruit/Adafruit_AMG88xx

#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

#include <iostream>
#include <stdio.h>
#include <stdlib.h>     // atio

// Read TTY
#include <string>
#include <cstring>
#include <unistd.h>     // write, read, close
#include <fcntl.h>      // file controls
#include <errno.h>      // error functions
#include <termios.h>    // POSIX terminal control

using namespace cv;
using namespace std;

int TTYInit() {
    return 1;
}

int main(int, char**)
{
    const int width = 8, 
                height = 8,
                videoWidth = 800,
                videoHeight = 800,
                frameCount = 300;
    //VideoWriter video("output.avi", VideoWriter::fourcc('M', 'J', 'P', 'G'),30,Size(videoWidth, videoHeight));

// Read TTY setup
// TODO: Windows Compatibel

// Prepare reading tty port
    std::string port = "/dev/ttyACM0";
    int device = open(port.c_str(), O_RDWR | O_NOCTTY | O_SYNC);

    // TODO add test data mode
    if (device < 0) {
        std::cout << "No device found/No permission on port: " << port << std::endl;
        exit(1);
    }

    // Create termios struct to configure port
    struct termios tty;
    if (tcgetattr(device, &tty) != 0) {
        std::cout << "Error" << errno << "from tcgetattr:" << strerror(errno) << std::endl;
    }
    // termios Settings         (Most common settings:)
    tty.c_cflag &= ~PARENB;     // Clear parity bit
    tty.c_cflag &= ~CSTOPB;     // Clear stop bit
    tty.c_cflag &= ~CSIZE;      // Clear these bytes before setting bits/byte
    tty.c_cflag |= CS8;         // 8 bits/byte
    tty.c_cflag &= ~CRTSCTS;    // Disable RTS/CTS hardware flow control
    tty.c_cflag |= CREAD | CLOCAL;    // Turn on READ & ignore ctrl
    tty.c_cflag &= ~ICANON;     // Disable Canonical mode: do not process only when newline received
    tty.c_cflag &= ~ECHO;       // Disable echo
    tty.c_cflag &= ~ECHOE;      // Disable erasure
    tty.c_cflag &= ~ECHONL;     // Disable new-line echo
    tty.c_cflag &= ~ISIG;       // Do not interpret INTR, QUIT & SUSP
    tty.c_cflag &= ~(IXON | IXOFF | IXANY);     // Turn off SW flow control
    //tty.c_cflag &= ~(IGNBRK|BRKINT|PARMRK|ISTRIP|INLCR|IGNCR|ICRNL);     // Raw data, no processing
    //tty.c_cflag &= ~OPOST;       // No special interpretation of output bytes
    tty.c_cflag &= ~ONLCR;       // No conversion of newline to carriage return/line feed

    // Reading all data not possible (255)
    tty.c_cc[VTIME] = 10;    // Wait for up to 1s (10 deciseconds), returning as soon as any data is received.
tty.c_cc[VMIN] = 0;

    tcflush(device, TCIFLUSH);  // Flush Rx data in buffer

    cfsetispeed(&tty, B9600);   // B0,  B50,  B75,  B110,  B134,  B150,  B200, B300, B600, B1200, B1800, B2400, B4800, B9600, B19200, B38400, B57600, B115200, B230400, B460800

    // Save configuration
    if (tcsetattr(device, TCSANOW, &tty) != 0) {
        std::cout << "Error" << errno << "from tcsetattr:" << strerror(errno) << " While configuring TTY settings" << std::endl;
    }

    char buffer[1024] = { '[', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ' ', '-', '0', '.', '2', '5', ']' };

    // TODO: Double readout issue
    while (1) {
        // Read data
        int n = read(device, buffer, sizeof buffer);   // n=#bytes read, negative => error

        if (buffer[0] == '[') {     // Only parse at start of data set (exclude false symbols)
                int j = 0;
    uint8_t data[64] = {};
            for (int i = 0; i < sizeof(data); i++){
                string digit = "";
                while (buffer[j] != ' ') {
                    digit += buffer[j];
                    j++;
                }
                j++;
                float mappedDigit = atof(digit.c_str());

///* Debug */   std::cout << mappedDigit << std::endl; 
                            // intdigit - -20
// Total Range                //mappedDigit = (mappedDigit+20)/(125+20) * (255-0) + 0;
                mappedDigit = (mappedDigit-16)/(28-16) * (255-0) + 0;
                data[i] = mappedDigit;
/* Debug */     std::cout << "[" << digit << " " << (int)data[i] << "] ";
                bool nap = false;
                if (i%8 == 0) { std::cout << std::endl; }
            }
            
            // Copy data into frame buffer
            //std::copy(buffer + 1, buffer + 63, data);

            std::cout << std::endl << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << std::endl;
            std::cout << std::endl << data << std::endl;
            std::cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << std::endl << std::endl;

            // Generate image display
            Mat frame(8,8,CV_8UC1, data); // Unsigned 8bit 1 Channel
            cv::flip(frame, frame, 1); // Flip horizontaal

            // Write frame
            Mat finalFrame;
            cvtColor(frame, finalFrame, COLOR_GRAY2BGR);
            resize(finalFrame, finalFrame, Size(videoWidth, videoHeight));  // Resize for display
//      video.write(finalFrame);

            waitKey(100); // ms
            imshow("Frame Output", finalFrame); // Display frame
        } 
    }

    close(device);
    destroyAllWindows();

    return 0;
}
