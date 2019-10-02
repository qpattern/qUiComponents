QT += quick

CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        $$PWD/main.cpp

RESOURCES += \
    $$PWD/qml/qml.qrc \
    $$PWD/../qml/QmlScaffold/Controls/controls.qrc

QML_IMPORT_PATH = $$PWD/../qml
