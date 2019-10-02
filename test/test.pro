CONFIG += warn_on qmltestcase

TEMPLATE = app

DISTFILES += \
    $$PWD/../qml/QmlScaffold/Controls/test/tst_DraggableItem.qml

SOURCES += \
    $$PWD/main.cpp

QUICK_TEST_SOURCE_DIR = $$PWD/../qml
IMPORTPATH += $$PWD/../qml
