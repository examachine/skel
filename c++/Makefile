#
# makefile for g++
#
# by exa
#

SHELL = /bin/sh

.SUFFIXES: .c .cc .cxx .o .flex .flex.c .bison .bison.c .tex .dvi

PROJECT = exa
VERSION = 0.01
BUILDARCH = i686
# valid build configs : dbg, opt, optdbg
BUILD := dbg

# Directories

srcdir = ./src
builddir := $(shell pwd)
parentdir := $(shell cd ..; pwd)
dirname := $(subst $(parentdir)/,,$(builddir))
# CODE: Allow different configs to co-exist
workingdir = ./$(BUILD)
VPATH = $(srcdir) $(workingdir)
#vpath %.cc $(srcdir)

# Project files

EXEC = app	# Executable

# Object Files

OBJS = Application.o

# Source Files

CXXFILES =
CCFILES = Application.cc
CFILES =
AFILES =
INCFILES = General ANSILibrary
BUILDFILES = Makefile
GRAMMARFILES =
LEXFILES =

# Documentation

TEXFILES =
DVIFILES = $(addsuffix .dvi, $(basename $(TEXFILES)))
DOCFILES = $(TEXFILES)

# Top level classification of source files

IMPLEMENTATION = $(CXXFILES) $(CCFILES) $(CFILES) $(AFILES) $(GRAMMARFILES)
INTERFACE = $(INCFILES)
SRC = $(IMPLEMENTATION) $(INTERFACE) $(BUILDFILES)
VERSUFFIX:=,v
#VER = $(addsuffix $(VERSUFFIX), $(SRC)) # BUG: gives rise to wrong dep.

DOC = $(DOCFILES)

AUX =
ARCHIVE = $(PROJECT)-$(VERSION).tar.gz
ARCPATH = $HOME/arc
OBJFILES := $(addprefix $(workingdir)/,$(OBJS))

# System Resources

LIBS =
INCLUDEDIR =
LIBDIR =

# Options

GENERAL_DEBUG = -g -DDEBUG # -pg -a
GENERAL_OPTIMISE = -O3
GENERAL_WARN = -Wcomment -Wimplicit -Wmain -Wswitch
GENERAL_OTHER = -march=$(BUILDARCH)
CPPFLAGS =
CXXOPTIMISE =
CXXDEBUG =
CXXWARN = -ftemplate-depth-64 #-Wtemplate-debugging -Weffc++
CXXOTHER = -foperator-names
CXXFLAGS = $(GENERAL_WARN) $(GENERAL_OTHER) $(CXXWARN) $(CXXOTHER)
COPTIMISE =
CDEBUG =
CWARN =
COTHER = 
CFLAGS = $(GENERAL_WARN) $(GENERAL_OTHER) $(CWARN) $(COTHER)
ASFLAGS =
LDFLAGS =

ifeq ($(BUILD),dbg)
CFLAGS += $(GENERAL_DEBUG) $(CDEBUG)
CXXFLAGS += $(GENERAL_DEBUG) $(CXXDEBUG)
endif
ifeq ($(BUILD),opt)
CFLAGS += $(GENERAL_OPTIMISE) $(COPTIMISE)
CXXFLAGS += $(GENERAL_OPTIMISE) $(CXXOPTIMISE)
endif
ifeq ($(BUILD),optdbg)
CFLAGS += $(GENERAL_OPTIMISE) $(COPTIMISE) $(GENERAL_DEBUG) $(CDEBUG)
CXXFLAGS += $(GENERAL_OPTIMISE) $(CXXOPTIMISE) $(GENERAL_DEBUG) $(CXXDEBUG)
endif

# Programs used

#MAKE =	make		# For subsequent make's
CC =	gcc		# C compiler
CXX =	g++		# C++ compiler
ASM =	as		# Assembler (self arch)
LD = 	g++		# Linker
BISON =	bison --defines	# Syntax Analyzer
FLEX =	flex		# Lexical Analyzer
LS =	ls -l
CP =    cp --backup --version-control=numbered --preserve --recursive
ED =	emacs
LATEX = latex
BIBTEX = bibtex
PAGER = most

# Tool Options

OUTPUTFLAG = -o 	# Flag for output

# Rules

# Pattern Rules

# Automatic dependency rules

# C/C++

%.d: %.cxx
	@echo Generating dependencies for $*.cxx
	@echo -n "$(workingdir)/" > $@
	@$(SHELL) -ec '$(CXX) -MM $(CPPFLAGS) $(CXXFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' >> $@'
