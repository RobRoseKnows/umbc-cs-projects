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


        SECTION .data                           ; initialized data section

; Lookup Table
; Letters are listed above their corresponding codes. Escape characters
; are marked with a star
;                  *a  *b   c   d   e  *f   g   h   i   j   k   l   m
esc_lookup:     db 07, 08, -1, -1, -1, 12, -1, -1, -1, -1, -1, -1, -1 
;                  *n   o   p   q  *r   s  *t   u  *v   w   x   y   z
                db 10, -1, -1, -1, -1, -1, 09, -1, 11, -1, -1, -1, -1

; Prompting messages
prompt_msg:     db "Enter string: "     ; user prompt
prompt_len:     equ $-prompt_msg        ; length of first message

orig_msg:       db "Original: "         ; original string label
orig_len:       equ $-orig_msg          ; length of second message

conver_msg:     db "Convert:  "         ; converted string label
conver_len:     equ $-conver_msg

; Error Messages
generr_msg:     db 10, "Error: reading error!", 10
generr_len:     equ $-generr_msg

octal_msg:      db 10, "Error: octal value overflow!", 10
octal_len:      equ $-octal_msg

escape_msg:     db 10, "Error: unknown escape sequence ", 92   ; Add backslash
escpae_len:     equ $-escape_msg

; Some magic numbers

; Bounds for our characters
POS_CHAR_a:     equ 97
POS_CHAR_z:     equ 122

; Bounds for octal numbers
POS_F_OCT:      equ 48
POS_L_OCT:      equ 55 

; This is for the backslash 
ESC_CHAR:       equ 92



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
        mov     ecx, prompt_msg               ; Arg2: addr of message
        mov     edx, prompt_len               ; Arg3: length of message
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
        mov     ecx, generr_msg
        mov     edx, generr_len
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

; Label to top of the loop
L1_top:

; Checking if the character is the null character.
        mov     al, [esi]               ; get a character
        cmp     al, 0                   ; check null
        je      L1_end                  ; if it is, jump to the end.


        inc     esi                     ; update source pointer

        cmp     al, ESC_CHAR            ; did we hit the escape character?
        jne     L1_cont                 ; If it's not, keep going.
        cmp     al, 'z'                 ; more than 'z'?
        ja      L1_cont
        and     al, 11011111b           ; convert to uppercase

L1_cont:
        mov     [edi], al               ; store char in new string
        inc     edi                     ; update dest pointer
        dec     ecx                     ; update char count
        jnz     L1_top                  ; loop to top if more chars
L1_end:


        ; print out user input for feedback
        ;
        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, orig_msg
        mov     edx, orig_len
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
        mov     ecx, conver_msg
        mov     edx, conver_len
        int     080h

        mov     eax, SYSCALL_WRITE      ; write out string
        mov     ebx, STDOUT
        mov     ecx, newstr
        mov     edx, [rlen]
        int     080h


; handle_ESC() subroutine
;
handle_ESC:

        mov     al, [esi]
        inc     esi


; This is a series of comparisons to check whether or not the form
check_oct:   

        ; Check to make sure the character is not less than 0
        cmp     al, '0'
        jl      handle_ESC_end

        ; Check to make sure the character is not greater than 7
        cmp     al, '7'
        jg      check_letter 

        ; The character must be an octal because we didn't find it outside
        jmp     handle_oct_top

; Series comparison to check to see if a character is a lowercase 
check_letter:
        
        ; There's nothing else we want to use below the lower case 'a'
        cmp     al, 'a'
        jl      handle_ESC_end

        ; Keep going because we still need to check for the slash
        cmp     al, 'z'
        jg      check_slash

        jmp     handle_letter_top

; Check for the backslash character
check_slash:

        cmp     al, ESC_CHAR
        je      handle_esc_char_top

        ; Send us to check else otherwise

check_else:

        jmp     unknown_err    



; This is the top of the octal digit handler code
;
handle_oct_top:

        ; Move the character into edx then subtract by 48 to get the value
        mov     edx, [al]
        sub     edx, 48

; Starts the "for" loop we use to check the next two characters
loop_oct_next_init:

        ; Cache ecx and edx. ecx may be used elsewhere as a counter 
        push    ecx
        mov     ecx, 2
        
; The body of the loop for checking characters
loop_oct_next_top:

        mov     al, [esi]
        
        ; Check to see if new character is still an octal digit
        cmp     al, '0'
        jl      loop_oct_next_end
        
        cmp     al, '7'
        jg      loop_oct_next_end

        ; Great! It's another octal digit, we can continue

        ; Increment stack
        inc     esi        
        
        ; Multiplying by 8 allows us to do octals properly
        mul     edx, 8

        ; Once again, add the character number to the total value and then 
        ; subtract 48 to get its real value.
        add     edx, [al]
        sub     edx, 48 

loop_oct_next_cont:

        ; Decrement to check another character.
        dec     ecx
        jnz     loop_oct_next_top

loop_oct_next_end:

        ; Restore count by popping it from the stack
        pop     ecx

handle_oct_end:
        
        ; Check to make sure the value is within range
        cmp     edx, 255
        jg      oct_overflow_err

        ; Just realized as I'm developing this that the character and the 
        ; octal value are the same thing. This is a simple fix to put the
        ; octal value in the accumulator. I put this after the error call
        ; to prevent overflow.
        ;
        mov     al, edx
        jmp handle_ESC_end




; Handling of lower case letters
handle_letter_:






handle_ESC_end:
                
        
        ret



; Put all the error handlers at the end so they're out of the way.

; Octal overflow error we should send when an octal value greater than 255
; is included in the string.
; 
oct_overflow_err:
        
        ; Squirrel away everything currrently in the registers so we can
        ; configure them for printing.
        push    eax
        push    ebx
        push    ecx
        push    edx        
              
        mov     eax, SYSCALL_WRITE      ; ow print error mesg
        mov     ebx, STDOUT
        mov     ecx, octal_msg
        mov     edx, octal_len
        int     080h

        ; Store return our registers to their rightful place.
        pop     edx
        pop     ecx
        pop     ebx
        pop     eax
        
        ; Move a backslash into an invalid 
        mov     al, ESC_CHAR 
        jmp     handle_ESC_end




        ; final exit
        ;
exit:   mov     eax, SYSCALL_EXIT       ; exit function
        mov     ebx, 0                  ; exit code, 0=normal
        int     080h                    ; ask kernel to take over


