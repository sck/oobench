APPLICATION=oobench
VERSION=0.5.0

DISTNAME=$(APPLICATION)-$(VERSION)
DISTFILE=$(DISTNAME).tar.gz
DISTFILE_SRCDOC=$(DISTNAME)-sourcedoc.tar.gz

.PHONY: all doc
all doc %::
	-@echo "Note: Use $(MAKE) help to get a list of useful targets."
	-@$(MAKE) -ki -C C++ $(MAKECMDGOALS)
	-@$(MAKE) -ki -C Objective-C $(MAKECMDGOALS)
	-@$(MAKE) -ki -C Java $(MAKECMDGOALS)
	-@$(MAKE) -ki -C doc $(MAKECMDGOALS)

ifndef IN_BENCH
.PHONY: bench
bench::
	@(\
	echo "#########################################################################"; \
	echo "OO Bench Version: $(VERSION)"; \
	echo "Operating System: `uname -rsm`"; \
	echo "#########################################################################"; \
	$(MAKE) IN_BENCH=1 clean; \
	$(MAKE) IN_BENCH=1 -ki && \
	$(MAKE) IN_BENCH=1 -ki bench ) 2>&1 | tee benchResult.txt
endif

ifndef IN_TESTS

.PHONY: testAndMail
testAndMail::
	rm -f testErrors.txt
	($(MAKE) IN_TESTS=1 clean; \
	$(MAKE) IN_TESTS=1 -ki && \
	$(MAKE) IN_TESTS=1 -ki test ) 2>&1 > testResult.txt | tee testErrors.txt
	if test -s testErrors.txt; then \
		cat testErrors.txt | \
			mail -s "[Daily Build & Test] Errors" \
			oobench-devel@lists.sourceforge.net; \
	fi
	

.PHONY: test
test::
	($(MAKE) IN_TESTS=1 clean; \
	$(MAKE) IN_TESTS=1 -ki && \
	$(MAKE) IN_TESTS=1 -ki test ) 2>&1 | tee testResult.txt
endif

.PHONY: help
help::
	@echo "Targets:"
	@echo "    <empty>        Configure and compile."
	@echo "    bench          Cleanup, compile, and run benchmarks."
	@echo "                   Results are logged to benchResult.txt."
	@echo "    test           Cleanup, make, and only test benchmarks."
	@echo "                   Results are logged to testResult.txt."
	@echo "    clean          Cleanup."
	@echo "    distclean      Also delete files that were created by"
	@echo "                   configure."
	@echo "Internal Targets:"
	@echo "    dist           Make distfile."
	@echo "    checkSpelling  Check spelling."


$(DISTFILE):
	@$(MAKE) distclean
	@$(MAKE) -C doc
	@echo "*** Making $(DISTFILE)"; \
	find . -type f | grep -v /CVS/ | \
		grep -v '/.cvsignore$$' | grep -v '/.tmp' | \
		grep -v '.swp' | grep -v '~' | grep -v '/localConf.sh' | \
		grep -v '/testResult.txt' | grep -v '.o$$' | \
		grep -v '.sp.ok' | grep -v 'doc/html' | \
		grep -v '.bin$$' | grep -v '.class$$' > .tmp.tarFiles ; \
	test -d .tmp || mkdir .tmp 2>/dev/null; \
	test -d .tmp/$(DISTNAME) || mkdir .tmp/$(DISTNAME) 2>/dev/null; \
	tar cfT - .tmp.tarFiles | tar xf - -C .tmp/$(DISTNAME); \
	tar cf - -C .tmp . | gzip -9c > $(DISTFILE); 
	@rm -rf .tmp.tarFiles .tmp

$(DISTFILE_SRCDOC):
	@$(MAKE) distclean
	@echo "*** Making $(DISTFILE_SRCDOC)"; \
	find . -type f | grep -v /CVS/ | \
		grep -v '/.cvsignore$$' | grep -v '/.tmp' | \
		grep -v '.swp' | grep -v '~' | grep -v '/localConf.sh' | \
		grep -v '/testResult.txt' | grep -v '.o$$' | \
		grep -v '.sp.ok' | grep 'doc/html' | \
		grep -v '.bin$$' | grep -v '.class$$' > .tmp.tarFiles ; \
	test -d .tmp || mkdir .tmp 2>/dev/null; \
	test -d .tmp/$(DISTNAME) || mkdir .tmp/$(DISTNAME) 2>/dev/null; \
	tar cfT - .tmp.tarFiles | tar xf - -C .tmp/$(DISTNAME); \
	tar cf - -C .tmp . | gzip -9c > $(DISTFILE_SRCDOC); 
	@rm -rf .tmp.tarFiles .tmp

.PHONY: _doc
_doc::
	$(MAKE) clean
	$(MAKE) doc

.PHONY: dist
dist:: _doc $(DISTFILE) $(DISTFILE_SRCDOC)
	@true

.PHONY: checkSpelling
checkSpelling::
	bspell --lang=EN COPYING
	bspell --lang=EN AUTHORS
	bspell --lang=EN NEWS
	bspell --lang=EN README
	bspell --lang=EN THANKS
	bspell --lang=EN common/PORTING
	bspell --lang=EN Objective-C/README
	bspell --lang=EN Java/README
	bspell --lang=EN TODO
	bspell --lang=EN C++/TODO
	bspell --lang=EN C++/README
	bspell --lang=EN Objective-C/TODO
	bspell --lang=EN Java/TODO
	bspell --lang=EN doc/oobench.tex.m4
	rm -f *.bak Java/*.bak Objective-C/*.bak C++/*.bak common/*.bak \
		doc/*.bak

