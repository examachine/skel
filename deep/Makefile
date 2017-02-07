#
# generic makefile for g++
#
# by exa aka Eray Ozkural 2001
# see COPYING file that comes with this distribution

SHELL = /bin/sh

.SUFFIXES: .c .cc .cxx .o .flex .flex.c .bison .bison.c .tex .dvi

PACKAGE = deep
SUBDIRS = dir1 dir2
VERSION = 0.0.1
BUILDARCH = i686
# valid build configs : dbg, opt, optdbg
BUILD = dbg

# Definitions

include build/Makefile.first
include build/Makefile.kludge
include build/Makefile.dirs
include build/Makefile.files
include build/Makefile.options
include build/Makefile.utilities

# Rules
include build/Makefile.pattern-rules
include build/Makefile.rules
include build/Makefile.commands
include build/Makefile.automatic-dependencies

include build/Makefile.recursive

include build/Makefile.test
include build/Makefile.last
