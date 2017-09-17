project(atcore-gui)

cmake_minimum_required(VERSION 3.0)

set(REQUIRED_QT_VERSION "5.7.0")

find_package (ECM 5.10.0 REQUIRED NO_MODULE)
set (CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(KDECMakeSettings)
include(ECMInstallIcons)
include(ECMAddAppIcon)

find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Core Quick Test Gui Svg QuickControls2)

set(atcore-gui_SRCS
    main.cpp
    )

qt5_add_resources(RESOURCES resources.qrc)

add_executable(atcore-gui ${atcore-gui_SRCS} ${RESOURCES})
target_link_libraries(atcore-gui Qt5::Core  Qt5::Qml Qt5::Quick Qt5::Svg)

install(TARGETS atcore-gui ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
