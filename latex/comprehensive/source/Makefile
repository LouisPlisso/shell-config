#############################################
# Build the Comprehensive LaTeX Symbol List #
# By Scott Pakin <scott+clsl@pakin.org>     #
#############################################

# Define TARGETS as a list of all of the files we intend to generate.
# TARGETS is categorized into TARGETS_SOURCE and TARGETS_DIST.
# TARGETS_DIST comprise the prebuilt distribution of the Comprehensive
# LaTeX Symbol List.  TARGETS_SOURCE are needed primarily to build
# TARGETS_DIST, although they are also distributed (in a "source"
# subdirectory).
TARGETS = $(TARGETS_SOURCE) $(TARGETS_DIST)

TARGETS_DIST = symbols-letter.pdf symbols-a4.pdf SYMLIST README

TARGETS_SOURCE = lightbulb.eps lightbulb10.pfb lightbulb.map

# There are a few files that we didn't generate but that need to be
# distributed.
EXTRADIST = symbols.tex lightbulb10.mf lightbulb.mf \
	    symbols.ist versicle.eps response.eps \
	    makefakeMnSymbol teubner-subset.sty Makefile

# We need FontForge (or the older PfaEdit) to generate lightbulb10.pfb.
FONTFORGE = fontforge

# The following should be overwritten in a recursive call to Make.
SIZE = letter
EXT = pdf

###########################################################################

# Build all specified formats in all specified paper sizes.
all: $(TARGETS)

.PHONY: all symbols dist clean mostlyclean

###########################################################################

# Define generic rules for building pdf/dvi/ps in letter/a4 size.
symbols: symbols.tex symbols.ist fakeMnSymbol.sty \
	 lightbulb.eps lightbulb10.pfb lightbulb.map
	# Pass 1: Produce a list of extra files to include in the custom dump.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) '\RequirePackage{snapshot}\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	cat symbols-$(SIZE)-$(EXT).dep | fgrep -v cmll | \
	  perl -ne '/\{(\w+\.fd)\}/ && print "\\input{$$1}\n"' > symbols-$(SIZE)-$(EXT).inc   
	# Pass 2: Dump a custom latex format.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) -ini \&$(LATEX) mylatex.ltx '\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	# Pass 3: Build a second time using the custom format to produce a
	# final page layout (one hopes).  Create an index based on that layout.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) \&symbols-$(SIZE)-$(EXT) symbols
	makeindex -s symbols.ist symbols-$(SIZE)-$(EXT)
	# Pass 4a: Build the document with the newly generated index.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) \&symbols-$(SIZE)-$(EXT) symbols
	# Pass 4b: Get a final symbol count, and put it in the .aux file.
	totalsymbols=`fgrep -c '\item \verb' symbols-$(SIZE)-$(EXT).ind` ; \
	  ( fgrep -v prevtotalsymbols symbols-$(SIZE)-$(EXT).aux > symbols-$(SIZE)-$(EXT).pts ; \
	    echo "\\gdef\\prevtotalsymbols{$$totalsymbols}" ; \
	    echo "\\gdef\\approxcount{}" ) >> symbols-$(SIZE)-$(EXT).pts ; \
	  mv symbols-$(SIZE)-$(EXT).pts symbols-$(SIZE)-$(EXT).aux
	# Pass 5: Build the final document using the final symbol count
	# and with the table of contents and PDF bookmarks correctly
	# reflecting the index pages.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) \&symbols-$(SIZE)-$(EXT) symbols
	mv symbols-$(SIZE)-$(EXT).$(EXT) symbols-$(SIZE).$(EXT)

###########################################################################

# Define specific rules for building different formats and sizes.
symbols-a4.pdf symbols-a4-pdf.log symbols-a4-pdf.ind: symbols.tex
	$(MAKE) $(MAKEFLAGS) SIZE=a4 LATEX=pdflatex EXT=pdf symbols

symbols-letter.pdf symbols-letter-pdf.log symbols-letter-pdf.ind: symbols.tex
	$(MAKE) $(MAKEFLAGS) SIZE=letter LATEX=pdflatex EXT=pdf symbols

