                .global get_within_group
                .text

// get_within_group(board, group, n)
get_within_group:
		// set up all variables
		//x0 = board comes like this
		//x1 = group comes like this
		//x2 = n comes like this
		mov x3, #0 // tempstoarage
		mov x4, #0 // tempstoarage 2
		mov x5, #0 // index
		mov x7, #0 // row
		mov x8, #0 // column
		mov x9, #3 // complier said it wanted a register for 3
		mov x10, #9 // compiler said it wanted a register for 9

		//get row
		udiv x3, x1, x9// tempstoarage = group / 3
		mul x3, x3, x9 // tempstoarage = tempstoarage * 3 ie ts = (group /3 ) * 3
		udiv x4, x2, x9 // ts2 = n / 3
		add x7, x3, x4 // row = ts + ts2 ie row = ((group/3)*3) + (n/3)

		//re fresh variables unneccesarly for pariona sake
		mov x3, #0
		mov x4, #0

		//get column
		//x3 = x1 % x9
		udiv x3, x1, x9
		msub x3, x3, x9, x1
		// x3 = x3 * 3 ie ts = (group%3) * 3
		mul x3, x3, x9
		//x4 = x2 % x9
		udiv x4, x2, x9
		msub x4, x4, x9, x2

		add x8, x3, x4

		//final bit of math
		mul x7, x7, x10// row = row * 9
		add x5, x7, x8 // index = row + column
		ldrb w0, [x0,x5] // return = [board,index] ie return what is in board at location index
                // your code goes here
                ret
