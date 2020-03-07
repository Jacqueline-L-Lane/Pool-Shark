How To Perform Custom Object Detection on a Raspberry Pi Using Tensorflow 
==================================================================

**INCOMPLETE. WILL FINISH SOON**

**Created 3/3/2020 (code borrowed from various sources)**

# Introduction
This tutorial is designed to walk you through setting up a custom object detection model using TensorFlow on a raspberry pi 4B, assuming basic knowledge of directory navigation and file manipulation in a Linux/Raspian environment and assuming NO prior knowledge about deep learning or object detection. This method is ideal for those who want to be able to detect objects quickly using a small dataset (< 400 images) who are unfamiliar with deep learning methods.

The tutorial begins by explaining how to install TensorFlow and OpenCV on both the pi (for testing) and on a virtual machine (for training). Object detection can be performed on live video feed from a picamera or webcam, images, or a pre-recorded video. Though this procedure was tested using a raspberry pi 4B, earlier pi versions should work as well. 

**Note 1:** Due to the limited amount of memory on the raspberry pi, you will need to perform training on either your own personal computer or a virtual machine (VM) instance, such as that on Google Cloud Platform (GCP) (the method using GCP will be described in detail below for those reluctant to install TensorFlow directly on their personal computers). 

**Note 2:** An older version of TensorFlow (TensorFlow 1.15) is currently being used until the pycocotools bug with TensorFlow 2.0's model_main.py gets resolved. This will require you to have to use a deprecated training file, though this will be explained in detail.

