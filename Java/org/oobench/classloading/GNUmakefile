PROJECT_ROOT=../../..
TMPCLASSPATH=.tmp
CLASSPATH=$(PROJECT_ROOT):$(TMPCLASSPATH)
JAVA_FILES_ADD= YYY/ExampleClassXXXX.java
CLASSESCOUNT=400

.PHONY: first
first:: makeFirst second makeSecond

.PHONY: makeFirst makeSecond
makeFirst makeSecond:: 
	$(MAKE) all

.PHONY: rmLoader
rmLoader::
	-rm -f ClassLoadingPerformance.java ClassLoadingPerformance.class

.PHONY: second
second::
	@echo "manifying YYY/ExampleClassXXXX.class ..."
	$(PERL) -w ./manifyClass.pl $(CLASSESCOUNT)

.PHONY: clean
clean:: rmLoader
	rm -rf .tmp*

include $(PROJECT_ROOT)/org/oobench/common/common.mk
