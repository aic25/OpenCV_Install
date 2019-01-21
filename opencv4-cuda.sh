#!/bin/bash

echo "OpenCV installation for ubuntu 16.04 by learnOpenCV.com"
 
echo "Select OpenCV version to install (1 or 2)"
echo "1. OpenCV 3.4.1 (default)"
echo "2. Master"
 
read cvVersionChoice
 
if [ "$cvVersionChoice" -eq 2 ]; then
    cvVersion="master"
else
    cvVersion="3.4.1"
fi

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build

# Create directory for installation
mkdir installation
mkdir installation/OpenCV-"$cvVersion"

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
apt -y install libxine2-dev libv4l-dev
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
 
# Optional dependencies
apt -y install libprotobuf-dev protobuf-compiler
apt -y install libgoogle-glog-dev libgflags-dev
apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

apt -y install python-dev python-pip python3-dev python3-pip
pip3 install -U pip numpy
apt -y install python3-testresources
 
# now install python libraries within this virtual environment
pip install numpy scipy matplotlib scikit-image scikit-learn ipython

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..
 
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
cd ..

cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D WITH_QT=ON \
        -D WITH_TIFF=ON \
        -D WITH_OPENGL=ON \
        -D WITH_CUDA=ON \
        -D WITH_CUBLAS=ON \
        -D WITH_CUFFT=ON \
        -D CUDA_FAST_MATH=ON \
        -D WITH_GTK=ON \
        -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-9.0 \
        -D CUDA_ARCH_BIN='6.1' \
        -D CUDA_ARCH_PTX="" \
        -D BUILD_DOCS=ON \
        -D BUILD_TESTS=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/pathto/opencv_contrib/modules ..
        
make -j10
make install

if [ "$cvVersionChoice" -eq 2 ]; then    
    ipython -c "import cv2; print(cv2.__version__)"
else
    ipython -c "import cv2; print(cv2.__version__)"
fi
