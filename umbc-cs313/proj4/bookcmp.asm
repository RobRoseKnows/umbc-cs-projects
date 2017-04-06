# File:     bookcmp.asm
# Author:   Robert Rose
#
# Project 4
#
# Compares two book structs.
`
%define STDIN 0
%define STDOUT 1
%define SYSCALL_EXIT  1
%define SYSCALL_READ  3
%define SYSCALL_WRITE 4
%define BUFLEN 256


        SECTION .data                   ; initialized data section

err_msg:   db 10, "Read error", 10         ; error message
err_len:   equ $-err_msg


        SECTION .bss                ; uninitialized data section
divbuf: resb BUFLEN                 ; buffer to place into reverse wise
strbuf: resb BUFLEN                 ; buffer to put in right order.
prtlen: resb 4

stkptr: resb 4                      ; the first thing on the stack

to_prt: resb 4                      ; the decimal number we'll print after
                                    ; we take it from the stack and before
                                    ; we store it in a register

        SECTION .text               ; Code section.
        global  bootcmp             ; let loader see entry point
        
    extern book1, book2

bookcmp: nop                        ; Entry point.
start:                              ; address for gdb

        ; This solved a problem I was having with a segfault. The thing to
        ; print is the second thing on the stack, not the first thing. The
        ; call pointer is first.
        pop     dword [stkptr]

        ; Since we need to preserve all registers, we'll pop the decimal into
        ; into memory.
        pop     dword [to_prt]

        ; Push all the registers to the stack.
        pusha
       
        ; Loop through dividing by 10 each time
        ; Set esi to equal buf + BUFLEN
        ; Store the remainders in reverse at the end of the buffer. (at esi)
        ; decrement esi each time
        ; inc ecx still though
        ; once we're done, store ecx to prtlen
        ; set edi equal to strbuf, that's where we'll transfer what two print
        ; now transfer what's in esi to edi and inc each one
        ; decrement ecx each time.
        ; when ecx is 0, we're done and we should print what's in strbuf

        ; Storing characters
        ; we can add '0' to dl which is th remainer

dloop_init:
        ; Move the number into place 
        mov     eax, [to_prt]
        mov     edx, 0                  ; zero out edx because of div 
        
        mov     ecx, 0
        
        ; Technically, edi would be most suited for the register here however
        ; since we'll be using esi and edi to transfer things later in the
        ; program, I decided just to use esi here so I don't have to swap it
        ; later and confuse which one it is at the time.
        mov     esi, divbuf
        add     esi, BUFLEN
        dec     esi

        mov     ebx, 10

; Divide loop
dloop_top:
        div     ebx
        add     dl, '0'                 ; Get the ascii of the remainder.
        ; I know on the first project notes you said that it'd be best to use
        ; the numerical value for 0 here, I prefer using the character way
        ; because it doesn't use magic numbers.

        mov     [esi], dl
        

dloop_cont: 
        mov     edx, dword 0

        inc     ecx
        
        ; See if we've divided all the way. 
        ; We have to do this after we've already put saved one thing in the
        ; string. Otherwise if we were initially provided a zero (or anything
        ; less than 10) we'd never print anything.
        cmp     eax, 0
        je      dloop_end
        
        ; Put this after the status check so we don't decrement past the top
        dec     esi
        jmp     dloop_top

dloop_end:
        ; Move ecx to the prtlen memory spot so wer can use ecx to track
        ; where we are iterating.
        mov     [prtlen], ecx
        
; The tloop is where we transfer the data at the end of the divbuf to the 
; beginning of prtbuf so we can print it properly. 
tloop_init:
        mov     edi, strbuf

; Mov the character in the old string into the new string.
tloop_top:
        mov     bl, byte [esi]
        mov     [edi], bl

tloop_cont:
        ; Inc/dec the *i pointers
        inc     edi
        inc     esi
        
        ; Decrement ecx and see if we can continue going.
        dec     ecx        
        jnz     tloop_top

tloop_end:
        ; Nothing to do here, I just wanted to be consistent.

do_prt:
        ; print out the buffer.
        ;
        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, strbuf
        mov     edx, [prtlen]
        int     080h

exit: 
        ; Fix the registers.
        popa

        ; Put things back on the stack.
        push    dword [to_prt]
        push    dword [stkptr]
        ret        

