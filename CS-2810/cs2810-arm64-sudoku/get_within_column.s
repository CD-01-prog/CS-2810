                .global get_within_column
                .text

// get_within_column(board, column, n)
get_within_column:
                //x0 = board comes like that
                //x1 = column comes like that
                //x2 = n comes like that
                mov x3, #0 // index
                mov x4, x0 //store board so it can be used
                mov x5, #9 // complier said must be register

                mul x2, x2, x5 // n = n * 9
                add x3, x2, x1// index = (n*9) + column
                ldrb w0, [x4,x3] // return = board[index]

                // your code goes here
                ret
