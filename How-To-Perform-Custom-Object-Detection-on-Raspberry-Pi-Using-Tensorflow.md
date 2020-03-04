How To Perform Custom Object Detection on a Raspberry Pi Using Tensorflow 
==================================================================

**INCOMPLETE. WILL FINISH SOON**

**Created 3/3/2020 (code borrowed from various sources)**

**Note:** due to the limited amount of memory on the raspberry pi, this tutorial requires the creation of a virtual machine (VM) instance on Google Cloud Platform (GCP) (this will be described in detail below). This tutorial also assumes you have either a webcam or picamera in order to take photos or display a live feed. 

# Introduction
This tutorial explains the general process of setting up TensorFlow for object detection on a 1 GB raspberry pi 4B, though earlier pi versions should work as well. An older version of TensorFlow is currently being used until the pycocotools bug with TensorFlow's model_main.py gets resolved. 

# Steps
## 1: Install Tensorflow, OpenCV, and All the Necessary Dependencies

TODO

## 2: Custom Object Detection

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

### 1. Copy files from raspberry pi to Windows desktop using WinSCP:

On Windows Desktop, download WinSCP from Ninite.com: go down to Developer Tools and select WinSCP, then download and run WinSCP. Create a folder on your Windows desktop to store the folder

Type in raspberry pi’s IP address (e.g. 192.168.1.38), username (pi) and your password
Save state, login, then click and drag the object_detection folder from the right side (the raspberry pi desktop) to the left side (your Windows desktop)

### 2. Copy files from your Windows desktop to your GCP VM instance using WinSCP. But this is more complicated than the first step. Follow this tutorial:

https://winscp.net/eng/docs/guide_google_compute_engine

a. You will need PuTTYgen to generate a new key if you don’t already have it: in your computer’s search bar, type PuTTYgen, click, press Generate button, select comment field and passphrase, then click Save Private Key (leave interface open)

b. Find your GCP VM instance’s EXTERNAL IP address: on GCP Console, go to Navigation Menu -> VM instances, then click your instance, find external IP address (ephemeral) 

c. Load your private key to PuTTYgen: in PuTTYgen, click Load. PuTTYgen will display a dialog box where you can browse around the file system and find your key file. Once you select the file, PuTTYgen will ask you for a passphrase (if necessary) and will then display the key details in the same way as if it had just generated the key

d. Enter your GCP username (or any other account name you want to be created) to Key comment box

e. Copy the contents of Public key for pasting into OpenSSH authorized_keys file
On GCP Console, go to Navigation Menu -> Metadata, click on right tab at top that says SSH Keys, then click Edit, click Add Item button and paste contents of clipboard (your public key) 
Add bottom of page, click Save

f. Open WinSCP, New site, SFTP protocol 

g. Enter your GCE instance public IP address (see above) into the Host name box

h. Enter the account name (that the console extracted out of your GCE username) into the User name box

i. Press Advanced button to open Advanced site settings dialog and go to SSH > Authentication page

j. In the Private key file box select your private key file

k. Submit the Advanced site settings dialog with OK button

l. Save your site settings using the Save button

m. Login using the Login button

n. Copy object_detection folder over into tensorflow/models/research/



TODO



