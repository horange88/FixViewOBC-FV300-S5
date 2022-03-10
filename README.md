# FixViewOBC-FV300-S5
Instrucciones de instalación y configuración de OBC para FV300-S5

Se realiza la instalación mínima de ubuntu 20 descargadas de la página oficial de ubuntu para arquitectura amd64

## Configurar repositorios en `/etc/apt/sources.list` (NO NECESARIO EN UBUNTU)

```
sudo nano /etc/apt/sources.list
```
Comentar todo y dejar solo lo siguiente
```
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free

```

## Modificar GRUB file `/etc/default/grub`

```
sudo nano /etc/default/grub
```
Editar la linea 
```
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" 
```
Luego ejecutar
```
sudo update-grub
```
Ver https://askubuntu.com/questions/248/how-can-i-show-or-hide-boot-messages-when-ubuntu-starts

## Configurar escritorio en modo kiosk
Instalar las extensiones de gnome
```
sudo apt install  gnome-shell-extension-autohidetopbar
```
Luego configurar las extensiones desde el dock de ubuntu.

Desactivar las animaciones al cargar escritorio
```
gsettings set org.gnome.desktop.interface enable-animations false
```
## Instalar splash
seguir instruscciones en
```
https://github.com/horange88/FixViewSplash.git
```
## Instalar gestor de ventanas Openbox (NO NECESARIO EN UBUNTU)
```
sudo apt-get install openbox obconf openbox-menu lxterminal chromium-browser xorg
```
Crear archivo .xinitrc con lo siguiente

```
#!/bin/bash
exec openbox-session

```
## Instalar librería gráfica SDL
```
sudo apt-get install gcc cmake freeglut3 freeglut3-dev libudev-dev  libdbus-1-dev xorg-dev libudev-dev libdbus-1-dev xorg-dev libpng++-dev libjpgalleg4-dev

cd ~
wget https://www.libsdl.org/release/SDL2-2.0.16.tar.gz
tar -xvf SDL2-2.0.16.tar.gz
cd SDL2-2.0.16/
./configure
make
sudo make install

cd ~
wget https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz
tar -xvf SDL2_image-2.0.5.tar.gz 
cd SDL2_image-2.0.5/
./configure 
make
sudo make install

cd ~
wget https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.tar.gz
tar -xvf SDL2_ttf-2.0.15.tar.gz 
cd SDL2_ttf-2.0.15/
./configure 
make
sudo make install
```
## Instalar gphoto2
```
sudo apt install libgphoto2-dev
```
## Instalar Opencv 3.2.0

```
sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libavresample-dev python3-dev python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev tesseract-ocr libgtk3.0-cil-dev  libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools
```
Desgargar y compilar el còdigo fuente
```
cd ~
wget https://github.com/opencv/opencv/archive/refs/tags/3.2.0.tar.gz -O opencv-3.2.0.tar.gz
tar -xvf opencv-3.2.0.tar.gz

cd opencv-3.2.0/
```
Editar el archivo `./modules/videoio/src/cap_ffmpeg_impl.hpp` y agregar las siguientes lineas junto a las definiciones
```
#define AV_CODEC_FLAG_GLOBAL_HEADER (1 << 22)
#define CODEC_FLAG_GLOBAL_HEADER AV_CODEC_FLAG_GLOBAL_HEADER
#define AVFMT_RAWPICTURE 0x0020
```
Editar el archivo `./modules/python/src2/cv2.cpp`  en linea 730. Cambiar `char* str = PyString_AsString(obj);` por `const char* str = PyString_AsString(obj);`

Descargar y compilar opencv_contrib
```
wget https://github.com/opencv/opencv_contrib/archive/refs/tags/3.2.0.tar.gz -O opencv_contrib-3.2.0.tar.gz
tar -xvf opencv_contrib-3.2.0.tar.gz

mkdir build 
cd build

cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX="/usr/local" -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DBUILD_opencv_world=OFF -DBUILD_opencv_contrib_world=OFF -DBUILD_opencv_features2d=ON -DBUILD_opencv_objdetect=ON -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-3.2.0/modules ..

make -j9
sudo make install
```
Si falla la compilacion indicando un error de shared library, agregar el flag `-DBUILD_SHARED_LIBS=OFF` en la instrucciòn cmake y continuar


## API Telegram 
```
sudo apt-get install curl g++ make binutils cmake libssl-dev libboost-system-dev zlib1g-dev libcurl4-openssl-dev

cd ~
git clone https://github.com/reo7sp/tgbot-cpp
cd tgbot-cpp
cmake .
make -j4
sudo make install

```
## eBus

```
cd ~
wget https://gitlab.kitware.com/kfieldho/thxfiles/uploads/a0a87a3a9e9ac53f540b018baba75916/eBUS_SDK_Ubuntu-x86_64-5.0.0-4100.deb
sudo dpkg -i eBUS_SDK_Ubuntu-x86_64-5.0.0-4100.deb

sudo add-apt-repository ppa:rock-core/qt4
sudo apt-get install libqtgui4
sudo apt-get install  libqt4-opengl 
```
## Quitar password sudo
Editar el archivo `/etc/sudoers`
```
sudo visudo /etc/sudoers
```
Agregar al final
```
fv300 ALL=(ALL) NOPASSWD: ALL
```
## CAN Utils

```
sudo apt install can-utils
```
## CAN Systec
Si se usa SystecCAN, se deben instalar los drivers
```
cd ~
wget https://www2.systec-electronic.com/fileadmin/Redakteur/Unternehmen/Support/Downloadbereich/Treiber/systec_can-V1.0.3.tar.bz2
tar -xf systec_can-V1.0.3.tar.bz2
rm systec_can-V1.0.3.tar.bz2
```

## ExifTools

```
cd ~
wget https://exiftool.org/Image-ExifTool-12.30.tar.gz
tar -xf Image-ExifTool-12.30.tar.gz
cd Image-ExifTool-12.30.tar.gz
perl Makefile.PL
make test
sudo make install

```


## Lector de sensores de temperatura del los cores del micro
```
sudo apt-get install lm-sensors
```

## Log de horas de uso
```
sudo apt-get install uptimed 
```
## Servidor SVN
```
sudo apt-get install snapd
sudo snap install rapidsvn-snap
```
## Fbuild
Descargar fbuild del repositorio y asegurarse que luego de realizar `. start.sh` el arhivo `/usr/bin/scons` ejecute python 2.
En la primera linea reemplazar lo que tenga con 
```
/usr/bin/python2
```

## Configuración de servicios
Copiar archivos de configuración de servicios  `hbMonitor.service` y `obc.service` y configurar systemd.
```
sudo cp obc.service /etc/systemd/system/
sudo cp hbMonitor.service /etc/systemd/system/
sudo systemctl enable obc.service
sudo systemctl enable hbMonitor.service
```

Copiar  `launcher.sh` e `install.sh`
```
chmod +x launcher.sh
chmod +x install.sh
cp launcher.sh /home/fv300/fix-fbuild/trunk/install/bin/launcher.sh
cp install.sh /home/fv300/systec_can-master/
```