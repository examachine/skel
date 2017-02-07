#!/bin/sh

cat build/rules | sed 's/<newline>/\
/' >build/rules2