%.d: %.cc
	@echo Generating dependencies for $*.cc
	@echo -n "$(workingdir)/" > $@
	@$(SHELL) -ec '$(CXX) -MM $(CPPFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' >> $@'
%.d: %.c
	@echo Generating dependencies for $*.c
	@$(SHELL) -ec '$(CC) -MM $(CPPFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' > $@'

# Compilation rules

# C/C++

$(workingdir)/%.o : %.cxx
	@echo Compiling $<
	@$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@
$(workingdir)/%.o : %.cc
	@echo Compiling $<
	@$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@
%.o : %.c
	@echo Compiling $<
	@$(CC) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@

# Flex - Bison rules

%.tab.c %.tab.h : %.grammar %.hxx
	$(BISON) $< --output-file=$*.tab.c

%.flex.c : %.flex %.tab.h %.hxx
	$(FLEX) -o$@ $<

# Other compilers

%.dvi : %.tex
	@echo Compiling latex to dvi $<
	@$(LATEX) $<

# Phony Targets

.PHONY: all compileinfo checkdir clean realclean list listsrc \
	arc listarc extractarc rmarc backup restore edit

# Default rule

all: defaultmesg TAGS compileinfo checkdir $(EXEC) $(DOC)

defaultmesg:
	@echo Default rule invoked, building everything.

compileinfo:
	@echo Project name: $(PROJECT) 
	@echo C preprocessor flags: $(CPPFLAGS)
	@echo C flags: $(CFLAGS)
	@echo C++ flags: $(CXXFLAGS)
	@echo Build architecture: $(BUILDARCH)
	@echo Build configuration: $(BUILD)

checkdir:
	@if [ ! -d $(workingdir) ]; then mkdir $(workingdir); fi

$(EXEC): $(OBJFILES)
	@echo Building executable: $(EXEC)
	@echo LD flags: $(LDFLAGS)
	@echo Libraries used: $(LIBS)
	@$(LD) $(LDFLAGS) $(CXXFLAGS) $(LIBDIR) $(INCLUDEDIR) \
	       $^$(LIBS) $(OUTPUTFLAG) $@

TAGS:	$(SRC)
	@echo Building Emacs tags
	@etags $^

# Include automatic dependencies
#ifdef $(CXXFILES)
#include $(CXXFILES:.cxx=.d)
#endif

#ifdef $(CCFILES)
include $(CCFILES:.cc=.d)
#endif

ifdef $(CFILES)
include $(CFILES:.c=.d)
endif

# Clean commands

clean:
	@echo Deleting object modules and executables
	@-rm -rf $(OBJFILES) $(EXEC)
	@-rmdir $(workingdir)

distclean: clean
	@echo Deleting archive
	@-rm -rf $(ARCHIVE)

maintainer-clean: distclean
	@echo Deleting miscallenous files
	@-rm -rf *.bak *~

realclean: maintainer-clean
	@-rm -rf *.d

# List commands

list: $(SRC) $(AUX)
	@$(LS) $^

listsrc: $(SRC)
	@$(LS) $^

# Archive

arc:	$(ARCHIVE)

listarc:
	@echo Listing content of tar archive; \
	tar tzvf $(ARCHIVE) | $(PAGER)

$(ARCHIVE): $(SRC) $(VER) $(DOC) $(AUX)
	@cd .. ;\
	echo Creating tar archive $(ARCHIVE);\
	tar czvf $(dirname)/$(ARCHIVE) $(addprefix $(dirname)/,$?)

extractarc:
	@cd .. ;\
	echo Extracting from tar archive $(ARCHIVE);\
	tar xzvf $(dirname)/$(ARCHIVE)

updatearc:
	@cd .. ;\
	echo Updating tar archive $(ARCHIVE);\
	tar uzvf $(dirname)/$(ARCHIVE) $(addprefix $(dirname)/,$?)

rmarc:
	@Removing tar archive
	@-rm -rf $(ARCHIVE)

backup: $(ARCHIVE)
	@echo Backing up archive $(ARCHIVE)
	@$(CP) $(ARCHIVE) $(ARCPATH)

restore:
	@echo Restoring archive
	@$(CP) $(ARCPATH)/$(ARCHIVE) .

edit:	$(SRC)
	@echo Invoking editor for all source files
	@$(ED) $^&

