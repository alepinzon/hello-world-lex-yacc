#!/bin/bash

rm *.h
rm *.c
lex lexer.l
yacc parser.y -d