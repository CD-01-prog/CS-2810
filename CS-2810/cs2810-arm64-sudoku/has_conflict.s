                .global has_conflict
                .text

// has_conflict(board) -> 0 or 1
has_conflict:
	sub sp,sp,#64
	str x19, [sp,#0] 
        str x20, [sp,#8]  
        str x21, [sp,#16]
        str x22, [sp,#24]
        str x23, [sp,#32]
	str x24, [sp,#40]
        str x30, [sp,#48]
	
	mov x1, #0
	mov x19, x0 // save board
	mov x20, x1// save i
	ldr x21, =has_conflict_within//save the address
	ldr x22, =get_within_row// save the address
	ldr x23, =get_within_column//save the address
	ldr x24, =get_within_group//save the address
	mov x5, #0// tester value

loop:
	cmp x20, #9
	bge end
	
	mov x0, x19 //set board
	mov x1, x22// set row address
	mov x2, x20// set i
	blr x21 
	mov x5, x0	
	cmp x5, #0
	bne fail

	mov x0, x19 //set board
	mov x1, x23// set column address
	mov x2, x20// set i
	blr x21 
	mov x5, x0	
	cmp x5, #0
	bne fail

	mov x0, x19 //set board
	mov x1, x24// set group address
	mov x2, x20// set i
	blr x21 
	mov x5, x0	
	cmp x5, #0
	bne fail

	b increment

fail:
	ldr x19, [sp,#0] // restore all callee saved
        ldr x20, [sp,#8]
        ldr x21, [sp,#16]
        ldr x22, [sp,#24]
        ldr x23, [sp,#32]
	ldr x24,[sp,#40]
        ldr x30, [sp,#48]

        add sp,sp,#64
	mov x0, #1
        ret

increment:
	add x20, x20, #1
	b loop

end:    	
	ldr x19, [sp,#0] // restore all callee saved
        ldr x20, [sp,#8]
        ldr x21, [sp,#16]
        ldr x22, [sp,#24]
        ldr x23, [sp,#32]
	ldr x24,[sp,#40]
        ldr x30, [sp,#48]

        add sp,sp,#64
        mov x0, #0
	ret
