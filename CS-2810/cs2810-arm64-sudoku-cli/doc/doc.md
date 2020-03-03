Write a function to print a formatted Sudoku board:

    print_board(board) -> 0 for success, >0 for failure

The output should be printed to stdout and should look like:

    +-------+-------+-------+
    | 8 1 9 | 7 6 3 | 4 2 5 |
    | 4 7 5 | 9 2   | 6 1 3 |
    | 3 2 6 | 5 4 1 | 9 7 8 |
    +-------+-------+-------+
    | 5 4 2 | 8 9 7 | 1 3 6 |
    | 6 8 7 | 1 3 4 | 5 9 2 |
    | 9   1 | 6 5 2 | 8 4 7 |
    +-------+-------+-------+
    | 1 9 8 | 2 7 5 | 3 6 4 |
    | 2 5 4 | 3 1 6 | 7 8 9 |
    | 7 6 3 | 4 8 9 | 2 5 1 |
    +-------+-------+-------+

(your output should not be indented)

You may find it helpful to write this in another language before
starting it in assembly language.

A couple of notes:

*   There are really two kinds of lines here. One of them is just a
    constant string that you just need to print. This might be a
    good place to start: have your function print the first line
    (including the newline at the end) and nothing else.

*   The lines with numbers all follow the same format. One approach
    is to create a string in the data segment with the correct
    spacing and formatting, then have your function put the correct
    digits (and blanks) in place before printing the string. Then
    you could re-use the template for the next line, etc.

To create a string in the data segment, you can use:

                    .data
    .template:      .ascii  "| 1 2 3 | 4 5 6 | 7 8 9 |\n"
                    .equ    .template_size, .-template

This will create two labels: `.template` will be the address of the
string, and `.template_size` will be the length of the string.

When you create a data segment with strings, it is likely that you
will end up with a segment whose length is not a multiple of 8. To
prevent resulting alignment issues, you can end the segment with:

                    .balign 8

This instructs the assembler to add extra junk bytes if necessary
to pad the segment out to a multiple of 8.

To test this code, just run "make", which will run your code and
compare its output to the expected output. If it finds a line that
mismatches, it will show you what it saw and what it expected so you
can correct your code.

Note that the output should be the exact board displayed above
(based on the board defined in `start.s`). If you modify `start.s`,
you will need to restore it to its original state to ensure that the
output is correct. You can always delete it and run "grind save" to
re-load the original version.
