include $(PROJECT_ROOT)/common/config.mk
ifndef MACOSX_FOUNDATION_PRESENT
	CFLAGS= -g -O2 -Wall -Wno-import -I$(PROJECT_ROOT)/common \
		-I$(FOUNDATION_INCLUDE) $(LOCAL_CFLAGS)
	LDFLAGS= -L$(FOUNDATION_LIB) $(LOCAL_LDFLAGS)
else
	CFLAGS= -g -O2 -Wall -I$(PROJECT_ROOT)/common $(LOCAL_CFLAGS)
	LDFLAGS= $(LOCAL_LDFLAGS)
endif

LIBS= $(FOUNDATION_LIBS) $(OBJC_LIBS) $(LOCAL_LIBS)

.PHONY: app
app:: $(TARGET)
	@true

.PHONY: common
common::
	$(MAKE) -C $(PROJECT_ROOT)/common

%.o: %.m 
	$(CC) $(CFLAGS) -c -o $@ $< 

$(TARGET): $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OFILES) $(LIBS)

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
	cd $(PROJECT_ROOT); \
	rm -rf .tmp.idx; \
	mkdir .tmp.idx; \
	cp `find . -type f -name '*.[mh]' | grep -v '/.tmp'` .tmp.idx; \
	( \
		cd .tmp.idx; \
		re_mv.pl '$$_ =~ s/\.m$$/\.h/' *.m; \
	); \
	objcdoc --nosrc --include-src --index --frames --tree \
		-d doc/html `find .tmp.idx -type f -name '*.h'`; \
	rm -rf .tmp.idx; 

.PHONY: clean
clean::
	rm -f *.bin *.o *core *.core

.PHONY: distclean
distclean:: clean
    
