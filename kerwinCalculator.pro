QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    calc.l \
    calc.y \
    mainwindow.h

FORMS += \
    mainwindow.ui

TRANSLATIONS += \
    kerwinCalculator_zh_CN.ts
CONFIG += lrelease
CONFIG += embed_translations

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#flex/bison sources
FLEXSOURCES += calc.l

BISONSOURCES += calc.y


#bison
bison.input = BISONSOURCES
bison.output = $$PWD/${QMAKE_FILE_BASE}_yacc.c
bison.commands = bison -d -o ${QMAKE_FILE_OUT}   ${QMAKE_FILE_IN}
bison.clean = $$$$PWD/${QMAKE_FILE_BASE}_yacc.c $$$$PWD/${QMAKE_FILE_BASE}_yacc.h
bison.variable_out = SOURCES
bison.CONFIG = target_predeps
QMAKE_EXTRA_COMPILERS += bison

#flex
flex.input = FLEXSOURCES
flex.output = $$PWD/${QMAKE_FILE_BASE}_lex.c
flex.commands = flex   -o${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
flex.clean = ${QMAKE_FILE_OUT}
flex.variable_out = SOURCES
flex.CONFIG = target_predeps
QMAKE_EXTRA_COMPILERS += flex

