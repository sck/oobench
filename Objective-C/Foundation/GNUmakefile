PROJECT_ROOT=..

.PHONY: all
all %:
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs::
	@$(MAKE) -C Archiving $(SUBTARGET)
	@$(MAKE) -C Collections $(SUBTARGET)
	@$(MAKE) -C Exceptions $(SUBTARGET)
