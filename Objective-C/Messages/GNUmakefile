PROJECT_ROOT=..

.PHONY: all
all %:: 
	@$(MAKE) --no-print-directory -f StaticPerformance.mk $(MAKECMDGOALS)
	@$(MAKE) --no-print-directory -f VirtualPerformance.mk $(MAKECMDGOALS)

include $(PROJECT_ROOT)/common/common.mk 
