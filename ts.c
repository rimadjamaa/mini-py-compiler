/****************CREATION DE LA TABLE DES SYMBOLES ******************/
/***Step 1: Definition des structures de données ***/
#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include<stdbool.h>
#include <stdarg.h>
#include "ts.h"
// test quads
int sIndex = -1, aIndex = -1, tabCount = 0, tIndex = 0 , lIndex = 0, qIndex = 0, nodeCount = 0;
node *rootNode;
char *tString = NULL, *lString = NULL;
Quad *allQ = NULL;
// test quads

element tab[1000];
elt tabs[40],tabm[40];
extern char sav[20];
char chaine [] = "";

char *tab1[1000];
/***Step 2: initialisation de l'état des cases des tables des symbloles***/
/*0: la case est libre    1: la case est occupée*/

void initialisation()
{
  int i;
  for (i=0;i<25;i++)
  {
	  tab[i].state=0; 
	  strcpy(tab[i].type,chaine); 

  }
  
  

  for (i=0;i<40;i++)
    {tabs[i].state=0;
    tabm[i].state=0;}

}


/***Step 3: insertion des entititées lexicales dans les tables des symboles ***/

void inserer (char entite[], char code[],char type[],float val,int i,char y)
{
  switch (y)
 { 
   case 0:/*insertion dans la table des IDF et CONST*/
       tab[i].state=1;
       strcpy(tab[i].name,entite);
       strcpy(tab[i].code,code);
	     strcpy(tab[i].type,type);
	     tab[i].val=val;
	   break;

   case 1:/*insertion dans la table des mots clés*/
       tabm[i].state=1;
       strcpy(tabm[i].name,entite);
       strcpy(tabm[i].type,code);
       break; 
    
   case 2:/*insertion dans la table des séparateurs*/
      tabs[i].state=1;
      strcpy(tabs[i].name,entite);
      strcpy(tabs[i].type,code);
      break;
 }

}

/***Step 4: La fonction Rechercher permet de verifier  si l'entité existe dèja dans la table des symboles */
void rechercher (char entite[], char code[],char type[],float val,int y)	
{

int j,i;

switch(y) 
  {
   case 0:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0; ((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
        if((i<1000)&&(strcmp(entite,tab[i].name)!=0))
        { 
			   inserer(entite,code,type,val,i,0);
         }
        break;

   case 1:/*verifier si la case dans la tables des mots clés est libre*/
       
       for (i=0;((i<40)&&(tabm[i].state==1))&&(strcmp(entite,tabm[i].name)!=0);i++); 
        if((i<40)&&(strcmp(entite,tabm[i].name)!=0))
          inserer(entite,code,type,val,i,1);
        break; 
    
   case 2:/*verifier si la case dans la tables des séparateurs est libre*/
         for (i=0;((i<40)&&(tabs[i].state==1))&&(strcmp(entite,tabs[i].name)!=0);i++); 
        if((i<40)&&(strcmp(entite,tabs[i].name)!=0))
         inserer(entite,code,type,val,i,2);
        break;

    case 3:/*verifier si la case dans la tables des IDF et CONST est libre*/
        for (i=0;((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0);i++); 
                  
        if (i<1000)
        { inserer(entite,code,type,val,i,0); }
        break;
  }

}


/***Step 5 L'affichage du contenue de la table des symboles ***/

void afficher()
{int i;
 
printf("/***************Table des symboles IDF/Symboles*************/\n");
printf("____________________________________________________________________\n");
printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
printf("____________________________________________________________________\n");
  
for(i=0;i<23;i++)
{	
	
    if(tab[i].state==1)
      { 
        printf("\t|%10s |%15s | %12s | %12f\n",tab[i].name,tab[i].code,tab[i].type,tab[i].val);
		
         
      }
}

 
printf("\n/***************Table des symboles mots cles*************\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<40;i++)
    if(tabm[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabm[i].name, tabm[i].type);
               
      }

printf("\n/***************Table des symboles separateurs*************\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<40;i++)
    if(tabs[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabs[i].name,tabs[i].type );
        
      }

}


int Recherche_position(char entite[])
		{
		int i=0;
		while(i<1000)
		{
		
		if (strcmp(entite,tab[i].name)==0) return i;	
		i++;
		}
 
		return -1;
		
		}

	 void inserertype(char entite[], char type[])
	{
     int pos,pos1;
	   pos=Recherche_position(entite);
	   if(pos!=-1)  {
      if(strcmp(type,"int")==0 || strcmp(type,"float")==0 || strcmp(type,"char")==0 || strcmp(type,"bool")==0 )
      strcpy(tab[pos].type,type); 
      else{
        pos1=Recherche_position(type);
        strcpy(tab[pos].type,tab[pos1].type); 
      }
     }
	}
  void insererval(char entite[],float value)
	{
     int pos;
	   pos=Recherche_position(entite);
	   if(pos!=-1)  { tab[pos].val=value; }
	}

   void inserervalidf(char entite[],char entite2[])
	{
     int pos,pos1;
	   pos=Recherche_position(entite);
     pos1=Recherche_position(entite2);
	   if(pos!=-1)  { tab[pos].val=tab[pos1].val; }
	}
    
	
	int doubledeclaration(char entite[])
	{
	int pos;
	pos=  Recherche_position(entite);
	if(strcmp(tab[pos].type,"")==0) return 0;
	   else return -1;
	}

/// @brief 
/// @param ch 
void modifiecst(char ch[],char typ[]){
	int pos;
	pos=Recherche_position(ch);
	strcpy(tab[pos].type,typ);

}
int comparetype(char ch[],char ch1[]){
	int pos1,pos2;
	if(strcmp(ch1,"int")==0 || strcmp(ch1,"float")==0 || strcmp(ch1,"char")==0 || strcmp(ch1,"bool")==0 ){
	pos1=Recherche_position(ch);
		if(strcmp(tab[pos1].type,ch1)==0){
		return 0;
	  }else return -1;
	}else {
	pos1=Recherche_position(ch);
	pos2=Recherche_position(ch1);
	if(strcmp(tab[pos1].type,tab[pos2].type)==0){
		return 0;
		
	}else return -1;
}
}




