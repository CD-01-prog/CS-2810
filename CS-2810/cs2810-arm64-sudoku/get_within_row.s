                .global get_within_row
                .text

// get_within_row(board, row, n)
get_within_row:
		//x0 = board comes like that
		//x1 = row comes like that
		//x2 = n comes like that
		mov x3, #0 // index
		mov x4, x0 //store board so it can be used
		mov x5, #9 // complier said must be register

		mul x1, x1, x5 // row = row * 9
		add x3, x1, x2// index = (row*9) + n
		ldrb w0, [x4,x3] // return = board[index]

                // your code goes here
                ret
