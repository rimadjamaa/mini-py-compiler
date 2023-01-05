#ifndef TS_H
#define TS_H

#define taille 100
#define MAXRECST 200
#define MAXST 100
#define MAXCHILDREN 100
#define MAXLEVELS 20
#define MAXQUADS 1000

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

//---------------------------------------- test quad ------------------------------------
typedef struct record
	{
		char *type;
		char *name;
		int decLineNo;
		int lastUseLine;
	} record;

typedef struct ASTNode
	{
		int nodeNo;
    /*Operator*/
    char *NType;
    int noOps;
    struct ASTNode** NextLevel;
    
    /*Identifier or Const*/
    record *id;
	
	} node;
  
typedef struct Quad
	{
		char *R;
		char *A1;
		char *A2;
		char *Op;
		int I;
	} Quad;

void makeQ(char *R, char *A1, char *A2, char *Op);
int checkIfBinOperator(char *Op);
node *createOp(char *oper, int noOps, ...);
void printQuads();
int deadCodeElimination();
 char *makeStr(int no, int flag);
 void Xitoa(int num, char *str);

// -------------------------------------------test quad end-----------------------------

#endif //TS_H