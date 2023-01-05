%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ts.h"
extern char *tab1[1000];
extern char *tab2[1000];
extern char *tab3[1000];
char sauvid[20];
char sauvid2[20];
char sauvtyp[20];
float sauvval;

int yylex();
int yyerror(char *);
extern FILE* yyin;
extern int nb_ligne, col, sauvcol;;
int i=0;
int j;

%}
%union{char* str;int entier;float reel;double doubleValue;}

%token <str>BOOL <str>INTEGER <str>FLOAT <str>CHAR  mc_IF mc_WHILE mc_ELSE <entier>CST_SE <entier>CST_E mc_FOR mc_INRANGE mc_IN mc_AND mc_OR mc_NOT SUP INF SUPE INFE DIFF PLUS MOINS FOIS <str>DIV ver PAROU PARFER ACOU ACFER DEUXP AFFECT  <str>IDF COM  <str>CST_CH <reel>CST_R <reel>CST_SR <str>bool 
%start S

%%

S: PRO {printf("programme syntaxiquement correcte \n\n");YYACCEPT;}
PRO:DEC_VAR PRO
    |INST PRO
	|
	;
/**************************************************PARTIE DECLARATION*********************************************/
DEC_VAR: L_CONST1 DEC_VAR
		|TAB
	    |L_VAR 
		|
  ;
/*declaration d'un tableau*/                   /*verifier la double declaration et inserer le type de l'idf*/                       
TAB:TYPE IDF ACOU CST_E ACFER  {if (doubledeclaration($2)==0) {inserertype($2,sauvtyp);}
                               else printf("erreur semantique ligne%d :entite %s : double declaration\n",nb_ligne,$2);
                               }
    |         
;

/*type */
TYPE:INTEGER        {
	                strcpy(sauvtyp,$1);
                    }
           
	|FLOAT         {
	                strcpy(sauvtyp,$1);
                    }
	            
	|BOOL      		{
	                strcpy(sauvtyp,$1);
                      }	
	            
	|CHAR         	{
	                 strcpy(sauvtyp,$1);
                    }
;
/*declaration d'une constante*/
L_CONST1: IDF AFFECT CONS  /*verifier la double declaration d'une constante*/  
                                                {	 /*modifie le champs type pour reconaitre que c'est un idf d'une cst*/
													 if(doubledeclaration($1)==0){
													 modifiecst($1,sauvid);
													 insererval($1,sauvval);
													 }
													 else{
													 if( comparetype($1,sauvid)!=0)
														printf("erreur semantique a la ligne %d incompatibilite des type %s doit etre %s\n ",nb_ligne,$1,sauvid); 
													 else
													  insererval($1,sauvval);
													}
												} 
		    |
;

/*la liste des cosntante */
CONS:  CST_CH      {strcpy(sauvid,"char");
                     sauvval=0;
                    }
	  |CST_E   {     strcpy(sauvid,"int");
	                i++;
	                 sauvval=$1;
                }    
	  |PAROU PLUS CST_E PARFER  {
		                         strcpy(sauvid,"int");
	                             sauvval=$3;
                                 }
	  |CST_R  {      strcpy(sauvid,"float");
	                 sauvval=$1;
                }
	  |PAROU PLUS CST_R PARFER   { strcpy(sauvid,"float");
	                               sauvval=$3;
                                  }
	  |cst_SE
	  |cst_SR
	  |bool   { strcpy(sauvid,"bool");
	            sauvval=0;
                                  }
	  |
;

/*constante signe entiere negatif*/
cst_SE:PAROU CST_SE PARFER    {strcpy(sauvid,"int");
	                           sauvval=$2;
                              }
;

/*constante signe reel negatif*/
cst_SR:PAROU CST_SR PARFER   { strcpy(sauvid,"float");
	                           sauvval=$2;
                              }
;


/*declaration des variables */
L_VAR:  TYPE L_DEC   
        |
;


L_DEC:  IDF ver L_DEC    {
	                              inserertype($1,sauvtyp);
                         }
       |IDF             {
	                              inserertype($1,sauvtyp);
                        }
	   |  
;
/***********************************************PARTIE INSTRUCTION**********************************************/


INST: INS   
	 |
;

INS: |affectation
	 |CO
	 |BOU
	 |
;

