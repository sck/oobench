PROJECT_ROOT=../..

.PHONY: all
all %:: 
	@$(MAKE) --no-print-directory -f ExceptionsPerformance.mk \
		$(MAKECMDGOALS)
	@$(MAKE) --no-print-directory -f WithoutExceptionsPerformance.mk \
            $(MAKECMDGOALS)

include $(PROJECT_ROOT)/common/common.mk
