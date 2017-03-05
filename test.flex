
%%
%class Lexer
%unicode
%cup
%line
%column
%standalone


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
//Identifier = [a-zA-Z] [a-zA-Z0-9_]*

//Identifier = [:jletter:][:jletterdigit:]*

//Character
char = \' {letter} | {Punctuation} | {Digit} \'
Punctuation = " " | "!" | \" | "#" | "$" | "%" | "&" | \' | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | ">" | "=" | "?" | "@" | "[" | "]" | "^" | "_" | "`" | "{"| "¦"| "}" | "~"

//Boolean
bool = "T" | "F"

//Numbers
posint = {Digit}*
int = "-" {Digit}*
ratpartone =\ {int}"_"
rat = {ratpartone}? {int} // {int} //can these actually be negative??
Number = {int} | {rat} | {float}
float = {int} "." {posint}


//Datatypes
//Datatype = {}

//Top
top = (Any data type)

//dict
DictDeclaration = "dict""<"{Datatype}","{Datatype}">"
//here shall we accept spaces or not?
%%
{WhiteSpace} {/* Do nothing! */}
{Digit}+ {System.out.printf("number [%s]\n", yytext());}
{Letter}({Letter}|{Digit})* {System.out.printf("word [%s]\n", yytext());}
{Punctuation} {System.out.printf("punctuation [%s]\n", yytext());}
. {System.out.printf("symbol [%s]\n", yytext());}


