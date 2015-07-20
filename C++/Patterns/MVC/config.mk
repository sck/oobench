PROJECT_ROOT=../..
SUBTARGETS= \
	MVCPerformance \

LOCAL_CFLAGS=-I common
LOCAL_OFILES= \
	common/View$(OBJ) \
	common/Model$(OBJ) \
	common/Controller$(OBJ) \
	common/ControllerEvent$(OBJ) \
	common/Observer$(OBJ) \
	InvalidRgbFormatException$(OBJ) \
	DumbColorsView$(OBJ) \
	ColorsModel$(OBJ) \
	ColorsController$(OBJ) \
	MVCBenchmark$(OBJ) \

