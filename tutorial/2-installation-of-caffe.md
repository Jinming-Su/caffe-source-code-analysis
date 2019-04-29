### Installation of Caffe without CUDA  
**_Note_**: this tutorial is based on ubuntu 16.04 unless otherwise specified.  
1. install dependent software  
```
sudo apt-get install libprotobuf-dev protobuf-compiler protobuf-compiler libgflags-dev libgoogle-glog-dev libatlas-base-dev libopencv-dev libhdf5-serial-dev  liblmdb-dev libleveldb-dev libsnappy-dev
```
The meaning of above libraries refer to `1-dependent-software` in the series.  
2. install caffe  
```
git clone git://github.com/BVLC/caffe.git
cp Makefile.config.example Makefile.config
vim Makefile.config
// uncomment CPU_ONLY:=1
// goto  /usr/lib/x86_64-linux-gnu
sudo ln -s libhdf5_serial.so libhdf5.so
sudo ln -s libhdf5_serial_hl.so libhdf5_hl.so
// add /usr/include/hdf5/serial to INCLUDE_DIRS
// add /usr/lib/x84_64-linux-gnu/hdf5/seria to LIBRARY_DIRS
``` 
3. compile caffe  
```
make all -j8
// make test -j8
// make runtest -j8  // these are not necessary, and I usually ignore these tests.
```

4. test caffe
```
./data/mnist/get_mnist.sh
./examples/mnist/create_mnist.sh
./examples/mnist/train_lenet.sh
```
Log is as follows:  
```

I0429 14:42:46.599921 16998 solver.cpp:290] Learning Rate Policy: inv
I0429 14:42:46.600472 16998 solver.cpp:347] Iteration 0, Testing net (#0)
I0429 14:42:50.294911 17005 data_layer.cpp:73] Restarting data prefetching from start.
I0429 14:42:50.446030 16998 solver.cpp:414]     Test net output #0: accuracy = 0.1045
I0429 14:42:50.446058 16998 solver.cpp:414]     Test net output #1: loss = 2.36391 (* 1 = 2.36391 loss)
I0429 14:42:50.509238 16998 solver.cpp:239] Iteration 0 (0 iter/s, 3.909s/100 iters), loss = 2.33238
I0429 14:42:50.509263 16998 solver.cpp:258]     Train net output #0: loss = 2.33238 (* 1 = 2.33238 loss)
I0429 14:42:50.509289 16998 sgd_solver.cpp:112] Iteration 0, lr = 0.01
I0429 14:42:56.596632 16998 solver.cpp:239] Iteration 100 (16.4285 iter/s, 6.087s/100 iters), loss = 0.191773
I0429 14:42:56.596663 16998 solver.cpp:258]     Train net output #0: loss = 0.191773 (* 1 = 0.191773 loss)
I0429 14:42:56.596683 16998 sgd_solver.cpp:112] Iteration 100, lr = 0.00992565
```
The tutorial of installation without CUDA is easy. And I don't provide extra operations because I think we should have at least one GPU to run caffe. Next, I will give more functions of Caffe with CUDA.  

###  Installation of Caffe with CUDA 
1. install NVIDA driver  
```
// download driver from http://www.geforce.cn/drivers
Ctrl+Alt+F1
sudo service lightdm stop
chmod +x NVIDIA*.run
sudo ./NVIDIA*.run
sudo service lightdm start
Ctrl+Alt+F7
```  
2. validate weather driver is installed successfully  
```
➜  caffe git:(master) ✗ nvidia-smi
Mon Apr 29 15:16:32 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 384.130                Driver Version: 384.130                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 1080    Off  | 00000000:01:00.0  On |                  N/A |
|  0%   46C    P5    17W / 200W |   1098MiB /  8110MiB |      1%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0      1137      G   /usr/lib/xorg/Xorg                           305MiB |
|    0      2156      G   compiz                                       181MiB |
|    0     12974      G   ...-token=E66C2E7AEFFA859A45406E36028461AE   596MiB |
|    0     13391      G   ...-token=2AB8372DA2E40D18CAC06CE88B773B9C    11MiB |
+-----------------------------------------------------------------------------+
```
**_Note: If the screen is black after running `Ctrl+Alt+F1`, _**  
```
vim /etc/default/grub
// moidify the value of GRUB_CMDLINE_LINUX_DEFAULT as nomodeset
sudo update-grub
sudo reboot
```
3. install CUDA (Compute Unified Device Architecture)  
```
// download: https://developer.nvidia.com/cuda-downloads
chmod +x *.run
sudo ./*.run
```
4. install CUDNN  
```
//download: https://developer.nvidia.com/rdp/cudnn-download
// copy cuDNN to cuda
tar -zxvf cudnn-7.0-linux-x64-v4.0-prod.tgz
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/cudnn.h /usr/local/cuda/include/

// add the path of CUDA to /etc/profile
sudo gedit /etc/profile
// add
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=/usr/local/cuda/lib64:$LIBRARY_PATH

// optional: valiation
// goto /usr/local/cuda/samples，to build samples by
sudo make all -j4
// goto samples/bin/x86_64/linux/release，run deviceQuery see the informantion of GPU
./deviceQuery
```
5. compile caffe  
6. test caffe
```
./examples/mnist/train_lenet.sh
```  
The final log is as follows (accuray is about 0.9915):  
```
I0429 15:25:03.526787 19056 sgd_solver.cpp:284] Snapshotting solver state to binary proto file examples/mnist/lenet_iter_10000.solverstate
I0429 15:25:03.529804 19056 solver.cpp:327] Iteration 10000, loss = 0.0026507
I0429 15:25:03.529822 19056 solver.cpp:347] Iteration 10000, Testing net (#0)
I0429 15:25:03.660559 19063 data_layer.cpp:73] Restarting data prefetching from start.
I0429 15:25:03.664521 19056 solver.cpp:414]     Test net output #0: accuracy = 0.9915
I0429 15:25:03.664543 19056 solver.cpp:414]     Test net output #1: loss = 0.0265013 (* 1 = 0.0265013 loss)
I0429 15:25:03.664551 19056 solver.cpp:332] Optimization Done.
I0429 15:25:03.664556 19056 caffe.cpp:250] Optimization Done.
```

