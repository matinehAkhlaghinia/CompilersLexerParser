
%%
%class Lexer
%unicode
%cup
%line
%column
%standalone

// semi, column, operators on numbers, lparen, rparen, char, 
%{
  StringBuffer string = new StringBuffer();
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

//Characters
Letter = [a-zA-Z]
Digit = [0-9]
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = [ \t\n]+


//Comments
NormalComment   = "/#" ~"#/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?

//Identifier
identifier = [a-zA-Z] [a-zA-Z0-9_]*

//Identifier = [:jletter:][:jletterdigit:]*

//Character
character = \' {letter} | {Punctuation} | {Digit} \'
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


