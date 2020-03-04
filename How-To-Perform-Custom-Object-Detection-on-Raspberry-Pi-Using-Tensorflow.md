How To Perform Custom Object Detection on a Raspberry Pi Using Tensorflow 
==================================================================

**INCOMPLETE. WILL FINISH SOON**

**Created 3/3/2020 (code borrowed from various sources)**

**Note:** due to the limited amount of memory on the raspberry pi, this tutorial requires the creation of a virtual machine (VM) instance on Google Cloud Platform (GCP) (this will be described in detail below). This tutorial also assumes you have either a webcam or picamera in order to take photos or display a live feed. 

## Introduction
This tutorial explains the general process of setting up TensorFlow for object detection on a 1 GB raspberry pi 4B, though earlier pi versions should work as well. An older version of TensorFlow is currently being used until the pycocotools bug with TensorFlow's model_main.py gets resolved. 

## Steps
### 1: Install Tensorflow, OpenCV, and All the Necessary Dependencies

TODO

### 2: Custom Object Detection

# 1. Take a LOT of photos of the objects you are trying to detect (more than 350 is recommended) with different lighting conditions, angles, backgrounds, etc.

# 2. Download labelImg in order to label all your photos. Assuming you are in your pi's home directory, type the following:

```
cd Downloads
git clone https://github.com/tzutalin/labelImg.git
cd labelImg
sudo apt-get install pyqt5-dev-tools
sudo apt-get install python3-lxml
make qt5py3
```
# 3. Run labelImg:
```
cd Downloads/labelIng
python3 labelImg.py
```
# 4. Label images by creating bounding boxes around the objects you are trying to detect

# 5. Convert from labelImg to tf Records:
```
cd tensorflow/models/research
sudo python3 setup.py install
python3 generate_tfrecord.py --csv_input=images/train_labels.csv --image_dir=images/train --output_path=data/train.record
```
### 3: Training Model on Google Cloud Platform (GCP)

# 1. Create a virtual machine (VM) instance on GCP

TODO

**Note:** I am sure there is a much easier way to go about this next step than having to re-install everything and copy over files from the pi, though this is the method I used. If you know a better method, please let me know!

# 2. Install TensorFlow and Dependencies From Scratch on VM Instance:

Basic Installations:
```
sudo apt-get update
sudo apt-get install vim
mkdir Downloads
cd Downloads
```
Install pip3:
```
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"       
sudo apt-get install python3-distutils
python3 get-pip.py
pip3 --version
sudo apt-get install python3-pip                                             
pip3 --version
```
Install TensorFlow and its Dependencies

Source: https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md

```
python3 -m pip install tensorflow                    # install TensorFlow
sudo apt-get install protobuf-compiler python-pil python-lxml python-tk
python3 -m pip install --user Cython
python3 -m pip install --user contextlib2
python3 -m pip install --user jupyter
python3 -m pip install --user pandas
pip install --user matplotlib
sudo apt-get install git                             # install git
git --version                                        # verify it was successful 
sudo apt install python-dev python-pip      // not sure if these are necessary
pip install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
python3 -m pip install -U --user keras_preprocessing --no-deps
python3 -m pip install -U --user keras_applications --no-deps
sudo apt-get install libatlas-base-dev
```

Make tensorflow directory
```
mkdir tensorflow
cd .. 
git clone --recurse-submodules https://github.com/tensorflow/models.git
```
*Note: this next step assumes you have already completed the necessary steps outlined in the instructions for setting up Tensorflow object detection on the raspberry pi up to the section on training
