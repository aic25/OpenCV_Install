#!/bin/bash

# Save current working directory

if [ -d build ] 
then
	rm -r build
fi
mkdir build
cd    build

# OpenGL is not supported for Linux (OpenCV)

cmake --enable-shared \
      -DCMAKE_INSTALL_PREFIX=/usr      \
      -DCMAKE_BUILD_TYPE=Release       \
      -D INSTALL_C_EXAMPLES=ON 		\
      -D INSTALL_PYTHON_EXAMPLES=ON 	\
      -D BUILD_opencv_python2=OFF 	\
      -D BUILD_opencv_python3=ON 	\
      -D WITH_V4L=ON 			\
      -D WITH_LIBV4L=ON			\
      -D WITH_TBB=ON			\
      -D WITH_CUDA=ON 			\
      -D WITH_CUBLAS=ON 		\
      -D WITH_CUFFT=ON 			\
      -D WITH_NVCUVENC=ON		\
      -D BUILD_opencv_cudacodec=ON	\
      -D BUILD_opencv_cudev=ON		\
      -D WITH_NVCUVID=ON		\
      -D WITH_GSTREAMER=ON		\
      -D WITH_QT=ON			\
      -D WITH_GTK=ON			\
      -D WITH_VTK=ON			\
      -D CUDA_FAST_MATH=ON 		\
      -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-9.0 \
      -D CUDA_ARCH_BIN='6.1' 		\
      -D CUDA_ARCH_PTX="" 		\
      -D ENABLE_CXX11=ON                \
      -D BUILD_PERF_TESTS=OFF           \
      -D WITH_XINE=ON                   \
      -D BUILD_TESTS=OFF                \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D CMAKE_SKIP_RPATH=ON            \
      -D CMAKE_CUDA_COMPILER=/usr/local/cuda-9.0/bin/nvcc \
      -D BUILD_WITH_DEBUG_INFO=OFF      \
      -D OPENCV_EXTRA_MODULES_PATH=/pathto/opencv_contrib-3.4.0/modules \
      -Wno-dev  ..                     &&
make

make install VERBOSE=1 &&

case $(uname -m) in
  x86_64) ARCH=intel64 ;;
       *) ARCH=ia32    ;;
esac                     &&

cp -v /pathto/opencv/build/3rdparty/ippicv/ippicv_lnx/lib/$ARCH/libippicv.a /usr/lib &&
unset ARCH

ipython -c "import cv2; print(cv2.__version__); print(cv2.getBuildInformation())"
