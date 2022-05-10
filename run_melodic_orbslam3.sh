#!/bin/sh

SLAM_DIR=${PWD}/ORB_SLAM3_detailed_comments
DATA_DIR="path/datasets/tumvi/exported/euroc/512_16"


if [ ! -d "$SLAM_DIR" ]; then
  echo "ORB-SLAM3 directory does not exist: $SLAM_DIR"
  exit 1
fi

if [ ! -d "$DATA_DIR" ]; then
  echo "Datasets directory does not exist: $DATA_DIR"
  exit 1
fi

xhost +local:root;

docker run -it --privileged=true --net=host \
  --env="DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/dev:/dev" \
  --mount type=bind,source=$SLAM_DIR,target=/root/orbslam3 \
  --mount type=bind,source=$DATA_DIR,target=/root/orbslam3/data \
  xhglz/cvlife:orbslam3 /bin/bash -c "cd /root/orbslam3; /bin/bash;"

                                                              
# nvidia
# docker run -it --privileged=true --net=host --gpus all \
#   --env="NVIDIA_DRIVER_CAPABILITIES=all" \
#   --env="DISPLAY" \
#   --env="QT_X11_NO_MITSHM=1" \
#   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
#   --volume="/dev:/dev" \
#   --mount type=bind,source=$SLAM_DIR,target=/root/orbslam3 \
#   --mount type=bind,source=$DATA_DIR,target=/root/orbslam3/data \
#   xhglz/cvlife:orbslam3 /bin/bash -c "cd /root/orbslam3; /bin/bash;"