#!/bin/sh

datasetPath=$HOME/bhdd/school/meetMove/repo/thermalDataset/     # This location will be used as 

# Select container and gui
gui=$(echo -e "GUI?: Y \nn" | dmenu -i -l 15)
if [ "$gui" = "n" ];
then
    gui=""
else
    #gui="-e DISPLAY -v /tmp/.X11-unix/X0"
    # TODO Restore xhost correct setting
    gui="-e DISPLAY -v $HOME/.Xauthority:/root/.Xauthority"
fi;

if [ -e "$gui" ]
then
    exit 1
fi

container=$(sudo docker image list | dmenu -l 15 | awk '{print $1}')

# Run container and share folder between device and docker container
# Uses default GPU & container is removed after running
sudo docker run -it --rm $gui -v "$datasetPath/:/var/log/openpose/" --gpus 0 $container

### For Thermal/FLIR Cameras: "--flir_camera"

# In container:
#   $./build/examples/openpose/openpose.bin --video /var/log/openpose/Waka\ Waka\ Biggest\ flashmob\ in\ the\ Netherlands-FFtzqqgE3kA.mp4 --net-resolution 256x160 --write-video /var/log/openpose/test.avi -display 0

# ./build/examples/openpose/openpose.bin --image-dir /var/log/openpose/FLIR/FLIR_ADAS_1_3/train/RGB/ --net-resolution 256x160 --write_json /var/log/openpose/out/json/ --write-images /var/log/openpose/out/image/ --display 0 -num_gpu -1
