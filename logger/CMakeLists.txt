set(logger_SRCS
    logger.cpp
)

file(GLOB logger_SRC_QML
    LoggerComponent.qml
)

qt5_add_resources(logger_RCS logger.qrc)

add_library(AtCoreLogger STATIC ${logger_SRCS} ${logger_SRC_QML} ${logger_RCS})

target_link_libraries(AtCoreLogger
    Qt5::Core
    Qt5::Widgets
)
