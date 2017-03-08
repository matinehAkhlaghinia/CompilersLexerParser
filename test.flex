import java_cup.runtime.*;

%%
%class Lexer
%public
%cup
%line
%column
%{
  StringBuilder string = new StringBuilder();
  
  private Symbol symbol(int type) {
    return Symbol(type, yyline, yycolumn);
  }

  private Symbol symbol(int type, Object value) {
    return Symbol(type, yyline, yycolumn, value);
  }
%}

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

//dict
dictDeclaration = "dict""<"{Datatype}","{Datatype}">"
seqDecalaration = "seq""<"{Datatype}">"
%%

<YYINITIAL> {

  /* keywords */
  "main"                         { return symbol(MAIN); }
  //COMMENT DONT RETURN ANYTHING
  {character}                    { return symbol(CHARACTER); }
  {number}                       { return symbol(NUMBER); }
  {boolean}                      { return symbol(BOOLEAN); }

  //Data definers
  "float"                        { return symbol(FLOAT); }
  "int"                          { return symbol(INT); }
  "rat"                          { return symbol(RAT); }
  "bool"                         { return symbol(BOOL); }
  "char"                         { return symbol(CHAR); }
  "top"                          { return symbol(TOP); }
  {dictDecalaration}             { return symbol(DICT); }
  {seqDecalaration}              { return symbol(SEQ); }


  //namings
  {identifier}                   { return symbol(IDENTIFIER); }
  
  //OPERATORS
  "="                            { return symbol(EQ); }
  ">"                            { return symbol(GT); }
  "<"                            { return symbol(LT); }
  "!"                            { return symbol(NOT); }
  "~"                            { return symbol(COMP); }
  "?"                            { return symbol(QMARK); }
  ":"                            { return symbol(COLON); }
  "=="                           { return symbol(EQEQ); }
  "::"                           { return symbol(COLONCOLON); }
  "<="                           { return symbol(LTEQ); }
  ">="                           { return symbol(GTEQ); }
  "!="                           { return symbol(NOTEQ); }
  "&&"                           { return symbol(ANDAND); }
  "||"                           { return symbol(OROR); }
  "--"                           { return symbol(MINUSMINUS); }
  "+"                            { return symbol(PLUS); }
  "-"                            { return symbol(MINUS); }
  "*"                            { return symbol(MULT); }
  "/"                            { return symbol(DIV); }
  "&"                            { return symbol(AND); }
  "|"                            { return symbol(OR); }
  "^"                            { return symbol(POW); }
  "%"                            { return symbol(MOD); }

  "in"                           { return symbol(IN); }
  
  "=>"                           { return symbol(IMPLY); }



  //keywords
  "if"                        { return symbol(CLASS); }
  "fi"                        { return symbol(CONST); }
  "loop"                     { return symbol(CONTINUE); }
  "pool"                           { return symbol(DO); }
  "tdef"                       { return symbol(DOUBLE); }
  "break"                         { return symbol(ELSE); }
  "return"                      { return symbol(EXTENDS); }
  "read"  
  "alias"

  //Punctuation

  
// define datatypes
{WhiteSpace} {/* Do nothing! */}
{Digit}+ {System.out.printf("number [%s]\n", yytext());}
{Letter}({Letter}|{Digit})* {System.out.printf("word [%s]\n", yytext());}
{Punctuation} {System.out.printf("punctuation [%s]\n", yytext());}
. {System.out.printf("symbol [%s]\n", yytext());}



<YYINITIAL> {

  /* keywords */
  "main"                         { return symbol(sym.MAIN);}
  //COMMENT DONT RETURN ANYTHING
  "char"                        {return symbol(sym.CHAR); }
  "boolean"                     { return symbol(sym.BOOLEAN); } 
 
 //Data definers
  
  "float"                        { return symbol(sym.FLOAT);}
  "int"                          { return symbol(sym.INT); }
  "rat"                          { return symbol(sym.RAT); }
  "bool"                         { return symbol(sym.BOOL); }
  "top"                          { return symbol(sym.TOP); }
  //{dictDecalaration}             { return DICT; }
  //{seqDecalaration}              { return SEQ; }

  //keywords
  "if"                        { return symbol(sym.IF); }
  "fi"                        { return symbol(sym.ENDIF); }
  "loop"                     { return symbol(sym.LOOP); }
  "pool"                      { return symbol(sym.ENDLOOP); }
  "tdef"                       { return symbol(sym.FUNCTION); }
  "break"                         { return symbol(sym.BREAK); }
  "return"                      { return symbol(sym.RETURN); }
 // "read"  
  //"alias"
  
  //OPERATORS
  "="                            { return symbol(sym.EQ); }
  ">"                            { return symbol(sym.GT); }
  "<"                            { return symbol(sym.LT); }
  "!"                            { return symbol(sym.NOT); }
  "~"                            { return symbol(sym.COMP); }
  "?"                            { return symbol(sym.QMARK); }
  ":"                            { return symbol(sym.COLON); }
  "=="                           { return symbol(sym.EQEQ); }
  "::"                           { return symbol(sym.COLONCOLON); }
  "<="                           { return symbol(sym.LTEQ); }
  ">="                           { return symbol(sym.GTEQ); }
  "!="                           { return symbol(sym.NOTEQ); }
  "&&"                           { return symbol(sym.ANDAND); }
  "||"                           { return symbol(sym.OROR); }
  "--"                           { return symbol(sym.MINUSMINUS); }
  "+"                            { return symbol(sym.PLUS); }
  "-"                            { return symbol(sym.MINUS); }
  "*"                            { return symbol(sym.MULT); }
  "/"                            { return symbol(sym.DIV); }
  "&"                            { return symbol(sym.AND); }
  "|"                            { return symbol(sym.OR); }
  "^"                            { return symbol(sym.POW); }
  "%"                            { return symbol(sym.MOD); }

  "in"                           { return symbol(sym.IN); }
  
  "=>"                           { return  Symbol(sym.IMPLY); }

  //Punctuation

  //namings
  {Identifier}                   { return  Symbol(sym.IDENTIFIER); }
  
  {WhiteSpace} {}
  {EndOfLineComment} {}
  {NormalComment} {}
  
// define datatypes
//{WhiteSpace} {/* Do nothing! */}
//{Digit}+ {System.out.printf("number [%s]\n", yytext();}
//{Letter}({Letter}|{Digit})* {System.out.printf("word [%s]\n", yytext();}
//{Punctuation} {System.out.printf("punctuation [%s]\n", yytext();}
//. {System.out.printf("symbol [%s]\n", yytext();}

}