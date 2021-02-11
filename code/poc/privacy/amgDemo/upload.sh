#!/bin/sh
port=ttyACM0

sudo chown $(whoami) "/dev/$port"
arduino-cli upload amgDemo.ino -b arduino:avr:uno -p "/dev/$port"
