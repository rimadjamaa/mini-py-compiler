#ifndef QUAD_H
#define QUAD_H

#define t 10
typedef struct {char*opr;
				 char* op1;
				 char* op2;
				 char* res;}quadruplet;
				 
quadruplet q[t];
//fonction d'insertion d'un nouveau quad
void quad (char*,char*,char*,char*);
//fonction qui affiche les quads
void afficherQuad();

#endif // QUAD_H
