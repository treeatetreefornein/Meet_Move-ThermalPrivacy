#!/bin/sh

sudo chown $(whoami) /dev/ttyACM0
make
./ttyFetch
