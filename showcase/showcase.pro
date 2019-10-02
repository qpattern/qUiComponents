QT += quick

CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        $$PWD/main.cpp

RESOURCES += \
    $$PWD/qml/qml.qrc

QML_IMPORT_PATH = $$PWD/../qml