# Outline of Steps in Tutorial
1. [Install Tensorflow, OpenCV, and all necessary dependencies on the raspberry pi](##-1:-install-tensorflow,-opencv,-and-all-the-necessary-dependencies-on-the-raspberry-pi)

[Go to Heading section] (#-this-is-a-heading)

2. Take photos and label images using labelImg

3. Create a GCP VM instance (this step can be skipped if you would rather perform the training directly on your computer)

4. Copy _object_detection_ directory from pi to GCP VM instance

5. Train your custom model on the GCP VM instance

6. Copy _inference_graph_ directory from GCP VM instance to pi

7. Test your custom model using either live video feed, images, or pre-recorded video


# Steps
## 1: Install Tensorflow, OpenCV, and All the Necessary Dependencies on the Raspberry Pi

TODO

## 2: Label Images

1. Take a LOT of photos of the objects you are trying to detect (more than 350 is recommended, though the more you have, the better) with different lighting conditions, angles, backgrounds, etc. You can also find images online

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
4. Label images by creating bounding boxes around the objects you are trying to detect

5. Convert from labelImg to tf Records:
```
cd tensorflow/models/research
sudo python3 setup.py install
python3 generate_tfrecord.py --csv_input=images/train_labels.csv --image_dir=images/train --output_path=data/train.record
```
## 3: Google Cloud Platform (GCP) VM Instance

### 1. Create a virtual machine (VM) instance on GCP

TODO

**Note:** I am sure there is a much easier way to go about this next step than having to re-install everything and copy over files from the pi, though this is the method I used. If you know a better method, please let me know!

### 2. Install TensorFlow and Dependencies From Scratch on VM Instance:

#### Basic Installations:
```
sudo apt-get update
sudo apt-get install vim
mkdir Downloads
cd Downloads
```
#### Install pip3:
```
sudo curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"       
sudo apt-get install python3-distutils
python3 get-pip.py
pip3 --version
sudo apt-get install python3-pip                                             
pip3 --version
```
#### Install TensorFlow and its Dependencies

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
sudo apt install python-dev python-pip               # not sure if these are necessary
pip install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
python3 -m pip install -U --user keras_preprocessing --no-deps
python3 -m pip install -U --user keras_applications --no-deps
sudo apt-get install libatlas-base-dev
```

#### Make tensorflow directory
```
mkdir tensorflow
cd .. 
git clone --recurse-submodules https://github.com/tensorflow/models.git
```
**Note:** this next step assumes you have already completed the necessary steps outlined in the instructions for setting up Tensorflow object detection on the raspberry pi up to the section on training

## 4: Copy files from Raspberry Pi to VM instance on GCP (2 STEPS)

### 1. Copy files from Raspberry Pi to Windows desktop using WinSCP:

On Windows Desktop, download WinSCP from Ninite.com: go down to _Developer Tools_ and select _WinSCP_, then download and run WinSCP. Create a folder on your Windows desktop to store the folder

Type in raspberry pi’s IP address (e.g. 192.168.1.38), username (e.g. pi) and your password

Save state, login, then click and drag the _object_detection_ folder from the right side (the raspberry pi desktop) to the left side (your Windows desktop)

### 2. Copy files from your Windows desktop to your GCP VM instance using WinSCP. Follow tutorial below:

https://winscp.net/eng/docs/guide_google_compute_engine 

A. You will need PuTTYgen to generate a new key if you don’t already have it: in your computer’s search bar, type PuTTYgen, click, press _Generate_ button, select a comment field and a passphrase you can remember, then click _Save Private Key_ (leave the PuTTYgen interface open)

**Open up GCP Console:**

B. Find your GCP VM instance’s EXTERNAL IP address: on the GCP Console, go to _Navigation Menu -> VM instances_, then click your instance, and find the external IP address (ephemeral) 

**Back in PuTTYgen:***

C. Load your private key to PuTTYgen: click _Load_. PuTTYgen will display a dialog box where you can browse around the file system and find your key file. Once you select the file, PuTTYgen will ask you for a passphrase (if necessary) and will then display the key details in the same way as if it had just generated the key. Enter your GCP username (or any other account name you want to be created) to the _Key comment_ box. Copy the contents of _Public key for pasting into OpenSSH authorized_keys file_ (Ctrl C).

**Back in GCP Console:**

D. On the GCP Console, navigate to _Navigation Menu -> Metadata_, click on right tab at top that says _SSH Keys_, then click _Edit_, click _Add Item_ button and paste the contents of your clipboard (the public key that you just copied). At the bottom of the page, click _Save_

**Open WinSCP:**

E. In WinSCP, click _New site_, make sure _SFTP protocol_ is selected. Enter your GCE instance public IP address (see above) into the _Host name_ box. Enter the account name (that the console extracted out of your GCE username) into the _User name_ box. Press _Advanced_ button to open Advanced site settings dialog and go to _SSH > Authentication page_. In the _Private key file_ box, select your private key file. Submit the Advanced site settings dialog with _OK_ button

F. Save your site settings using the _Save_ button. Login using the _Login_ button

G. Now copy (click and drag) _object_detection_ directory from your personal computer into tensorflow/models/research/ on the VM instance

## 5. Training your Custom Model

Open GCP VM instance (click _SSH_ button)

### Miscellaneous Stuff:

```
cd ~
cd Downloads
git clone https://github.com/pdollar/coco.git    # get coco
cd coco/PythonAPI
make 
sudo make install
sudo python3 setup.py install
```
### Get Older Version of TensorFlow:

```
python 3 -m pip install tensorflow==1.15
python3 -c 'import tensorflow as tf; print(tf.__version__)'     # check correct version
cd tensorflowmodels/research/
sudo python3 setup.py build
sudo python3 setup.py install
```
### In Case of "Nets" Error:

Make modifications to bashrc file:

```
vim ~/.bashrc
export MODELS=~/Desktop/models            # path_to_models_directory
export PYTHONPATH=$MODELS:$MODELS/slim
# Save changes and exit file
source ~/.bashrc                          
```
### Begin Training

In object_detection folder, run the following command:

```
python3 train.py --logtostderr --train_dir=training/ --pipeline_config_path=training/ssdlite_mobilenet_v2_coco.config
```

You should be able to view training status using tensorboard by opening a new terminal of your VM instance (just click on SSH again), running the following command, and then clicking on the web page generated at localhost.6006, though I have not yet figured out how to get this to work on GCP:

```
tensorboard --logdir=training
```

Continue training until your average loss rate is < 1.0. I **_highly_** recommended waiting until the average loss rate is 0.05

To terminate training, press Ctrl C

Check your training folder for the last checkpoint number (make a note of the largest number)

Run the following command, making sure to replace _ssdlite_mobilenet_v2_coco.config_ with whichever model you are using and the model checkpoint (_model.ckpt-XXXX_) with the last checkpoint number in your training folder

```
python3 export_inference_graph.py --input_type image_tensor --pipeline_config_path training/ssdlite_mobilenet_v2_coco.config --trained_checkpoint_prefix training/model.ckpt-XXXX --output_directory inference_graph 
```
## 6: Copy Files from VM instance on GCP back to Raspberry Pi (2 STEPS)

Copy the newly created _inference_graph_ directory (which should now contain a frozen inference graph) from your VM instance to your desktop, and then from your desktop back to the raspberry pi using WinSCP (if you saved the IP addresses from Step 2 (see above)), this should be trivial. Save the _inference_graph_ directory under _tensorflow/models/research/object_detection_

## 7. Testing your Custom Model:

### Test your Custom Model on Live Video Feed (Picamera or Webcam)

In the _object_detection_ directory, make a copy of the _Object_detection_picamera.py_ script, rename it, then make modifications (Replace <YOUR_MODULE_NAME> with whatever you're detecting (e.g. Pool_ball_detection_webcam.py))

```
cp Object_detection_picamera.py <YOUR_MODULE_NAME>_picamera.py     # If you are using a picamera or webcam  
```
Edit the file: find the following variables and modify the values as necessary:

```
NUM_CLASSES = 17                  # change number of classes from 90 to however many classes you’re using
MODEL_NAME = ‘inference_graph’    # change directory from ‘ssdlite_mobilenet_v2_coco_2018_05_09’ to the folder your frozen inference graph is located in
```
Save changes and exit

Plug in your picamera or webcam to the raspberry pi (if you haven't already)

In _object_detection_ folder: 

```
python3 <YOUR_MODULE_NAME>_picamera.py --usbcam                  # run this if you are using a webcam
python3 <YOUR_MODULE_NAME>_picamera.py                           # run this if you are using a picamera      
```

### Test your Custom Model on Images

Save image(s) in _object_detection_ directory that you would like to test

```
cp Object_detection_image.py <YOUR_MODULE_NAME>_image.py     # If you are using an image 
```
Edit the file: find _IMAGE_NAME = 'test1.jpg'_ and replace _test1_ with the name of your image

In _object_detection_ folder: 

```
python3 Object_detection_image.py
```


# This is a heading
