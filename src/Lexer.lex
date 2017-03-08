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
datatype = "int" | "float" | "rat" | dictDeclaration | seqDeclaration | "char" | "bool"
datatypo = "int" | "float" | "rat" | dictDeclaration | seqDeclaration | "char" | "bool"

//dict
dictDeclaration = "dict""<"{datatype}","{datatype}">"
seqDeclaration = "seq""<"{datatype}">"

%%


<YYINITIAL> {

  /* keywords */
  "main"                         { return symbol(sym.MAIN);}

 //Data definers
  "float"                        { return symbol(sym.FLOAT); }
  "int"                          { return symbol(sym.INT); }
  "rat"                          { return symbol(sym.RAT); }
  "bool"                         { return symbol(sym.BOOL); }
  "char"                         { return symbol(sym.CHAR); }
  "top"                          { return symbol(sym.TOP); }
  {dictDeclaration}              { return symbol(sym.DICT); }
  {seqDeclaration}               { return symbol(sym.SEQ); }

  //keywords
  "if"                           { return symbol(sym.IF); }
  "fi"                           { return symbol(sym.ENDIF); }
  "loop"                         { return symbol(sym.LOOP); }
  "pool"                         { return symbol(sym.ENDLOOP); }
  "tdef"                         { return symbol(sym.FUNCTION); }
  "break"                        { return symbol(sym.BREAK); }
  "return"                       { return symbol(sym.RETURN); }
  "read"                         { return symbol(sym.READ); }
  "alias"                        { return symbol(sym.ALIAS); }
  
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
  "=>"                           { return symbol(sym.IMPLY); }
  ","                            { return symbol(sym.COMMA); }

  //Punctuation

    //COMMENT DONT RETURN ANYTHING
  {character}                    { return symbol(sym.CHARACTER); }
  {number}                       { return symbol(sym.NUMBER); }
  {boolean}                      { return symbol(sym.BOOLEAN); }

  //namings
  {Identifier}                   { return  symbol(sym.IDENTIFIER); }
  
  {WhiteSpace} {}
  {EndOfLineComment} {}
  {NormalComment} {}
  
}