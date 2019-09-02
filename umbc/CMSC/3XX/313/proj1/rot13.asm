; File: toupper.asm last updated 09/26/2001
;
; Convert user input to upper case.
;
; Assemble using NASM:  nasm -f elf toupper.asm
; Link with ld:  ld toupper.o
;

%define STDIN 0
%define STDOUT 1
%define SYSCALL_EXIT  1
%define SYSCALL_READ  3
%define SYSCALL_WRITE 4
%define BUFLEN 256


        SECTION .data                   ; initialized data section

msg1:   db "Enter string: "             ; user prompt
len1:   equ $-msg1                      ; length of first message

msg2:   db "Original: "                 ; original string label
len2:   equ $-msg2                      ; length of second message

msg3:   db "Convert:  "                 ; converted string label
len3:   equ $-msg3

msg4:   db 10, "Read error", 10         ; error message
len4:   equ $-msg4

; By storing the lookup tables for upper and lower case
; numbers separately, I should be able to save a bunch
; of time
; 
From_upper:     db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
To_upper:       db 'NOPQRSTUVWXYZABCDEFGHIJKLM'

From_lower:     db 'abcdefghijklmnopqrstuvwxyz'
To_lower:       db 'nopqrstuvwxyzabcdefghijklm'

        SECTION .bss                    ; uninitialized data section
buf:    resb BUFLEN                     ; buffer for read
newstr: resb BUFLEN                     ; converted string
rlen:   resb 4                          ; length


        SECTION .text                   ; Code section.
        global  _start                  ; let loader see entry point

_start: nop                             ; Entry point.
start:                                  ; address for gdb

        ; prompt user for input
        ;
        mov     eax, SYSCALL_WRITE      ; write function
        mov     ebx, STDOUT             ; Arg1: file descriptor
        mov     ecx, msg1               ; Arg2: addr of message
        mov     edx, len1               ; Arg3: length of message
        int     080h                    ; ask kernel to write

        ; read user input
        ;
        mov     eax, SYSCALL_READ       ; read function
        mov     ebx, STDIN              ; Arg 1: file descriptor
        mov     ecx, buf                ; Arg 2: address of buffer
        mov     edx, BUFLEN             ; Arg 3: buffer length
        int     080h

        ; error check
        ;
        mov     [rlen], eax             ; save length of string read
        cmp     eax, 0                  ; check if any chars read
        jg      read_OK                 ; >0 chars read = OK
        mov     eax, SYSCALL_WRITE      ; ow print error mesg
        mov     ebx, STDOUT
        mov     ecx, msg4
        mov     edx, len4
        int     080h
        jmp     exit                    ; skip over rest
read_OK:


        ; Loop for upper case conversion
        ; assuming rlen > 0
        ;
L1_init:
        mov     ecx, [rlen]             ; initialize count
        mov     esi, buf                ; point to start of buffer
        mov     edi, newstr             ; point to start of new string

L1_top:
        mov     al, [esi]               ; get a character
        inc     esi                     ; update source pointer

        ; This snippet to check if a character
        ; is in [A-Z] by first eliminating
        ; characters less than 'A' and then
        ; jumping if the character is less
        ; than or equal to 'Z'.
        ;
        cmp     al, 'A'                 ; less than 'A'?
        jb      L1_next_char
        cmp     al, 'Z'                 ; less than 'Z'
        jbe     L1_found_upper_letter   ; Makes using lookup table easier.         

        ; This snippet does the same as the
        ; previous one but for the range [a-z]. 
        cmp     al, 'a'                 ; less than 'a'? Meaning in the
        jb      L1_next_char            ; range (Z-a)
        cmp     al, 'z'                 ; less than 'z'?
        jbe     L1_found_lower_letter   ; Makes using lookup table easier.

        jmp L1_next_char                ; Sanity check if conditionals fail



L1_found_upper_letter:
        mov al, byte [To_upper+eax-41h] 
        jmp L1_next_char

L1_found_lower_letter:
        mov al, byte [To_lower+eax-61h]
        jmp L1_next_char

L1_next_char:
        mov     [edi], al               ; store char in new string
        inc     edi                     ; update dest pointer
        dec     ecx                     ; update char count
        jnz     L1_top                  ; loop to top if more chars

L1_end:

        ; print out user input for feedback
        ;
        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg2
        mov     edx, len2
        int     080h

        mov     eax, SYSCALL_WRITE      ; write user input
        mov     ebx, STDOUT
        mov     ecx, buf
        mov     edx, [rlen]
        int     080h

        ; print out converted string
        ;
        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg3
        mov     edx, len3
        int     080h

        mov     eax, SYSCALL_WRITE      ; write out string
        mov     ebx, STDOUT
        mov     ecx, newstr
        mov     edx, [rlen]
        int     080h


        ; final exit
        ;
exit:   mov     eax, SYSCALL_EXIT       ; exit function
        mov     ebx, 0                  ; exit code, 0=normal
        int     080h                    ; ask kernel to take over
