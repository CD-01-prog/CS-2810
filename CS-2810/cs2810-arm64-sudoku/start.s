                .global _start

                .equ    sys_exit, 93

                // here is a valid, fully solved board
                .data
board:          
		.byte   8,0,0, 7,0,3, 0,0,5
                .byte   0,7,0, 9,0,0, 6,1,3
                .byte   0,2,6, 5,0,1, 0,7,8

                .byte   5,4,2, 8,9,0, 0,0,0
                .byte   6,0,7, 1,0,0, 5,9,0
                .byte   0,0,0, 0,0,0, 8,0,0

                .byte   1,0,8, 2,0,0, 3,0,0
                .byte   2,0,0, 0,0,0, 7,0,0
                .byte   0,6,3, 0,8,0, 2,5,1

                .text
                // call solve and use whatever it returns
                // as the exit status code
                //
                // in this case, the expected output is 0 since the
                // entire board is solved and valid.
_start:
                ldr     x0, =board
                bl      solve

                mov     x8, #sys_exit
                svc     #0
