                .global strength

                .text
strength:
                // set all variables up

                mov x7, x0 //store given thing to 7
                mov x0, #0 // set score to 0
                mov x2, #0 // set length to 0
                mov x3, #0 // set lower case to 0
                mov x4, #0 // set upper case to 0
                mov x5, #0 // set digit to 0
                mov x6, #0 // set symbol to 0

                // enter the main loop          
loop:

                ldrb w11, [x7,x2]  // get the string item at the current length starting at 0
                cmp x11, #0 //set the compare flag
                beq score // if empty go to calculate score
L:
                cmp x3, #1 // if no lower than yet branch to check that
                beq U
                b lowerS
U:
                cmp x4, #1 // if no upper than yet branch to check that
                beq D
                b upperS
D:
                cmp x5, #1 // if no digit yet branch to check that
                beq S
                b digitS
S:
                cmp x6, #1 // if no symbol yet branch to check that
                beq length
                b symbol

                b length // if everything else has been found go to length

lowerS:
                cmp x11, #97 //if equal or larger then 97 chance of being in lower case
                bge lower
                b U

upperS:
                cmp x11, #65 // if equal or larger then chance of being upper case
                bge upper
                b D
digitS:
                cmp x11, #48 // if equal or larger then chance of being a digit
                bge digit
                b S
symbol: //need to see if it is something else before assuming it is a symbol
                cmp x11, #48 // is 0
                blt Asymbol // if less then 0 must be a symbol
                cmp x11, #57 // is 9
                ble length // if between 0-9 must be a digit so skip to length
                cmp x11, #65 // is A
                blt Asymbol // if greater then 9 but less then A must be a symbol
                cmp x11, #90 // is Z
                ble length // if between A-Z must be upper case
                cmp x11, #97 // is a
                blt Asymbol // if greater then Z but less then a must be a symbol
                cmp x11, #122 // is z
                ble length // if between a-z must be lower case
                // if greater then all of these must be a symbol
Asymbol:
                add x6, x6, #1// increment the symbol if nothing else happened
length:
                add x2, x2, #1 // increment the length so it is a actual loop
                b loop // loop back to start
score:
                add x0, x0, x3
                add x0, x0, x4 // add the scores for the differnt symbols to the score
                add x0, x0, x5
                add x0, x0, x6
                cmp x2, #12 // checks the length if greater then 12 adds a point and thencheck16
                bge L12
                b quit // stops the whole show

quit:
                ret
// here are all the little breaks for the loop are stored after the quit so they wont be called on ac// cident
lower:
                cmp x11, #122// if smaller or equal then 122 as well as before then in lower case
                ble lowerA
                b U

lowerA:
                add x3, x3, #1// if last 2 things were true then increment lower case 
                b length



upper:
                cmp x11, #90// if smaller as well as before then in upper case
                ble upperA
                b D

upperA:
                add x4, x4, #1// increment upper case
                b length
                blt Asymbol // if less then 0 must be a symbol
                cmp x11, #57 // is 9
                ble length // if between 0-9 must be a digit so skip to length
                cmp x11, #65 // is A
                blt Asymbol // if greater then 9 but less then A must be a symbol
                cmp x11, #90 // is Z
                ble length // if between A-Z must be upper case
                cmp x11, #97 // is a
                blt Asymbol // if greater then Z but less then a must be a symbol
                cmp x11, #122 // is z
                ble length // if between a-z must be lower case
                // if greater then all of these must be a symbol
digit:
                cmp x11, #57 // if smaller as well then is a digit
                ble digitA
                b S

digitA:
                add x5, x5, #1 // if last 2 were true then increment digit
                b length


L12:
                add x0, x0, #1
                cmp x2, #16
                bge L16
                b quit
L16:
                add x0, x0, #1
                b quit         
