project(atcore-gui)

cmake_minimum_required (VERSION 2.8.12 FATAL_ERROR)
set (QT_MIN_VERSION "5.5.0")

find_package (ECM 5.10.0 REQUIRED NO_MODULE)
set (CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

set(REQUIRED_QT_VERSION "5.7.0")

find_package (ECM 5.10.0 REQUIRED NO_MODULE)
set (CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(KDECMakeSettings)
include(ECMInstallIcons)
include(ECMAddAppIcon)

if (CMAKE_SYSTEM_NAME STREQUAL "Android")
    add_definitions(-DMOBILE)

    find_package(Qt5AndroidExtras ${REQUIRED_QT_VERSION} REQUIRED)
    set(atcore-gui_EXTRA_LIBS
        Qt5::AndroidExtras
        Qt5::QuickControls2
        Qt5::Charts
        Qt5::3DQuick
        Qt5::3DQuickExtras
        Qt5::3DQuickRender
        Qt5::3DQuickInput
        Qt5::3DCore
        Qt5::3DExtras
        Qt5::3DRender
        Qt5::3DInput
    )
endif()

find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS
    Core
    Quick
    Widgets
    Test
    Gui
    Qml
    Svg
    QuickControls2
    Charts
    3DQuick
    3DQuickExtras
    3DQuickRender
    3DQuickInput
    3DCore
    3DExtras
    3DRender
    3DInput
)

if (NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
    find_package(AtCore REQUIRED COMPONENTS
        AtCore
    )

    find_package(KF5 REQUIRED COMPONENTS
        Notifications
        Kirigami2
    )
endif()

set(atcore-gui_SRCS
    main.cpp
)

qt5_add_resources(RESOURCES resources.qrc)

add_subdirectory(icons)
add_subdirectory(viewer3d)

add_executable(atcore-gui ${atcore-gui_SRCS} ${RESOURCES})

if (NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
    target_link_libraries(atcore-gui AtCore::AtCore Qt5::Core Qt5::Qml Qt5::Quick Qt5::Widgets Qt5::Svg AtCore3D KF5::Notifications ${atcore-gui_EXTRA_LIBS})
else()
    target_link_libraries(atcore-gui Qt5::Core Qt5::Qml Qt5::Quick Qt5::Widgets Qt5::Svg AtCore3D ${atcore-gui_EXTRA_LIBS})
endif()

install(TARGETS atcore-gui ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
