include config.mk

.PHONY: all
all %::
	@$(MAKE) --no-print-directory -f ThreadCreationPerformance.mk \
            $(MAKECMDGOALS)
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs::
	@$(MAKE) -C Contention $(SUBTARGET)

include $(PROJECT_ROOT)/common/common.gmake
