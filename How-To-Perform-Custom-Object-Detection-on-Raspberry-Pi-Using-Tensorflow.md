How To Perform Custom Object Detection on a Raspberry Pi Using Tensorflow 
==================================================================

**Created 3/3/2020 (code borrowed from various sources)**

**Note:** due to the limited amount of memory on the raspberry pi, this tutorial requires the creation of a virtual machine (VM) instance on Google Cloud Platform (GCP) (this will be described in detail below). This tutorial also assumes you have either a webcam or picamera in order to take photos or display a live feed. 

## Introduction
This tutorial explains the general process of setting up TensorFlow for object detection on a 1 GB raspberry pi 4B, though earlier pi versions should work as well. An older version of TensorFlow is currently being used until the pycocotools bug with TensorFlow's model_main.py gets resolved. 

## Steps
### 1: Install Tensorflow, OpenCV, and All the Necessary Dependencies

TODO

### 2: Custom Object Detection

1. Take a LOT of photos of the objects you are trying to detect (more than 350 is recommended) with different lighting conditions, angles, backgrounds, etc.

2. Download labelImg in order to label all your photos. Assuming you are in your pi's home directory, type the following:

```
cd Downloads
git clone https://github.com/tzutalin/labelImg.git
cd labelImg
sudo apt-get install pyqt5-dev-tools
sudo apt-get install python3-lxml
make qt5py3
```
3. Run labelImg:
```
cd Downloads/labelIng
python3 labelImg.py
```
