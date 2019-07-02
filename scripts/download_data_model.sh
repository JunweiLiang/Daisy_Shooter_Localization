#!/bin/bash

set -Eeuxo pipefail

# Download k-means centers, and other stuff

mkdir -p additional_software

# wget https://daisy.cs.cmu.edu/assets/additional_stuff/liblinear-2.30.zip -O additional_software/liblinear-2.30.zip
curl https://daisy.cs.cmu.edu/assets/additional_stuff/selected_stftabs_w100h50_0.4.txt.cluster_centres -o additional_software/selected_stftabs_w100h50_0.4.txt.cluster_centres
curl https://daisy.cs.cmu.edu/assets/additional_stuff/sfep_mfcc.tgz -o additional_software/sfep_mfcc.tgz
curl https://daisy.cs.cmu.edu/assets/additional_stuff/assets.tgz -o additional_software/assets.tgz

cd additional_software/


tar xf sfep_mfcc.tgz
# the example videos 
tar xf assets.tgz
chmod -R 755 assets/
mv assets/ ../web_interface

# clean up
rm -rf assets.tgz liblinear-2.30.zip sfep_mfcc.tgz