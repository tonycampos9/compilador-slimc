%option noyywrap noinput nounput yylineno
%{
#include <string.h>
#include "parser.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylineno;
%}

ID      [a-zA-Z_][a-zA-Z_0-9]*
D       [0-9]
EXP     [eE][+-]?{D}+
REAL    ({D}+"."{D}*|"."{D}+)({EXP})?|{D}+{EXP}

%%
"#includek"[ \t]*"<"[a-zA-Z0-9_./]+">"   return CABECERA;
"#define"                     return DEFINE;
"int"                         return INT;
"double"                      return DOUBLE;
"const"                       return CONST;
"if"                          return IF;
"else"                        return ELSE;
"while"                       return WHILE;
"return"                      return RETURN;
"main"                        return MAIN;
"printf"                      return PRINTF;
"=="                          return EQ;
"!="                          return NEQ;
"<="                          return LE;
">="                          return GE;
"&&"                          return AND;
"||"                          return OR;
{REAL}                        return DECIMAL;
{D}+                          return ENTERO;
{ID}                          {
                                  if (yyleng >= sizeof yylval.nombre) return INVALIDO;
                                  strcpy(yylval.nombre, yytext);
                                  return ID;
                              }
\"([^\"\\\n]|\\.)*\"            return TEXTO;
[ \t\r\n]+                    ;
"//"[^\n]*                    ;
"/*"([^*]|\*+[^*/])*\*+"/"    ;
.                             return (unsigned char)yytext[0];
%%
