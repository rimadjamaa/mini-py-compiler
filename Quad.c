#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Quad.h"
int indq=0;
quadruplet q[t];

void quad (char* o,char*o1,char*o2,char*r)
{q[indq].opr=o;
 q[indq].op1=o1;
 q[indq].op2=o2;
 q[indq].res=r;
 indq++;
}

void afficherQuad()
{ int i;
for (i=0;i<indq;i++)
{printf ("%d-( %s , %s , %s , %s )\n",i,q[i].opr,q[i].op1,q[i].op2,q[i].res);}
}