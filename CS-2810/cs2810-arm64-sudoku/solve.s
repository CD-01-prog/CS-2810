                .global solve
                .text

// solve(board) -> 0 for success, 1 for failure
// on success, the board will be solved
// on failure, the board will be unchanged
solve:
	//save callee i want to use
 	sub sp,sp,#64
        str x20, [sp,#0] 
        str x21, [sp,#8]  
        str x22, [sp,#16]
        str x23, [sp,#24]
        str x24, [sp,#32]
	str x25, [sp,#40]
        str x30, [sp,#48]
	//set up my own variables
	mov x20, x0 //save in use board
	mov x21, #0 // save i 
	ldr x22, =has_conflict//save the address
	ldr x23, =solve// save the address
	mov x24, #1 // save n
	mov x25, x0 // backup board in case of failuer
	//x15 is my temporery value

	mov x0, x20// set the board for has_conflict
	blr x22 // invoke has_conflict 
	cmp x0, #0 // see if a conflict was found if it was end with return of 1
	bne fail

loop:
	cmp x21, #81// compare i with 81
	bge end // if i is greater or equal to 81 then successful end of program
	ldrb w15, [x20, x21]// load x15 = board[i]
	cmp x15, #0// if board[i] = 0 then increment i else move on to inner loop
	bne increment

innerloop:
	cmp x24, #10// compare n with 10
	bge loopfail // if n >= 10 then no legal solution fail so go to inner loop fail
	
	strb w24, [x20,x21]// board[i] = n
	mov x0, x20 // set up board for invoking solve
	blr x23
	cmp x0, #0// compare the result with 0 to see if board is solved
	bne innerloopi// if board is not solved then repeat the inner loop 
	b end // if the board is solved then go to end with finished board

increment:
	add x21, x21, #1// incrment i then return to loop
	b loop

end:// successful end put 0 into x0 and the new board into x1 then restore the callee saved
	mov x0,#0
        mov x1,x20// return a new board
	ldr x20, [sp,#0] // restore all callee saved
        ldr x21, [sp,#8]
        ldr x22, [sp,#16]
        ldr x23, [sp,#24]
        ldr x24, [sp,#32]
	ldr x25, [sp,#40]
        ldr x30, [sp,#48]

        add sp,sp,#64
	ret
innerloopi:// incrment n then return to loop
	add x24, x24, #1
	b innerloop

loopfail:// this can only be reached by n > 10 so set board[i] = 0
	mov x15, #0
	strb w15, [x20,x21]
fail:// something failed so set x0 to 1 and x1 to the origanal board that came in and return them
	mov x0,#1
        mov x1,x25// return a untouched board
	ldr x20, [sp,#0] // restore all callee saved
        ldr x21, [sp,#8]
        ldr x22, [sp,#16]
        ldr x23, [sp,#24]
        ldr x24, [sp,#32]
	ldr x25, [sp,#40]
        ldr x30, [sp,#48]
        add sp,sp,#64
	ret
