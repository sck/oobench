CONFIGFILES= \
	common/config.mk \
	common/config.sh \

.PHONY: all clean bench test
all clean bench test:: $(CONFIGFILES)
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs:: $(CONFIGFILES)
	@$(MAKE) -C Messages $(SUBTARGET)
	@$(MAKE) -C Foundation $(SUBTARGET)
	@$(MAKE) -C Patterns $(SUBTARGET)

.PHONY: doc
doc:: $(CONFIGFILES)
	@$(MAKE) -C doc

$(CONFIGFILES): 
	@test -f ./localConf.sh && ./localConf.sh || ./configure

.PHONY: distclean
distclean:: 
	-@$(MAKE) clean
	rm -f config.cache config.log config.status $(CONFIGFILES)
