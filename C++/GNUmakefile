CONFIGFILES= \
	common/config.mk \
	common/config.h \

.PHONY: all clean bench test
all clean bench test:: $(CONFIGFILES)
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs:: $(CONFIGFILES)
	@$(MAKE) -C Patterns $(SUBTARGET)
	@$(MAKE) -C Exceptions $(SUBTARGET)
	@$(MAKE) -C IO $(SUBTARGET)
	@$(MAKE) -C Messages $(SUBTARGET)
	@$(MAKE) -C STL $(SUBTARGET)
	@$(MAKE) -C Threads $(SUBTARGET)
	@$(MAKE) -C Numerics $(SUBTARGET)

.PHONY: doc
doc:: $(CONFIGFILES)
	@$(MAKE) -C doc

$(CONFIGFILES): 
	@test -f ./localConf.sh && ./localConf.sh || ./configure

.PHONY: distclean
distclean:: clean
	rm -f config.cache config.log config.status $(CONFIGFILES)

	
