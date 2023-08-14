%{
#include "token.h"
%}

%option caseless
%option debug
%option nodefault 
%option noyywrap
%option outfile="scanner.cpp"

%x DIRECTIVE COMMENT

%%

[a-zA-Z_][a-zA-Z0-9_]*   { 
                            if(isKeyword(yytext)) {
                                return keyword(yytext);
                            } else {
                                return IDENTIFIER;
                            }
                         }

[0-9]+                   return NUMBER;

\"[^\n\"]*\"             return STRING;

\/\/.*|\#.*              /* ignore comments */

\"                      return QUOTE;
\'                      return SQUOTE;
\:                      return COLON;
\,                      return COMMA;
\;                      return SEMICOLON; 

<INITIAL>"PROC"          BEGIN(DIRECTIVE); return PROC;
<INITIAL>"ENDP"          BEGIN(DIRECTIVE); return ENDP;

<DIRECTIVE>"ENDP"        BEGIN(INITIAL); return ENDPROC;

"AH"|"AL"|"AX"|"EAX"    return REGISTER;
"CS"|"DS"               return SEGREG;

"MOV"|"LEA"|"INT"|"ADD"|"SUB"|"MUL"|"DIV"|"CMP"|"JMP"|"JE"|"JNE"|"JA"|"JG"|"CALL" {  
  return OPCODE;
}

"BYTE"|"WORD"|"DWORD"|"QWORD"|"PTR" {
  return DATATYPE; 
}

"DB"|"DW"|"DD"|"DQ"|"DT"|"DF"|"RESB"|"PROC"|"ENDP"|"PROTO"|"STRUCT" {
  return DIRECTIVE; 
}

"ES"|"FS"|"GS"|"SS"|"CS"|"DS"|"BP"|"BX"|"CX"|"DX"|"SI"|"DI"|"SP" {
  return REGISTER;
}

"IF"|"ELSE"|"ELSEIF"|"ENDIF" {
  return CONDITIONAL;
}

"MACRO"|"ENDM" {
  return PREPROCESSOR;
}

"%define"|"%macro"|"%include" {
  return PREPROCESSOR;
}

ES:|CS:|SS:|DS:|FS:|GS:   { return SEGMENT_OVERRIDE; }

BYTE PTR|WORD PTR|DWORD PTR|QWORD PTR   
                         { return PTR; }

[A-Z]?:[A-Z]?            { return MEMORY; }

[0-9]+D                  { return NUMBER; }
0x[0-9a-fA-F]+           { return HEX_NUMBER; }
[0-9]+'[bB]              { return BINARY_NUMBER; }

%macro\s+([a-zA-Z0-9_]+) { return MACRO; }
%endmacro                { return ENDMACRO; }
%assign                  { return ASSIGN; }

%include\b               { return INCLUDE; }
%define\b                { return DEFINE; }
%ifdef\b                 { return IFDEF; }
%endif\b                 { return ENDIF; }

";".*                    BEGIN(COMMENT);
<COMMENT>\n              BEGIN(INITIAL);
%%

/* Your helper functions, e.g., isKeyword, keyword, etc. here */
