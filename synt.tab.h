
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BOOL = 258,
     INTEGER = 259,
     FLOAT = 260,
     CHAR = 261,
     mc_IF = 262,
     mc_WHILE = 263,
     mc_ELSE = 264,
     CST_SE = 265,
     CST_E = 266,
     mc_FOR = 267,
     mc_INRANGE = 268,
     mc_IN = 269,
     mc_AND = 270,
     mc_OR = 271,
     mc_NOT = 272,
     SUP = 273,
     INF = 274,
     SUPE = 275,
     INFE = 276,
     DIFF = 277,
     PLUS = 278,
     MOINS = 279,
     FOIS = 280,
     DIV = 281,
     ver = 282,
     PAROU = 283,
     PARFER = 284,
     ACOU = 285,
     ACFER = 286,
     DEUXP = 287,
     AFFECT = 288,
     IDF = 289,
     COM = 290,
     CST_CH = 291,
     CST_R = 292,
     CST_SR = 293,
     bool = 294
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 22 "synt.y"
char* str;int entier;float reel;double doubleValue;


/* Line 1676 of yacc.c  */
#line 95 "synt.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


