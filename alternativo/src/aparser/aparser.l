/* Archivo:: asignacion.l 
 * Descripcion:: Archivo de especificacion utilizado por lex. A partir de este
 * archivo lex genera el analizador lexico para parsear las asignaciones.
 */

%option  noyywrap case-insensitive yylineno
%option prefix="a_"

%{
#include "misc.h"
#include "aparser.tab.h"
#include <stdio.h>
extern char* aname;
%}


NUMBER    [0-9]*

%%
[ \t]*                                {/* COME CARACTERES VACIOS*/}

\:                                    {return TK_TWODOTS ;}

(,|\n)                                {return TK_SEPARATOR ;}

(p|P)[^0]{NUMBER}                     {printf("%s\n", a_text); a_lval.v = get_prop_var(a_text); return TK_PROP ;}

(True|1)                              {return TK_TRUE ;}

(False|0)                             {return TK_FALSE ;}

.                                     { log_error(" %s - lexer error - at line %d: %s\n",aname,a_lineno,a_text); }      
%%
