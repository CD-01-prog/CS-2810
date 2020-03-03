                .global am_or_fm

                .text
am_or_fm:
                // checks to see if value is within fm or am range and returns 2 if am, 1 if fm, 0 if //                non

                cmp x0, #87
                ble quit

                cmp x0, #108
                ble am

                cmp x0, #534
                ble quit

                cmp x0, #1605
                ble fm

                b quit
am:
                mov x0, #2
                ret
fm:
                mov x0, #1
                ret
quit:
                mov x0, #0
                ret

