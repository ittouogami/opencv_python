FROM python:3.7-slim-buster
LABEL maintainer "ittou <VYG07066@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
ARG OPENCV_VER="3.4.9"
RUN mkdir /opencv-tmp &&\
    echo 'deb http://ftp.jp.debian.org/debian/ buster non-free' >> /etc/apt/sources.list &&\
    apt-get update -y &&\
    apt-get install -yq \
        build-essential \
        cmake \
        git \
        sudo \
        gosu \
        wget \
        unzip \
        yasm \
        dh-autoreconf \
        pkg-config \
        python3-dev \
        python3-pip \
        libdc1394-22-dev \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libavformat-dev \
        libpq-dev \
        libavcodec-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libgtk-3-dev \
        libatlas-base-dev \
        libopencv-dev \
#        libjasper-dev \
        libxine2-dev \
        libgstreamer1.0-0 \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-0 \
        libgstreamer-plugins-base1.0-dev \
# need
        libgstreamer-plugins-bad1.0-0 \
        qtbase5-dev \
        libfaac-dev \
        libmp3lame-dev \
        libtheora-dev \
        libvorbis-dev \
        libxvidcore-dev \
        gstreamer1.0-alsa \
        gstreamer1.0-gtk3 \
# need
        gstreamer1.0-libav \ 
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-pulseaudio \
# need
        gstreamer1.0-plugins-bad-videoparsers \
        x264 \
        ffmpeg \
        v4l-utils \
        kmod \
        gfortran \
        canberra-gtk* \
        uvccapture \
        guvcview \
        usbutils &&\
    pip3 install numpy matplotlib jupyter &&\
#glog
    cd /opencv-tmp &&\
    git clone https://github.com/google/glog.git &&\
    cd /opencv-tmp/glog &&\
    ./autogen.sh && ./configure && make && make install &&\
#gflags
    cd /opencv-tmp &&\
    git clone https://github.com/gflags/gflags.git &&\
    mkdir /opencv-tmp/gflags/build &&\
    cd /opencv-tmp/gflags/build &&\
    cmake ../ &&\
    make && make install &&\
#opencv
    cd /opencv-tmp &&\
    wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VER}.zip &&\
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VER}.zip &&\
    unzip opencv.zip &&\
    unzip opencv_contrib.zip &&\
    mkdir /opencv-tmp/opencv-${OPENCV_VER}/build &&\
    cd /opencv-tmp/opencv-${OPENCV_VER}/build &&\
    cmake \
        -DBUILD_TIFF=ON \
        -DBUILD_JASPER=OFF \
        -DBUILD_opencv_java=OFF \
        -DWITH_CUDA=ON \
        -DWITH_JASPER=OFF \
        -DWITH_OPENGL=ON \
        -DWITH_OPENCL=ON \
        -DWITH_IPP=ON \
        -DWITH_TBB=ON \
        -DTBB_INCLUDE_DIR=/usr/include/tbb \
        -DWITH_EIGEN=ON \
        -DWITH_V4L=ON \
        -DWITH_QT=ON \
        -DWITH_GTK=ON \
        -DWITH_GTK_2_X=OFF \
        -DBUILD_TESTS=OFF \
        -DBUILD_PERFF_TESTS=OFF \
        -DCMAKE_BUILD_TYPE=RELEASE \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DBUILD_opencv_python2=OFF \
        -DINSTALL_PYTHON_EXAMPLES=ON \
        -DOPENCV_EXTRA_MODULES_PATH=/opencv-tmp/opencv_contrib-${OPENCV_VER}/modules \
        -DPYTHON2_EXECUTABLE=$(which python2) \
        -DPYTHON3_EXECUTABLE=$(which python3) \
        -DPYTHON2_INCLUDE_DIR=$(python2 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -DPYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -DPYTHON2_PACKAGES_PATH=$(python2 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
        -DPYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
        -DBUILD_EXAMPLES=ON .. &&\
    make -j $(nproc) &&\
    make install &&\
    sudo rm -rf /opencv-tmp && \
    ldconfig &&\
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [ "/bin/bash", "-l" ]

