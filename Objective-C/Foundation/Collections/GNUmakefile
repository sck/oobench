PROJECT_ROOT=../..

.PHONY: all
all %:: 
	@$(MAKE) --no-print-directory -f NSArrayPerformance.mk \
            $(MAKECMDGOALS)
	@$(MAKE) --no-print-directory -f NSDictionaryPerformance.mk \
            $(MAKECMDGOALS)
	@$(MAKE) --no-print-directory -f NSSetPerformance.mk \
            $(MAKECMDGOALS)
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs::
	@$(MAKE) -C Sorting $(SUBTARGET)

include $(PROJECT_ROOT)/common/common.mk

.PHONY: bench test
bench test::
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

