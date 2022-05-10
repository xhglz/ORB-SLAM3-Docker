FROM osrf/ros:melodic-desktop-full

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV HOME=/root SHELL=/bin/bash
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN apt-get update -q --fix-missing && \
    apt-get -y install --no-install-recommends apt-utils software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE && \
    add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u

RUN apt-get update -q --fix-missing && \
    apt-get install -y --no-install-recommends --allow-unauthenticated \
    build-essential cmake gcc g++ clang git pkg-config libpython2.7-dev python-pip libusb-1.0-0-dev \
    libgl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols libglew-dev libglfw3-dev \
    libatlas-base-dev libgoogle-glog-dev libgflags-dev libgtk2.0-dev libavcodec-dev libavformat-dev \
    libswscale-dev librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg \
    ros-melodic-uvc-camera ros-melodic-image-view ros-melodic-usb-cam python-catkin-tools \
    python-rosdep python-rosinstall python-rosinstall-generator python-wstool

RUN git config --global http.proxy http://proxy.x.x:x
RUN git config --global http.postBuffer 20000000

ENV EIGEN3_VERSION="3.1.0"
RUN git clone https://gitlab.com/libeigen/eigen.git && \
    cd eigen && git checkout tags/${EIGEN3_VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    cmake --build . && make install

ENV Pangolin_VERSION="v0.6"
RUN git clone https://github.com/stevenlovegrove/Pangolin.git && \
    cd Pangolin && git checkout tags/${Pangolin_VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    cmake --build . && make install

ENV OPENCV_VERSION="3.2.0"
RUN git clone https://github.com/opencv/opencv.git && \
    cd opencv && git checkout tags/${OPENCV_VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DENABLE_CXX11=ON \
          -DENABLE_PRECOMPILED_HEADERS=OFF \
          -DWITH_CUDA=OFF \
          -DBUILD_DOCS=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_PERF_TESTS=OFF .. && \
    make -j$(nproc) && make install

RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/opencv /root/eigen /root/Pangolin

RUN ( \
    echo 'source /opt/ros/melodic/setup.bash'; \
) > /root/.bashrc
