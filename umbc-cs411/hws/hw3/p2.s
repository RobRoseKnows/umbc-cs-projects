// File: p2.s
// Multiply matrices.

.data
var_a1: .word 1
var_a2: .word 2
var_a3: .word 3
var_a4: .word 4

var_b1: .word 9
var_b2: .word 8
var_b3: .word 7
var_b4: .word 6

.text
.global _start

_start:
    MOV r0, #0

    // a1 * b1
    STR r1, adr_var_a1
    STR r2, adr_var_b1
    MUL r3, r1, r2

    // Reset r4
    MOV r4, r0

    // Accumulate the result in r3
    ADD r4, r3

    // a2 * b2
    STR r1, adr_var_a2
    STR r2, adr_var_b2
    MUL r3, r1, r2

    // Accumulate the result again
    ADD r4, r3

    // a3 * b3
    STR r1, adr_var_a3
    STR r2, adr_var_b3
    MUL r3, r1, r2

    // Accumulate the result again
    ADD r4, r3

    // a4 * b4
    STR r1, adr_var_a4
    STR r2, adr_var_b4
    MUL r3, r1, r2

    // Accumulate the result again
    ADD r4, r3

    // store result to end memory address
    STR r4, adr_var_C


// [ a1 a2 a3 a4 ]
adr_var_a1: .word var_a1
adr_var_a2: .word var_a2
adr_var_a3: .word var_a3
adr_var_a4: .word var_a4

// [
//   b1
//   b2
//   b3
//   b4
// ]
adr_var_b1: .word var_b1
adr_var_b2: .word var_b2
adr_var_b3: .word var_b3
adr_var_b4: .word var_b4

adr_var_C: .word 0

// D11 D12 D13 D14
// D21 D22 D23 D24
// D31 D32 D33 D34
// D41 D42 D43 D44
adr_var_D11: .word 0
adr_var_D12: .word 0
adr_var_D13: .word 0
adr_var_D14: .word 0

adr_var_D21: .word 0
adr_var_D22: .word 0
adr_var_D23: .word 0
adr_var_D24: .word 0

adr_var_D31: .word 0
adr_var_D32: .word 0
adr_var_D33: .word 0
adr_var_D34: .word 0

adr_var_D41: .word 0
adr_var_D42: .word 0
adr_var_D43: .word 0
adr_var_D44: .word 0
