                .global read_board
                .text
read_board:
		mov x2, #0 // counter
		mov x3, #0 // ch
loop:
		ldrb w3, [x0, x2]
		cmp x3, #0
		bne checkdot
		mov x0,#1
		ret
checkdot:
		cmp x3, #'.'
		bne checkdigit
		strb wzr, [x1, x2]
		b next
checkdigit:
		cmp x3, #'0'
		blt invalidchar
		cmp x3, #'9'
		bgt invalidchar
		sub x3, x3, #'0'
		str w3, [x1, x2]
		b next
invalidchar:
		mov x0, #2
		ret
next:
		add x2, x2, #1
		cmp x2, #81
		blt loop
		ldrb w3, [x0, x2]
		cbz x3, success
		mov x0, #3
		ret
success:
		mov x0, #0
		ret
