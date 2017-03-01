
%%

//Characters
Letter = [a-zA-Z]
Digit = [0-9]
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [\t\f]

//Comments
TraditionalComment   = "/#" ~"#/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?

//Identifier
Identifier = [a-zA-Z] [a-zA-Z0-9_]*

//Character
char = \' {letter} | {Punctuation} | {Digit} \'
Punctuation = " " | "!" | \" | "#" | "$" | "%" | "&" | \' | "(" | ")" | "*"
| "+" | "," | "-" | "." | // | ":" | ";" | "<" | ">" | "=" | "?" | "@" 
| "[" | "]" | "^" | "_" | "`" | "{"| "¦"| "}" | "~"      '

//Boolean
bool = "T" | "F"

//Numbers
posint = {Digit}*
int = "-" {Digit}*
ratpartone = {int}"_"
rat = {ratpartone}? {int} // {int} //can these actually be negative??
Number = {int} | {rat} | {float}
float = {int} "." {posint}

//Datatypes
Datatype = {}

//dict
DictDeclaration = "dict""<"{Datatype}","{Datatype}">"
//here shall we accept spaces or not?
%%

. {}