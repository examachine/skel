justmake == The GNU make only generic build scripts
---------------------------------------------------

exa aka Eray Ozkural
February 2001, Ankara

The makefile collection used in the skeleton code
is written from scratch to accomodate easy and flexible
build scripting. The "justmake" collection features
  * automake like interface
  * building multiple program and libraries in one dir
  * automatic compilation rules for c, c++, bison and flex
  * automatic dependency analysis
  * standard GNU targets
  * uses libtool
  * supports multiple build configurations: dbg, opt, optdbg
  * all output written to a working directory
  * lets you write your own code

among others. 