### Compile the Python interface
```
// change Makefile.config at
PYTHON_INCLUDE := /usr/include/python2.7 \
                 /usr/local/lib/python2.7/dist-packages/numpy/core/include
make pycaffe
```

### Compile the Matlab interface
```
// change the path of Matalb in Makefile.config, and then
make matcaffe
```
**_Note: If there exists error because the version of GCC or G++, such as 5.3 against 4.9, the solution is as follows: _**  
```
// 1. install gcc and g++ 4.9
sudo apt-get install gcc-4.9 g++-4.9 gcc-4.9-multilib g++-4.9-multilib
// 2. open matlab and run 
mex -setup C -f ~/.matlab/R2016b/mex_C_glnxa64.xml
mex -setup C++ -f ~/.matlab/R2016b/mex_C++_glnxa64.xml
// 3. change the Name="g++", ShortName="g++" in ~/.matlab/R2016b/mex_C++_glnxa64.xml to Name="g++-4.9", ShortName="g++-4.9". Same goes for gcc in mex_C_glnxa64.xml.
// 4. compile matcaffe by
make matcaffe
// 5. relink libstdc++.so.6 in the Matlab directory
cd /path/to/MATLAB/R2016b/sys/os/glnxa64
sudo rm libstdc++.so.6
sudo ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.21 libstdc++.so.6
// 6. relink OpenCV related libraries in the Matlab directory
cd /path/to/MATLAB/R2016b/bin/glnxa64
sudo rm libopencv_core.so.2.4
sudo ln -s /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9 libopencv_core.so.2.4
sudo rm libopencv_highgui.so.2.4
sudo ln -s /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9 libopencv_highgui.so.2.4
sudo rm libopencv_imgproc.so.2.4
sudo ln -s /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9 libopencv_imgproc.so.2.4
```

### Extra Problems or Errors
1. `error while loading shared libraries: libcudnn.so.x.x: cannot open shared object file: No such file or directory`  
Solution:  
```
sudo cp /usr/local/cuda/lib64/libcudart.so.10.0 /usr/local/lib/libcudart.so.10.0 && sudo ldconfig
sudo cp /usr/local/cuda/lib64/libcublas.so.10.0 /usr/local/lib/libcublas.so.10.0 && sudo ldconfig
sudo cp /usr/local/cuda/lib64/libcurand.so.10.0 /usr/local/lib/libcurand.so.10.0 && sudo ldconfig
sudo cp /usr/local/cuda/lib64/libcudnn.so.7 /usr/local/lib/libcudnn.so.7 && sudo ldconfig
```  
2. `Invalid MEX-file '/path/to/caffe/matlab/+caffe/private/caffe_.mexa64': /path/to/MATLAB/bin/glnxa64/../../sys/os/glnxa64/libstdc++.so.6: version GLIBCXX_3.4.21 not found (required by /path/to/caffe/matlab/+caffe/private/caffe_.mexa64).`  
Solution:  
```
// add to path
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4:/usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4:/usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4:/usr/lib/x86_64-linux-gnu/libstdc++.so.6:/usr/lib/x86_64-linux-gnu/libfreetype.so.6
```

### Reference
1. matcaffe: http://www.cs.jhu.edu/~cxliu/2016/compiling-matcaffe-on-ubuntu-1604.html
