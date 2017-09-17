 cmake ../AtCore-Gui \
    -DCMAKE_TOOLCHAIN_FILE=/usr/share/ECM/toolchain/Android.cmake \
    -DECM_ADDITIONAL_FIND_ROOT_PATH=/opt/android-qt5/5.9.1/armeabi/ \
    -DCMAKE_MODULE_PATH=/opt/android-qt5/5.9.1/armeabi/lib/cmake/ \
    -DCMAKE_PREFIX_PATH=/opt/android-qt5/5.9.1/armeabi/lib/ \
    -DCMAKE_INSTALL_PREFIX=/mnt/hd/kirigami-install/ \
    -DECM_DIR=/usr/share/ECM/cmake/ \
    -DCMAKE_SYSTEM_NAME="Android" \
    -DCMAKE_ANDROID_NDK=/opt/android-ndk/ \
    -DQt5Core_DIR=/opt/android-qt5/5.9.1/armeabi/lib/cmake/Qt5Core/ \
    -DQTANDROID_EXPORTED_TARGET=atcore-gui -DANDROID_APK_DIR=/home/patrick/git/patrick/AtCore-Gui/


make create-apk-atcore-gui

