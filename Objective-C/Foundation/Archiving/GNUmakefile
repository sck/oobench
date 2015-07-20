PROJECT_ROOT=../..

.PHONY: all
all %:: 
	@$(MAKE) --no-print-directory -f ArchivingPerformanceSimple.mk \
            $(MAKECMDGOALS)
	@$(MAKE) --no-print-directory -f ArchivingPerformanceComplex.mk \
            $(MAKECMDGOALS)

include $(PROJECT_ROOT)/common/common.mk
