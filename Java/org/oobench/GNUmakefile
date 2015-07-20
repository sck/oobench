PROJECT_ROOT=../..
include $(PROJECT_ROOT)/org/oobench/common/config.mk

.PHONY: build
build::
	@$(ANT) $(MAKECMDGOALS)
	@$(MAKE) -C classloading $(MAKECMDGOALS)
	@$(MAKE) -C corba $(MAKECMDGOALS)
	@if test "X$(AS_SERVER)" = "Xno"; then \
		echo "No Application Server present.  EJB skipped."; \
	else \
		$(MAKE) -C ejb $(MAKECMDGOALS); \
	fi;


.PHONY: all
all %::
	@$(MAKE) -C patterns $(MAKECMDGOALS)
	@$(MAKE) -C classloading $(MAKECMDGOALS)
	@$(MAKE) -C collections $(MAKECMDGOALS)
	@$(MAKE) -C corba $(MAKECMDGOALS)
	@if test "X$(AS_SERVER)" = "Xno"; then \
		echo "No Application Server present.  EJB skipped."; \
	else \
		$(MAKE) -C ejb $(MAKECMDGOALS); \
	fi;
	@$(MAKE) -C exceptions $(MAKECMDGOALS)
	@$(MAKE) -C io $(MAKECMDGOALS)
	@$(MAKE) -C messages $(MAKECMDGOALS)
	-@$(MAKE) -C rmi $(MAKECMDGOALS)
	@$(MAKE) -C serialization $(MAKECMDGOALS)
	@$(MAKE) -C threads $(MAKECMDGOALS)
	#@$(MAKE) -C datafiles $(MAKECMDGOALS)
	@$(MAKE) -C numerics $(MAKECMDGOALS)

include $(PROJECT_ROOT)/org/oobench/common/config.mk
