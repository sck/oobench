PROJECT_ROOT=..

.PHONY: all
all %:
	@$(MAKE) SUBTARGET="$(MAKECMDGOALS)" subdirs

.PHONY: subdirs
subdirs::
	@$(MAKE) -C MVC $(SUBTARGET)
	@$(MAKE) -C Flyweight $(SUBTARGET)
