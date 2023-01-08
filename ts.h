#ifndef TS_H
#define TS_H

#define taille 100
typedef struct
{
   int state;
   char name[20];
   char code[20];
   char type[20];
   float val;
 } element;

typedef struct
{ 
   int state; 
   char name[20];
   char type[20];
} elt;


void initialisation();/*insitialisation de la ts qui mais toout les state a 0 ==non declare */
void inserer (char entite[], char code[],char type[],float val,int i,char y);/*elle est utiliser dans la fonction recherche*/
void rechercher (char entite[], char code[],char type[],float val,int y);/*la recherche et l'insersertion aussi ignore la double insertion */
void afficher();
int Recherche_position(char entite[]);/*la position dans la ts == l'indice*/
void inserertype(char entite[], char type[]);/*pour insere le type des idfs*/
void insererval(char entite[],float value);/*pour insere la valeur des idfs*/
void inserervalidf(char entite[],char entite2[]);/*pour insere la val d'un idf avec un autre idf quand idf=idf*/
int doubledeclaration(char entite[]);/*pour verifier l'utilisation d'un idf sans declaration */
void modifiecst(char ch[],char typ[]);/*pour inserer le type const aux idfs*/
int comparetype(char ch[],char ch1[]);/* fortement typé */

#endif //TS_H