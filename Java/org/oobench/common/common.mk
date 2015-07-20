include $(PROJECT_ROOT)/org/oobench/common/config.mk
JAVA_FILES:=$(JAVA_FILES_ADD) $(wildcard *.java)
CLASS_FILES:=$(patsubst %.java,%.class,$(JAVA_FILES))
JAVAC=$(JAVAC13)

.PHONY: invokeAnt
invokeAnt:: 
	@echo "*** invoking ant"
	@$(ANT) $(MAKECMDGOALS)

.PHONY: all
all:: $(CLASS_FILES)

$(CLASS_FILES): $(JAVA_FILES)
	$(JAVAC) -classpath $(CLASSPATH) $(JAVA_FILES)

.PHONY: bench
bench::
	@sh ./bench.sh; \
	true

.PHONY: test
test::
	@sh ./bench.sh -t; \
	true

.PHONY: doc
doc::
	(\
		cd $(PROJECT_ROOT); \
		find . -type f -name '*.java' | grep -v '/.tmp' \
			> .tmp.allJavaFiles ; \
		javadoc -d doc @.tmp.allJavaFiles; \
	) 

.PHONY: clean
clean::
	rm -rf *.class .tmp* *.jar *.ear

.PHONY: distclean
distclean:: clean
	@true
