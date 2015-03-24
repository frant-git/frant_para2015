/* Archivo:: asignacion.y
 * Descripcion:: Archivo de especificacion utilizado por bison. 
 */

/* Describir esto*/

%name-prefix "a_"

%{
 #include <stdio.h>
 #include "misc.h"
 #include "assignment.h"

 /*funciones definidas por el lexer*/
 extern int a_lex();
 extern int a_error(char *s);
 extern int a_lex_destroy(); 
 extern FILE *a_in;
 extern int a_lineno;
 
 Asgmnt *asg; 
 char *aname;
%}

%union {
  int v;
}

/*--Tokens (agregado)--*/
%token <v> TK_PROP
%token <v> TK_TRUE
%token <v> TK_FALSE
%token TK_TWODOTS
%token TK_SEPARATOR

%%
input: asgmnt

asgmnt:  vval
       | vval TK_SEPARATOR asgmnt 
;
vval: prop TK_TWODOTS booler
;
prop: TK_PROP
;
booler: TK_TRUE | TK_FALSE



%%
/* Funcion que se provee para parsear una asignacion en un archivo.*/
void parse_assignment(FILE * input)
{
  a_lineno = 1;
  a_in = input;
  if (!a_in)
    log_error("parse_assignment: no input file.");
  a_parse();
  a_lex_destroy();
}


/* Funcion que se ejecuta cuando ocurre un error durante el parseo.*/
int a_error(char *s)
{
  log_error(" %s - parser error - %s\n",aname,s);
  return 0;
}
