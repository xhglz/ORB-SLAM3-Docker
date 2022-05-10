# Note!
Library Version:
- EIGEN3_VERSION="3.1.0"
- Pangolin_VERSION="v0.6"
- OPENCV_VERSION="3.2.0"
        
Not support ROS.

# ORB-SLAM3-Docker
## Install Docker
执行下列指令安装 docker
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
将 docker 加入用户组，解决每次运行 Docker 输入 sudo
```bash
# 创建 docker 用户组
sudo groupadd docker
# 添加当前用户加入 docker 用户组
sudo usermod -aG docker ${USER}
# 重启 docker 服务
sudo systemctl restart docker
# 切换或者退出当前账户再从新登入
docker ps
```
考虑到网络环境，建议将依赖库先下载，修改 **Copy.Dockerfile** 里的路径，然后进行安装
```bash
# docker build -t xhglz/cvlife:orbslam3 -f Docker/Dockerfile .
docker build -t xhglz/cvlife:orbslam3 -f Docker/Copy.Dockerfile .
```
## Compile
下载课程注释的代码
```bash
git clone https://github.com/electech6/ORB_SLAM3_detailed_comments.git
```
修改 run_melodic_orbslam3.sh 中 ORB-SLAM3 的绝对路径，进入 Docker
```bash
./run_melodic_orbslam3.sh
```
对 **build.sh** 文件增加可执行属性
```bash
chmod +x build.sh 
```
编译
```bash
./build.sh
```
## Run
在 run_melodic_orbslam3.sh 修改代码和数据目录
```bash
./run_melodic_orbslam3.sh # 进入容器
cd Examples 

# Stereo Examples
./Stereo/stereo_tum_vi ../Vocabulary/ORBvoc.txt Stereo/TUM_512.yaml ../dataset-room3_512_16/mav0/cam0/data ../dataset-room3_512_16/mav0/cam1/data Stereo/TUM_TimeStamps/dataset-room3_512.txt dataset-room3_512_stereo

# Stereo-Inertial Examples
./Stereo-Inertial/stereo_inertial_tum_vi ../Vocabulary/ORBvoc.txt Stereo-Inertial/TUM_512.yaml ../dataset-room3_512_16/mav0/cam0/data ../dataset-room3_512_16/mav0/cam1/data Stereo-Inertial/TUM_TimeStamps/dataset-room3_512.txt Stereo-Inertial/TUM_IMU/dataset-room3_512.txt dataset-room3_512_stereoi
```