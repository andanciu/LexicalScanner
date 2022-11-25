/*** Definition Section ***/
%{
#include <string.h>

typedef struct {
    char token[257];
    int symbolTableCode;
}PIF;

typedef struct{
    char token[257];
    int index;
}ST;

ST SymbolTable[100];
int stLength = 0;

PIF ProgramInternalForm[300];
int pifLength = 0;

int errorFound = 0;
int lineNumber = 1;


int addToST(char* token) {
	for(int i = 0; i < stLength; i++) {
		
		if(strcmp(SymbolTable[i].token, token) == 0) {
		  return SymbolTable[i].index;
		}
	}
	strcpy(SymbolTable[stLength].token, token);
	SymbolTable[stLength].index = stLength;
	stLength++;
	
	return stLength - 1;
}

void addToPIF(char* token, int stCode) {
	strcpy(ProgramInternalForm[pifLength].token, token);
	ProgramInternalForm[pifLength].symbolTableCode = stCode;
	
	pifLength++;
}

void showSymbolTable() {
    printf("_______ Symbol table _______n");
    
    for(int i = 0 ; i < stLength; i++) {
        printf(" %s  %d", SymbolTable[i].token, SymbolTable[i].index);
        printf("\n");
    }
    
    printf("_______ End ST _______n");
    printf("\n");
}

void showProgramInternalForm() {
    printf("_______ Program internal form _______\n");
    
    for(int i = 0; i < pifLength; i++) {
    
        printf(" %s  %d ", ProgramInternalForm[i].token, ProgramInternalForm[i].symbolTableCode);
        printf("\n");
    }
    
    printf("_______ End PIF _______\n");
    printf("\n");
}

%}


INTG_NUMBER  [+-]?(0|[1-9][0-9]*)(\.[0-9]+)?
IDENTIFIER   [a-z][a-z0-9_.]*
STRING       \".*\"

/*** Rule Section ***/ 
%%
	
start                                   { addToPIF(yytext, -1); }
end										{ addToPIF(yytext, -1); }
vector									{ addToPIF(yytext, -1); }
char									{ addToPIF(yytext, -1); }
const                                 	{ addToPIF(yytext, -1); }
execute                                 { addToPIF(yytext, -1); }
until                                   { addToPIF(yytext, -1); }
otherwise                               { addToPIF(yytext, -1); }
if                                      { addToPIF(yytext, -1); }
intg                                    { addToPIF(yytext, -1); }
real                                    { addToPIF(yytext, -1); }
string                                  { addToPIF(yytext, -1); }
boolean									{ addToPIF(yytext, -1); }
of										{ addToPIF(yytext, -1); }
program									{ addToPIF(yytext, -1); }
input									{ addToPIF(yytext, -1); }
output									{ addToPIF(yytext, -1); }
for										{ addToPIF(yytext, -1); }
then									{ addToPIF(yytext, -1); }
var										{ addToPIF(yytext, -1); }
while									{ addToPIF(yytext, -1); }
method									{ addToPIF(yytext, -1); }
\;										{ addToPIF(yytext, -1); }
\:										{ addToPIF(yytext, -1); }
\(                                    	{ addToPIF(yytext, -1); }
\)  									{ addToPIF(yytext, -1); }
\=                                      { addToPIF(yytext, -1); }
\,                                    	{ addToPIF(yytext, -1); }
\+                                    	{ addToPIF(yytext, -1); }
\-                                    	{ addToPIF(yytext, -1); }
\*                                    	{ addToPIF(yytext, -1); }
\\										{ addToPIF(yytext, -1); }
\}										{ addToPIF(yytext, -1); }
\{										{ addToPIF(yytext, -1); }
\[										{ addToPIF(yytext, -1); }
\										{ addToPIF(yytext, -1); }
\%                                    	{ addToPIF(yytext, -1); }
\.=                                    	{ addToPIF(yytext, -1); }
\<<                                    	{ addToPIF(yytext, -1); }
\>=                                    	{ addToPIF(yytext, -1); }
\<=                                    	{ addToPIF(yytext, -1); }
\<-                                    	{ addToPIF(yytext, -1); }
\==                                    	{ addToPIF(yytext, -1); }
\and                                    { addToPIF(yytext, -1); }
\or                                    	{ addToPIF(yytext, -1); }
\.                                    	{ addToPIF(yytext, -1); }
\!=                                    	{ addToPIF(yytext, -1); }
{IDENTIFIER}				            { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{STRING}								{ int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{INTG_NUMBER}                          { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
[\n]									{ ++lineNumber; }
[ \t\n]+             					{ ; /* eat up whitespace */ }
.                						{ errorFound = 1; printf("Illegal token %s at line %d !", yytext, lineNumber); printf("\n"); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {}

int main(int argc, char** argv) {

	FILE *fp;
	fp = fopen(argv[1], "r");
	
	/* yyin - takes the file pointer which contains the input*/
	yyin = fp;

	/* yylex() - this is the main flex function which runs the Rule Section*/ 
	yylex();
	
	if (errorFound == 0) {
    		showSymbolTable();
    		showProgramInternalForm();
	}
	return 0;
}
