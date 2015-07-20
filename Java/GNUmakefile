CONFIGFILES= \
	org/oobench/common/config.mk \
	org/oobench/common/config.sh \
	org/oobench/common/ant.common.xml \
	
.PHONY: all bench clean test
all bench clean test:: $(CONFIGFILES)
	@$(MAKE) -ki SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs:: $(CONFIGFILES)
	@$(MAKE) -C org/oobench $(SUBTARGET)

.PHONY: doc
doc:: $(CONFIGFILES)
	@$(MAKE) -C doc 

$(CONFIGFILES): 
	@test -f ./localConf.sh && ./localConf.sh || ./configure

.PHONY: distclean
distclean:: clean
	rm -f config.cache config.log config.status $(CONFIGFILES)
