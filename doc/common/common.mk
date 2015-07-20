M4=gm4 -P
TEXMAIN=$(BASENAME).tex

.PHONY: all
all:: $(BASENAME).dvi $(BASENAME).pdf $(BASENAME).ps $(BASENAME).html
	-rm -f *.aux *.toc *.ps *.log $(TEXMAIN) .log WARNINGS

.PHONY: app bench test doc
app bench test doc::
	@true

.PHONY: dvi
dvi: $(BASENAME).dvi

.tmp.body: $(BASENAME).html
	perl -0777pe \
	's,.*<BODY[^>]*>(?:.*?<P>){2}(.*)</BODY[^>]*>.*,$$1,s;s,\boobench\.html\b,index.html,g' < \
		$(BASENAME).html > .tmp.body

www/index.html: .tmp.body
	perl -w ./tools/processSkel.pl body=.tmp.body < \
		www/skel/index.skel.html > www/index.html


.PHONY: text
$(BASENAME).html: $(BASENAME).tex.m4
	$(M4) -Doob_html=1 $< > $(TEXMAIN)
	latex2html -nonavigation -prefix .tmp.$(BASENAME). -noinfo -nosubdir \
		-split 0 $(TEXMAIN)
	perl -pi -e 's,1\#1,\&lt;,g;s,2\#2,\&gt;,g' $(BASENAME).html 
	lynx -dump -crawl $(BASENAME).html | \
		grep -v "^THE_TITLE:" | \
		grep -v "^THE_URL:" | \
		perl -pe 's/ö/oe/g' | \
		perl -pe 's/Ö/Oe/g' | \
		perl -pe 's/ü/ue/g' | \
		perl -pe 's/Ü/Ue/g' | \
		perl -pe 's/ä/ae/g' | \
		perl -pe 's/Ä/Ae/g' | \
		perl -pe 's/ß/ss/g' > $(BASENAME).txt
	rm -f .tmp.$(BASENAME).* index.html $(TEXMAIN)

$(BASENAME).dvi: $(BASENAME).tex.m4
	$(M4) -Doob_dvi=1 $< > $(TEXMAIN)
	latex $(TEXMAIN)
	latex $(TEXMAIN)
	rm -f $(TEXMAIN)

pdf: $(BASENAME).pdf

$(BASENAME).pdf: $(BASENAME).tex.m4
	$(M4) -Doob_pdf=1 $< > $(TEXMAIN)
	pdflatex $(TEXMAIN)
	rm -f $(TEXMAIN)

$(BASENAME).ps: $(BASENAME).dvi
	dvips -o $@ $(BASENAME).dvi

.PHONY: clean
clean::
	-rm -f *.aux *.dvi *.toc *.ps *.pdf *.log *.html *.txt *.css \
		$(TEXMAIN) .log WARNINGS

.PHONY: distclean
distclean:: clean