/**************************************************AFFECTATION******************************************************/
affectation: /*affectation d'une expression arithmetique a un idf*/
            IDF AFFECT EXP_AR  /*verifier la declaration de l'idf*/
                                {if (doubledeclaration($1)==0){ 
                                printf("erreur semantique ligne%d :entite %s : non declarer\n",nb_ligne,$1);}
								 if(comparetype($1,sauvid)!=0)
											   printf("erreur semantique a la ligne %d incompatibilite des type \n",nb_ligne);					  
				                }
			|IDF AFFECT PAROU EXP_AR PARFER P 
			                                 /*verifier la declaration de l'idf*/
                                            {if (doubledeclaration($1)==0){ 
                                            printf("erreur semantique ligne%d :entite %s : non declarer\n",nb_ligne,$1);}
												
								            }
			/*affectation d'un idf a un idf*/
			|IDF AFFECT IDF                   { /*les 2 idfs non declarer*/
			                                  if((doubledeclaration($1)==0)&&(doubledeclaration($3)==0)) 
		                                          printf("erreur semantique a la ligne %d entiter non declarer \n",nb_ligne);
		                                      else{/*les $1 non declarer et $3 declarer*/
											       /*affecter la valeur et type de $3 a $1*/
												if(doubledeclaration($1)==0){ /*$1 non declarer inserer le type de $3*/
                                                     inserertype($1,$3);
													 inserervalidf($1,$3);
												}
												else{/*les $3 non declarer*/
												if(doubledeclaration($3)==0)
												printf("erreur semantique a la ligne %d entiter %s non declarer \n ",nb_ligne,$3);
												}
											  }/*les 2 idfs declarer verifier les types*/
											  if((doubledeclaration($1)!=0)&&(doubledeclaration($3)!=0)){
											   if(comparetype($1,$3)!=0)
											   printf("erreur semantique a la ligne %d incompatibilite des type %s et %s \n",nb_ligne,$1,$3); }
											}
		    |
			;

EXP_AR: IDF EXP {if (doubledeclaration($1)==0){ 
                   printf("erreur semantique ligne%d :entite %s : non declarer\n",nb_ligne,$1);}
				  }
		|CST_E EXP {strcpy(sauvid,sauvid2);}
		|CST_R EXP  {strcpy(sauvid,sauvid2);}
		|cst_SE EXP  		
		|cst_SR EXP 
;
EXP: PLUS E4  
     |E1	
 ;
 
E1: MOINS E4
     |E2
;

E2: FOIS E4
    |E3
;

/*verifier la division sur 0 et le diviseur doit etre entier*/
E3: DIV E4           {{if (sauvval==0)printf("erreur semantique ligne %d:entite %d :DIVISION SUR 0\n",nb_ligne,sauvval); }}   
    

;

E4: IDF              /*verifier  declaration de l'idf dans la partie declaration */
                    {if (doubledeclaration($1)==0){ 
                    printf("erreur semantique ligne %d :entite %s : non declarer\n",nb_ligne,$1);}
				    }                  
	                 /*sauvgarder l'entite pour verifier la division sur 0*/
	|CST_E        {sauvval=$1;strcpy(sauvid2,"int");}
	|CST_R          
	|cst_SE         
	|cst_SR         
    |EXP_AR
;

P:  A PAROU EXP_AR PARFER  P
   |A IDF 
   |A CST_E                  
   |A CST_R  
   |DIV PAROU EXP_AR PARFER  P
   |DIV IDF 
   |DIV CST_E 
   |DIV CST_R
   |
   ;
A:PLUS
  |MOINS
  |FOIS
;
/************************************************CONDITION*****************************************************/
cond:  id1 CP id1 
       |PAROU id1 CP id1 PARFER
;

id1:IDF     {if (doubledeclaration($1)==0){ 
                    printf("erreur semantique a la ligne %d entite %s non declarer\n",nb_ligne,$1);}
				    }           
    |CONS
;

CP: SUP
    |SUPE
    |INF
	|INFE
	|AFFECT
	|DIFF
;
/****************************************************IF**********************************************************/
 CO: mc_IF PAROU N cond PARFER DEUXP L_INS 
    |mc_IF PAROU N cond mc_AND N cond PARFER DEUXP L_INS 
    |mc_IF PAROU N cond mc_OR N cond PARFER DEUXP L_INS 
	|mc_IF PAROU N cond PARFER DEUXP L_INS mc_ELSE DEUXP L_INS
	|mc_IF PAROU N cond mc_AND N cond PARFER DEUXP L_INS mc_ELSE DEUXP L_INS 
	|mc_IF PAROU N cond mc_OR N cond PARFER DEUXP L_INS mc_ELSE DEUXP L_INS 
 
 ;
 N: mc_NOT
  |
;
/*la liste d'instruction ne doit pas contenire des declaration*/
 L_INS: INST 
        | 
;
/*******************************************************BOUCLE***************************************************/
BOU:  mc_WHILE PAROU N cond PARFER DEUXP L_INS      {$$ = createOp("While", 2, $3, $6);}
	 |mc_FOR IDF mc_IN IDF  DEUXP L_INS     
	 |mc_FOR IDF mc_INRANGE PAROU CST_E ver CST_E PARFER DEUXP L_INS 
;

%%
int yywrap()
{}
int yyerror(char* msg)
{printf("erreur syntaxique a la ligne %d et a la collone %d\n",nb_ligne,col);}
int main()
{
  yyparse();
  afficher();
  printQuads();
  return 0;
}
