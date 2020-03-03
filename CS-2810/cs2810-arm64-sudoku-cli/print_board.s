                .global print_board
                .equ    stdout, 1
                .equ    sys_write, 64
                .text

// print_board(board) -> 0 for success, >0 for error
print_board:
				// your code goes here
				ret
