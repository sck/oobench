PROJECT_ROOT=..

.PHONY: all
all %:
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs::
	@$(MAKE) -C Containers $(SUBTARGET)
	@$(MAKE) -C Algorithms $(SUBTARGET)
	@$(MAKE) -C Strings $(SUBTARGET)
