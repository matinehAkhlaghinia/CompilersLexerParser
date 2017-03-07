import java_cup.runtime.*;

%%
%class Lexer
%cup
%line
%standalone

// semi, column, operators on numbers, lparen, rparen, char, 

//Characters
Letter = [a-zA-Z]
Digit = [0-9]
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = [ \t\n]+
SingleCharacter = [^\r\n\'\\]

//Comments
NormalComment   = "/#" ~"#/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?

//Identifier
Identifier = [a-zA-Z] [a-zA-Z0-9_]*

//Character
character = \' {Letter} | {Punctuation} | {Digit} \'
Punctuation = " " | "!" | \" | "#" | "$" | "%" | "&" | \' | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | ">" | "=" | "?" | "@" | "[" | "]" | "^" | "_" | "`" | "{"| "¦"| "}" | "~"

//Boolean
boolean = "T" | "F"

//Numbers
posint = {Digit}*
int = "-" {Digit}*
ratpartone =\ {int}"_"
rat = {ratpartone}? {int} // {int} //can these actually be negative??
number = {int} | {rat} | {float}
float = {int} "." {posint}

//Top
top = (Any data type)

//dictDeclaration = "dict""<"{Datatype}","{Datatype}">"
//seqDecalaration = "seq""<"{Datatype}">"
%%

<YYINITIAL> {

  /* keywords */
  "main"                         { return new Symbol(sym.MAIN,yytext(),yyline());}
  //COMMENT DONT RETURN ANYTHING
  "char"                        {return CHAR; }
  "boolean"                     { return BOOLEAN; } 
 
 //Data definers
  
  "float"                        { return FLOAT; }
  "int"                          { return INT; }
  "rat"                          { return RAT; }
  "bool"                         { return BOOL; }
  "char"                         { return CHAR; }
  "top"                          { return TOP; }
  //{dictDecalaration}             { return DICT; }
  //{seqDecalaration}              { return SEQ; }

  //keywords
  "if"                        { return IF; }
  "fi"                        { return ENDIF; }
  "loop"                     { return LOOP; }
  "pool"                           { return ENDLOOP; }
  "tdef"                       { return FUNCTION; }
  "break"                         { return BREAK; }
  "return"                      { return RETURN; }
 // "read"  
  //"alias"
  
  //OPERATORS
  "="                            { return EQ; }
  ">"                            { return GT; }
  "<"                            { return LT; }
  "!"                            { return NOT; }
  "~"                            { return COMP; }
  "?"                            { return QMARK; }
  ":"                            { return COLON; }
  "=="                           { return EQEQ; }
  "::"                           { return COLONCOLON; }
  "<="                           { return LTEQ; }
  ">="                           { return GTEQ; }
  "!="                           { return NOTEQ; }
  "&&"                           { return ANDAND; }
  "||"                           { return OROR; }
  "--"                           { return MINUSMINUS; }
  "+"                            { return PLUS; }
  "-"                            { return MINUS; }
  "*"                            { return MULT; }
  "/"                            { return DIV; }
  "&"                            { return AND; }
  "|"                            { return OR; }
  "^"                            { return POW; }
  "%"                            { return MOD; }

  "in"                           { return IN; }
  
  "=>"                           { return IMPLY; }

  //Punctuation

  //namings
  {Identifier}                   { return IDENTIFIER; }
  
// define datatypes
//{WhiteSpace} {/* Do nothing! */}
//{Digit}+ {System.out.printf("number [%s]\n", yytext();}
//{Letter}({Letter}|{Digit})* {System.out.printf("word [%s]\n", yytext();}
//{Punctuation} {System.out.printf("punctuation [%s]\n", yytext();}
//. {System.out.printf("symbol [%s]\n", yytext();}

}