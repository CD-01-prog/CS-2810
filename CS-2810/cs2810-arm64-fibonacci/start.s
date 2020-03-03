        		.global _start

        		.equ    sys_exit, 93
        		.text
_start:
        		// call fibonacci with parameter set to 5
        		mov     x0, #5
        		bl      fibonacci

        		// use the return value as the exit status code
        		// for input 5, expected output is 5
        		mov     x8, #sys_exit
        		svc     #0
