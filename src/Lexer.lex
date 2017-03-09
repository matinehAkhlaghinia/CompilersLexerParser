//working

import java_cup.runtime.*;

%%

%class Lexer
%unicode
%line
%column
%cup


%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

Letter = [A-Za-z]
Digit = [0-9]
Punctuation = [!\"#\$%&\'()\*\+\,\-\.\/:;<=>\?@\[\]\\\^_`{}\~¦]
Character = '{Letter}' | '{Punctuation}' | '{Digit}'

Integer = 0|[1-9]{Digit}*
Float = {Integer}(\.{Digit}*)?
Rational = ({Integer}_){Digit}"/"{Digit}* | {Integer}"/"{Digit}*
Number = {Integer} | {Rational} | {Float}

Boolean = T | F

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f] //line terminator, space, tab, or line feed.

Comment = {MultilineComment} | {EndOfLineComment}
MultilineComment = "/#" [^#] ~"#/" | "/#" "#" + "/"
EndOfLineComment = "#" {InputCharacter}* {LineTerminator}?

AlphanumericUnderscore = {Letter} | "_" | {Digit}
Dot = "."
Identifier = {Letter}{AlphanumericUnderscore}*{Dot}?{AlphanumericUnderscore}*

String = \"(\\.|[^\"])*\"


%%


<YYINITIAL> {

  /* keywords */
  "main"                         {  return symbol(sym.MAIN);}

 //Data definers
  "float"                        {  return symbol(sym.FLOAT); }
  "int"                          {  return symbol(sym.INT); }
  "rat"                          {  return symbol(sym.RAT); }
  "bool"                         {  return symbol(sym.BOOL); }
  "char"                         {  System.out.println("char");
                                    return symbol(sym.CHAR); }
  "top"                          {  return symbol(sym.TOP); }
  "dict"                         {  return symbol(sym.DICT); }
  "seq"                          {  return symbol(sym.SEQ); }

  //keywords
  "if"                           {  return symbol(sym.IF); }
  "fi"                           {  return symbol(sym.FI); }
  "loop"                         {  return symbol(sym.LOOP); }
  "pool"                         {  return symbol(sym.POOL); }
  "tdef"                         {  return symbol(sym.TDEF); }
  "break"                        {  return symbol(sym.BREAK); }
  "return"                       {  return symbol(sym.RETURN); }
  "read"                         {  return symbol(sym.READ); }
  "alias"                        {  System.out.println("alias");
                                    return symbol(sym.ALIAS); }

  //OPERATORS
  "="                            {  return symbol(sym.EQ); }
  ":="                           {  return symbol(sym.COLONEQ); }
  "<"                            {  System.out.println(">");
                                    return symbol(sym.LT); }
  ">"                            {  System.out.println("<");
                                    return symbol(sym.GT); }
  "!"                            {  return symbol(sym.NOT); }
  "?"                            {  return symbol(sym.QMARK); }
  ":"                            {  return symbol(sym.COLON); }
  "::"                           {  return symbol(sym.COLONCOLON); }
  "<="                           {  return symbol(sym.LTEQ); }
  "!="                           {  return symbol(sym.NOTEQ); }
  "&&"                           {  return symbol(sym.AND); }
  "||"                           {  return symbol(sym.OR); }
  "+"                            {  return symbol(sym.PLUS); }
  "-"                            {  return symbol(sym.MINUS); }
  "*"                            {  return symbol(sym.TIMES); }
  "/"                            {  return symbol(sym.DIV); }
  "^"                            {  return symbol(sym.POW); }
  "%"                            {  return symbol(sym.MOD); }
  "in"                           {  return symbol(sym.IN); }
  "=>"                           {  return symbol(sym.IMPLY); }
  ","                            {  return symbol(sym.COMMA); }
  "{"                            {  return symbol(sym.LCURL); }
  "}"                            {  return symbol(sym.RCURL); }
  "("                            {  return symbol(sym.LPAREN); }
  ")"                            {  return symbol(sym.RPAREN); }
  ";"                            {  System.out.println("SEMI");
                                    return symbol(sym.SEMI); }

  //Punctuation

    //COMMENT DONT RETURN ANYTHING
  {Character}                    {  return symbol(sym.CHARACTER); }
  {Number}                       {  return symbol(sym.NUMBER); }
  {Boolean}                      {  return symbol(sym.BOOLEAN); }

  //namings
  {Identifier}                   {   System.out.println("IDENT");
                                    return  symbol(sym.IDENTIFIER); }

  {WhiteSpace} {System.out.println("space/newline");}
  {Comment} {}

}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
