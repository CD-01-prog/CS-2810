                .global has_conflict_within
                .text

// has_conflict_within(board, get_within, major) -> 0 or 1
has_conflict_within:
	//x0 = board
	//x1 = get_within save to stack for easy use 24 to keep even use 32
	//x2 = major need to put into x1 for function call
	
	sub sp,sp, #48
	str x19, [sp,#0] 
	str x20, [sp,#8]  
	str x21, [sp,#16]
	str x22, [sp,#24]
	str x23, [sp,#32]
	str x30, [sp,#40]
	
	mov x3, #0// set i
	mov x4, #0 // set used
	mov x19, x0//save board
	mov x20, x1//save get_within
	mov x21, x2//save major
	mov x22, x3// save i
	mov x23, x4// save used
	mov x5,#0//cell = 0 is made by return so dont need to save
	mov x6,#0//bit_position = 0 is created by cell every time so dont need to save

main_loop:
	cmp x22, #9
	bge end // if i > 9 end loop
	//cell = get_within(board,major,i)
	mov x0, x19
	mov x1, x21
	mov x2, x22	
	blr x20 // branch with link register to get_within
	
	mov x5, x0// the return value was put into x30 so now transfer that to cell so
	cmp x5, #0
	ble increment// if cell > 0 move on else increment
	
	mov x12, #1 // to appease the compiler
	lsl x6, x12, x5 // bit = 1 << cell
	and x10, x23, x6
	cmp x10, #0
	beq no_conflict// if bit = 0 then no conflict

	mov x0, #1
	ldr x19, [sp,#0] // restore all callee saved
        ldr x20, [sp,#8]
        ldr x21, [sp,#16]
        ldr x22, [sp,#24]
        ldr x23, [sp,#32]
        ldr x30, [sp,#40]

	add sp,sp,#48
	ret

no_conflict:
	orr x23, x23, x6

increment:
	add x22, x22, #1
	b main_loop

end:
	mov x0, #0
	ldr x19, [sp,#0] //restore all callee saved
        ldr x20, [sp,#8]
        ldr x21, [sp,#16]
        ldr x22, [sp,#24]
        ldr x23, [sp,#32]
        ldr x30, [sp,#40]

	add sp, sp, #48
	ret
