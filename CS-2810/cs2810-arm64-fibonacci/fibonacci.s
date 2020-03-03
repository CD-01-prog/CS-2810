        		.global fibonacci
        		.text

// write your code here
fibonacci:
	//x0 = n
	mov x1, #1// a
	mov x2, #1// b
	mov x3, #2// i
	mov x4, #0// temp
loop:
	cmp x3, x0
	bge end
	add x4,x1,x2// temp = a+b
	mov x1,x2// a = b
	mov x2,x4// b = temp
	add x3,x3,#1 // i += 1
	b loop
end:
	mov x0,x2// return b
	ret
