# LexicalScanner
The scanner input will be a text file containing the source program, and will produce as output the following:  - PIF - Program Internal Form  - ST  - Symbol Table  In addition, the program should be able to determine the lexical errors, specifying the location, and, if possible, the type of the error.


The input file:

start
intg a;
a=10;
intg b
b=30;
intg i;
intg sum;
sum=0;
for(i=a;i<=b;i=i+1)
{sum=sum+i;}
output(sum);


The output file:

_______ Symbol table _______
a  0 
10  1
b  2 
30  3
i  4
sum  5
0  6
+1  7
_______ End ST _______

_______ Program internal form _______
 start  -1
 intg  -1
 a  0
 ;  -1
 a  0
 =  -1
 10  1
 ;  -1
 intg  -1
 b  2
 b  2
 =  -1
 30  3
 ;  -1
 intg  -1
 i  4
 ;  -1
 intg  -1
 sum  5
 ;  -1
 sum  5
 =  -1
 0  6
 ;  -1
 for  -1
 (  -1
 i  4
 =  -1
 a  0
 ;  -1
 i  4
 <=  -1
 b  2
 ;  -1
 i  4
 =  -1
 i  4
 +1  7
 )  -1
 {  -1
 sum  5
 =  -1
 sum  5
 +  -1
 i  4
 ;  -1
 }  -1
 output  -1
 (  -1
 sum  5
 )  -1
 ;  -1
_______ End PIF _______
