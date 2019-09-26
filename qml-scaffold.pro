QT += quick

CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp

RESOURCES += \
    qml/qml.qrc \
    qml/showcase/showcase.qrc

QML_IMPORT_PATH = qml
