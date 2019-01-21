#!/bin/bash

# Save current working directory
cwd=$(pwd)

apt -y update
apt -y upgrade

apt -y remove x264 libx264-dev

## Install dependencies
apt -y install build-essential checkinstall cmake pkg-config yasm
apt -y install git gfortran
apt -y install libjpeg8-dev libjasper-dev libpng12-dev
apt -y install libtiff5-dev
apt -y install libtiff-dev
apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
apt -y install libxine2-dev libv4l-dev libv4l-0
cd /usr/include/linux
ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd

apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
apt -y install libgtk2.0-dev libtbb-dev qt5-default
apt -y install libatlas-base-dev
apt -y install libfaac-dev libmp3lame-dev libtheora-dev
apt -y install libvorbis-dev libxvidcore-dev
apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
apt -y install libavresample-dev
apt -y install x264 v4l-utils
apt -y install v4l2ucp


# Optional dependencies
apt -y install libglu1-mesa-dev freeglut3-dev mesa-common-dev
apt -y install libgtkglext1 libgtkglext1-dev
apt -y install libprotobuf-dev protobuf-compiler
apt -y install libgoogle-glog-dev libgflags-dev
apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

apt -y install libblas-dev liblapack3 liblapack-dev

apt -y install python-dev python-pip python3-dev python3-pip
pip3 install -U pip numpy
apt -y install python3-testresources
 
# now install python libraries within this virtual environment
pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython


apt -y install gstreamer0.10-plugins-good gtk2.0 jasper libjpeg-turbo8-dev libtiff5 libwebp-dev v4l-utils xine-ui zip unzip gstreamer1.0-tools linux-headers-$(uname -r) 

export OPENCV_VIDEOIO_DEBUG=TRUE
