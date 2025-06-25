import java_cup.runtime.*;

%%

%public
%class AnalizadorLexico
%unicode
%cup
%line
%column

%%

\uFEFF      { /* ignorar BOM */ }

/* ==== Palabras reservadas ==== */
"procedure"     { return new Symbol(sym.PROCEDURE); }
"end"           { return new Symbol(sym.END); }
"repeat"        { return new Symbol(sym.REPEAT); }
"until"         { return new Symbol(sym.UNTIL); }
"for"           { return new Symbol(sym.FOR); }
"from"          { return new Symbol(sym.FROM); }
"to"            { return new Symbol(sym.TO); }
"do"            { return new Symbol(sym.DO); }
"if"            { return new Symbol(sym.IF); }
"then"          { return new Symbol(sym.THEN); }
"else"          { return new Symbol(sym.ELSE); }
"true"          { return new Symbol(sym.TRUE); }
"false"         { return new Symbol(sym.FALSE); }
"not"           { return new Symbol(sym.NOT); }
"int"           { return new Symbol(sym.INT); }
"list"          { return new Symbol(sym.LIST); }
"return"        { return new Symbol(sym.RETURN); }

/* ==== Operadores y símbolos ==== */
":="            { return new Symbol(sym.ASIGNACION); }
"=="            { return new Symbol(sym.IGUALDAD); }
"!="            { return new Symbol(sym.DIFERENTE); }
"<="            { return new Symbol(sym.MENORIGUAL); }
">="            { return new Symbol(sym.MAYORIGUAL); }
"<"             { return new Symbol(sym.MENOR); }
">"             { return new Symbol(sym.MAYOR); }

"+"             { return new Symbol(sym.MAS); }
"-"             { return new Symbol(sym.MENOS); }
"*"             { return new Symbol(sym.POR); }
"/"             { return new Symbol(sym.DIV); }

"("             { return new Symbol(sym.PARI); }
")"             { return new Symbol(sym.PARD); }
"["             { return new Symbol(sym.CORI); }
"]"             { return new Symbol(sym.CORD); }
","             { return new Symbol(sym.COMA); }
";"             { return new Symbol(sym.PYC); }
":"             { return new Symbol(sym.DOSPUNTOS); }

/* ==== Constantes ==== */
-?[0-9]+        { return new Symbol(sym.NUMERO, yytext()); }

/* ==== Comentarios ==== */
"//".*          { /* comentario de una línea, ignorar */ }

/* ==== Identificadores ==== */
[a-zA-Z][a-zA-Z0-9_]*  { return new Symbol(sym.ID, yytext()); }

/* ==== Ignorar espacios en blanco y saltos de línea ==== */
[ \t\r\n]+      { /* ignorar */ }

/* ==== Errores léxicos: abortar con mensaje claro ==== */
. {
  int line = yyline + 1;
  int col  = yycolumn + 1;
  String ch = yytext();
  throw new RuntimeException(
    String.format("Error léxico (l.%d,c.%d): carácter no reconocido '%s'", 
                   line, col, ch)
  );
}
