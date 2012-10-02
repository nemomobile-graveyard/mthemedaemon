TEMPLATE = app
DEPENDPATH += .

QT += svg network

contains(DEFINES, HAVE_MEEGOGRAPHICSSYSTEM) {
    QT += meegographicssystemhelper
}

DEFINES += MTHEME_PRINT_DEBUG
#DEFINES += CLOSE_ON_ENTER

# enable QString optimizations
DEFINES += QT_USE_FAST_CONCATENATION QT_USE_FAST_OPERATOR_PLUS

# Check for mixing of const and non-const iterators, 
# which can cause problems when built with some compilers:
DEFINES += QT_STRICT_ITERATORS

!win32:CONFIG += link_pkgconfig
PKGCONFIG += gobject-2.0
PKGCONFIG += x11
PKGCONFIG += mlite

# Input
SOURCES += main.cpp \
           mthemedaemonserver.cpp \
           mthemedaemon.cpp \
           mcommonpixmaps.cpp \
           mimagedirectory.cpp \
           mthemedaemonclient.cpp \
           mpixmaphandle.cpp \
           mthemedaemonprotocol.cpp \
           mcpumonitor.cpp \
           mgraphicssystemhelper.cpp \
           msystemdirectories.cpp

HEADERS += \
           mthemedaemonserver.h \
           mthemedaemon.h \
           mcommonpixmaps.h \
           mimagedirectory.h \
           mpixmaphandle.h \
           mthemedaemonclient.h \
           mthemedaemonprotocol.h \
           mcpumonitor.h \
           mgraphicssystemhelper.h \
           msystemdirectories.h \
           keypresswaiter.h

linux {
    HEADERS += inotify.h \
               inotify.watch.h \
               fstreenode.h \
               utils.h
    SOURCES += inotify.cpp \
               inotify.watch.cpp \
               fstreenode.cpp \
               utils.cpp
}

QMAKE_EXTRA_TARGETS += check
check.depends = $$TARGET
check.commands = $$system(true)

QMAKE_EXTRA_TARGETS += check-xml
check-xml.depends = $$TARGET
check-xml.commands = $$system(true)

target.path = /usr/bin
INSTALLS += target