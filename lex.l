%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "synt.tab.h"
#include "ts.h"
int nb_ligne=1;
int col=1;
int sauvcol;
extern YYSTYPE yylval;
int nb=0;      
%}


lettre [a-zA-Z]
lettre_m [A-Z]
chiffre [0-9]
chiffre0[1-9]
IDF {lettre_m}({lettre}|{chiffre})*

com #(.|\t\n)*

cst_ch \'.\'
cst_sr ([\-](({chiffre0}({chiffre})*)|0)"."(({chiffre}({chiffre0})*)|0))
cst_se ([\-]({chiffre0}({chiffre})*))
cst_r (({chiffre0}({chiffre})*)|0)"."({chiffre}({chiffre0})*)
cst_e {chiffre}+
bool true|false


 
%%
"int"                       {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);yylval.str=strdup(yytext);return INTEGER;}
"float"                     {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);yylval.str=strdup(yytext);return FLOAT;}
"char"                      {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);yylval.str=strdup(yytext);return CHAR;}
"bool"                      {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);yylval.str=strdup(yytext);return BOOL;}
"if"                        {printf("entite reconu le nombre de col est %d\n",col);sauvcol=col;rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_IF;}
"while"                     {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_WHILE;}
"else"                      {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_ELSE;}
"for"                       {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_FOR;}
"in range"                  {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_INRANGE;}
"in"                        {rechercher (yytext,"Mot cle",0,0,1);col=col+strlen(yytext);return mc_IN;}
"and"                       {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return mc_AND;}
"or"                        {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);;return mc_OR;}
"not"                       {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return mc_NOT;}

">"                         {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return SUP;}
"<"                         {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return INF;}
">="                        {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return SUPE;}
"<="                        {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return INFE;}
"="                         {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return AFFECT;}
"!="                        {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return DIFF;}

"+"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return PLUS;}
"-"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return MOINS;}
"*"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return FOIS;}
"/"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return DIV;}

","                            {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return ver;}
"("                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return PAROU;}
")"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return PARFER;}
"["                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return ACOU;}
"]"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return ACFER;}
":"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return DEUXP;}
"!"                           {rechercher (yytext,"Mot cle",0,0,2);col=col+strlen(yytext);return mc_NOT;}

{com}                         {nb_ligne++;col=1;}
                            
{IDF}  		                  {if(yyleng>8){printf("erreur lexicale a la ligne %d et a la colonne %d \n",nb_ligne,col);}rechercher (yytext,"idf","",0,0);col=col+strlen(yytext);yylval.str=strdup(yytext);return IDF;}
{bool}  		              {rechercher (yytext,"cst_bool","bool",0,0);col=col+strlen(yytext);yylval.str=strdup(yytext);return bool;}
{cst_sr}                      {rechercher (yytext,"cst Sfloat","float",atof(yytext),0);col=col+strlen(yytext);yylval.reel=atof(yytext);return CST_SR;}
{cst_se}                      {if(atoi(yytext)<-32768){printf("erreur lexicale a la ligne %d et a la colonne %d \n",nb_ligne,col);}rechercher (yytext,"cst Sentiere","int",atoi(yytext),0);col=col+strlen(yytext);yylval.entier=atoi(yytext);return CST_SE;}
{cst_ch}                      {rechercher (yytext,"cst char","char",0,0);col=col+strlen(yytext);yylval.str=strdup(yytext);return CST_CH;}
{cst_r}                       {rechercher (yytext,"cst float","float",atof(yytext),0);col=col+strlen(yytext);yylval.reel=atof(yytext);return CST_R;}
{cst_e}                       {if(atoi(yytext)>32767){printf("erreur lexicale a la ligne %d et a la colonne %d \n",nb_ligne,col);}rechercher (yytext,"cst entiere","int",atoi(yytext),0);col=col+strlen(yytext);yylval.entier=atoi(yytext);return CST_E;}

[ \t]                         col=col+strlen(yytext);
\n                            nb_ligne++;col=1;
. {printf("erreur lexicale a la ligne %d et a la colonne %d entite %s \n",nb_ligne,col,yytext);}

%%