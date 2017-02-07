#
# makefile for g++
#
# by exa
#

SHELL = /bin/sh

.SUFFIXES:

PROJECT = default

srcdir = .
curdir := $(shell pwd)
parentdir := $(shell cd ..;pwd)
dirname := $(subst $(parentdir)/,,$(curdir))

# Project files

EXEC = exa
OBJS = Application.o
CXXFILES = Application.cxx
CCFILES = 
CFILES =
AFILES =
INCFILES = General.hxx
GRAMMARFILES =
LEXFILES =
LIBS =

IMPLEMENTATION = $(CXXFILES) $(AFILES) $(GRAMMARFILES) $(LEXFILES)
INTERFACE = $(INCFILES)
SRC = $(IMPLEMENTATION) $(INTERFACE)
VERSUFFIX:=,v
#VER = $(addsuffix $(VERSUFFIX), $(SRC))
AUX = Makefile def.cxx def.hxx
ARCHIVE = $(PROJECT).zip
ARCPATH = /home/exa/arc

INCLUDEDIR =
LIBDIR =
PROG = -o $(EXEC)

# Options

CXXOPTIMISE =
CXXDEBUG = -g
CPPFLAGS =
CXXFLAGS = $(CXXDEBUG) $(CXXOPTIMISE)
ASFLAGS =
LDFLAGS = $(CXXDEBUG)

# Programs used

MAKE =	make
CC =	gcc
CXX =	g++
ASM =	as
BISON =	bison --defines
FLEX =	flex
LS =	ls -l
CP =    cp --interactive
ED =	emacs
LATEX = latex

# Rules

# Pattern Rules

# Automatic dependency rules

%.d: %.cxx
	@echo Generating dependencies for $*.cxx
	@$(SHELL) -ec '$(CXX) -MM $(CPPFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' > $@'
%.d: %.cc
	@echo Generating dependencies for $*.cc
	@$(SHELL) -ec '$(CXX) -MM $(CPPFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' > $@'
%.d: %.c
	@echo Generating dependencies for $*.c
	@$(SHELL) -ec '$(CXX) -MM $(CPPFLAGS) $< \
                 | sed '\''s/$*\\.o[ :]*/& $@/g'\'' > $@'

# Compilation rules

%.o : %.cxx
	@echo Compiling $<
	@$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@
%.o : %.cc
	@echo Compiling $<
	@$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@
%.o : %.c
	@echo Compiling $<
	@$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@
%.dvi : %.tex
	@echo Compiling $<
	@$(LATEX) $<

# Flex - Bison rules

%.tab.c %.tab.h : %.grammar %.hxx
	$(BISON) $< --output-file=$*.tab.c

%.flex.c : %.flex %.tab.h %.hxx
	$(FLEX) -o$@ $<

# Phony Targets

.PHONY: all compileinfo clean realclean list listsrc \
	arc listarc extractarc backup restore

# Default rule

all: defaultmesg compileinfo $(EXEC)

defaultmesg:
	@echo Default rule invoked, building everything

compileinfo:
	@echo C++ flags: $(CXXFLAGS)
	@echo C preprocessor flags: $(CPPFLAGS)

$(EXEC): $(OBJS)
	@echo Building executable: $(EXEC)
	@echo LD flags: $(LDFLAGS)
	@echo Libraries used: $(LIBS)
	@$(CXX) $(LDFLAGS) $(LIBDIR) $(INCLUDEDIR) $(OBJS) $(LIBS) $(PROG)

# Include automatic dependencies
include $(CXXFILES:.cxx=.d)
include $(CCFILES:.cc=.d)
include $(CFILES:.c=.d)

clean:
	@echo Deleting object modules and executables
	@-rm $(OBJS) $(EXEC)

distclean: clean
	@echo Deleting archive
	@-rm $(ARCHIVE)

realclean: distclean
	@echo Deleting miscallenous files
	@-rm *.bak *~

list:
	$(LS) $(SRC) $(AUX)

listsrc:
	$(LS) $(SRC)

# Archive

arc:	$(ARCHIVE)

listarc:
	@echo Listing content of tar archive
	@tar tzvf $(ARCHIVE) 

extractzip:
	@cd .. ;\
	echo Extracting from tar archive ;\
	tar xzvf $(dirname)/$(ARCHIVE)

updatearc:
	@cd .. ;\
	echo Updating tar archive ;\
	tar uzvf $(dirname)/$(ARCHIVE) $(addprefix $(dirname)/,$?)
			
$(ARCHIVE): $(SRC) $(VER) $(AUX)
	@cd .. ;\
	echo Creating tar archive ;\
	tar czvf $(dirname)/$(ARCHIVE) $(addprefix $(dirname)/,$?)

backup:
	@echo Backing up archive
	@$(CP) $(ARCHIVE) $(ARCPATH)

restore:
	@echo Restoring archive
	@$(CP) $(ARCPATH)/$(ARCHIVE) .