symbols-a4.dvi symbols-a4-dvi.log symbols-a4-dvi.ind: symbols.tex
	$(MAKE) $(MAKEFLAGS) SIZE=a4 LATEX=latex EXT=dvi symbols

symbols-letter.dvi symbols-letter-dvi.log symbols-letter-dvi.ind: symbols.tex
	$(MAKE) $(MAKEFLAGS) SIZE=letter LATEX=latex EXT=dvi symbols

symbols-letter.ps: symbols-letter.dvi
	dvips -t letter -Pamz -Pcmz -j0 -o symbols-letter.ps symbols-letter.dvi

symbols-a4.ps: symbols-a4.dvi
	dvips -t a4 -Pamz -Pcmz -j0 -o symbols-a4.ps symbols-a4.dvi

###########################################################################

# Define rules to produce a lightbulb proof figure.
mfplain.mem:
	mpost -ini '\input mfplain; dump'

lightbulb.eps: lightbulb10.mf lightbulb.mf mfplain.mem
	mpost -mem mfplain '\mode:=proof; prologues:=2; labelfont cmr17; input lightbulb10'
	mv lightbulb10.65 lightbulb.eps

# Generate a FontForge script that makes the LightBulb10 PostScript
# names mixed case.
lightbulb10.pe:
	echo 'Open($$1);' > $@
	echo 'LB = "LightBulb";' >> $@
	echo 'SetFontNames(LB+"10", LB, LB+"10");' >> $@
	echo 'Generate("lightbulb10.pfb");' >> $@

# Define a rule to produce a Type 1 version of the LightBulb10 font.
lightbulb10.pfb: lightbulb10.mf lightbulb10.pe
	mftrace -V -fpfb --simplify lightbulb10
	$(FONTFORGE) -script lightbulb10.pe lightbulb10.pfb

# Define a rule to produce a LightBulb font-mapping file.
lightbulb.map:
	echo "lightbulb10 LightBulb10 <lightbulb10.pfb" > lightbulb.map

###########################################################################

# If we have MnSymbol.sty, generate a faked version which does not
# declare any new math alphabets.
fakeMnSymbol.sty: makefakeMnSymbol
	if [ "`kpsewhich MnSymbol.sty`" ] ; then \
	  makefakeMnSymbol `kpsewhich MnSymbol.sty` > $@ ; \
	else \
	  makefakeMnSymbol /dev/null > $@ ; \
	fi

###########################################################################

# The index is needed to produce a list of symbols.  We arbitrarily
# use the symbols-letter-pdf.ind version of the index.
symbols.ind: symbols-letter-pdf.ind
	cp symbols-letter-pdf.ind symbols.ind

# Create a list of all symbols.
SYMLIST: symbols.ind
	cat symbols.ind | perl -ne 's/.*\\verb\+([^+]+)\+.*/$$1/g && print' | sort -u > SYMLIST

# Create a README file.
README: makeREADME symbols-letter-pdf.log symbols.ind
	makeREADME symbols-letter-pdf.log symbols.ind > README

# Create a .tar.gz file.
comprehensive.tar.gz: $(TARGETS) $(EXTRADIST)
	$(RM) -r comprehensive
	mkdir comprehensive
	mkdir comprehensive/source
	install -m 664 $(TARGETS_DIST) comprehensive
	install -m 664 $(TARGETS_SOURCE) $(EXTRADIST) comprehensive/source
	cat symbols.tex | checksum > comprehensive/source/symbols.tex
	chmod 755 comprehensive/source/makefakeMnSymbol
	chmod 664 comprehensive/source/symbols.tex
	tar -czf comprehensive.tar.gz comprehensive
	$(RM) -r comprehensive

dist: comprehensive.tar.gz

# Clean up our mess.
clean: mostlyclean
	$(RM) comprehensive.tar.gz
	$(RM) $(TARGETS)
	$(RM) fakeMnSymbol.sty
	$(RM) mfplain.{log,mem}
	$(RM) lightbulb10*pk lightbulb10.{tfm,log,pe}

mostlyclean:
	$(RM) -r comprehensive
	$(RM) $(TARGETS_DIST)
	$(RM) symbols-*-*.{aux,dep,dvi,fmt,idx,ilg,inc,ind,log,out,pts,toc}
	$(RM) symbols.ind
