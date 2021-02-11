//Based on:     https://blog.mbedded.ninja/programming/operating-systems/linux/linux-serial-ports-using-c-cpp/

#include <stdio.h>
#include <string>
#include <iostream>

#include <unistd.h>     // write, read, close
#include <fcntl.h>      // file controls
#include <errno.h>      // error functions
#include <termios.h>    // POSIX terminal control

#include <cstring>

int main(int argc, char* argv[]) {
    std::string port = "/dev/ttyACM0";
    int device = open(port.c_str(), O_RDWR | O_NOCTTY | O_SYNC);

    if (device < 0) {
        std::cout << "No device found on port: " << port << std::endl;
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
        std::cout << "Error" << errno << "from tcsetattr:" << strerror(errno) << std::endl;
    }

    char buffer[1024];

    //Synchronize
    /*
    do {
        int n = read(device, buffer, sizeof buffer);
        std::cout << "nop" << std::endl;
    } while (buffer[0] != '[');
    //TODO: read between '[' and ']'
    */
    int i = 0;
    // TODO: Double readout issue
    while (1) {
        int n = read(device, buffer, sizeof buffer);   // n=#bytes read, negative => error
        if (buffer[0] == '[') {
            std::cout << buffer << std::endl;
        }
        std::cout << i << std::endl;
        i++;
    }

    close(device);
}
