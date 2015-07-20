PROJECT_ROOT=../..

LOCAL_CFLAGS=-I common

TARGET=MVCPerformance.bin

OFILES= \
	common/View.o \
	common/Model.o \
	common/Controller.o \
	common/ControllerEvent.o \
	common/Observer.o \
	InvalidRgbFormatException.o \
	DumbColorsView.o \
	ColorsModel.o \
	ColorsController.o \
	MVCPerformance.o \

all:: app

include $(PROJECT_ROOT)/common/common.mk

clean::
	rm -f common/*.o
