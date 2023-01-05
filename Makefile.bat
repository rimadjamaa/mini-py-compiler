flex lex.l
bison -d synt.y --report=states,itemsets --debug
gcc lex.yy.c synt.tab.c ts.c -o tp
tp<test.txt
