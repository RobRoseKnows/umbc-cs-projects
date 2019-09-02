; File:     bookcmp.asm
; Author:   Robert Rose
;
; Project 4
;
; Compares two book structs.`
%define STDIN 0
%define STDOUT 1
%define SYSCALL_EXIT  1
%define SYSCALL_READ  3
%define SYSCALL_WRITE 4
%define BUFLEN 256

; The field lengths
%define TITLE_LEN       32
%define AUTHOR_LEN      20
%define SUBJECT_LEN     10

; Just a reminder of what the struct looks like.
;    char author[AUTHOR_LEN + 1];    /* first author */
;    char title[TITLE_LEN + 1];
;    char subject[SUBJECT_LEN + 1];  /* Nonfiction, Fantasy, Mystery, ... */
;    unsigned int year;              /* year of e-book release */

; The offsets we can add.
%define AUTHOR_OFFSET   0
%define TITLE_OFFSET    AUTHOR_OFFSET + AUTHOR_LEN + 2
%define SUBJECT_OFFSET  TITLE_OFFSET + TITLE_LEN + 2
%define YEAR_OFFSET     SUBJECT_OFFSET + SUBJECT_LEN + 2


        SECTION .data                   ; initialized data section

finans: dd 0

        SECTION .bss                ; uninitialized data section

        ; Nothing here.

        SECTION .text               ; Code section.
        global  bookcmp             ; let loader see entry point
        
    extern book1, book2

bookcmp: nop                        ; Entry point.
start:                              ; address for gdb

        ; Push all the registers to the stack.
        pusha

        ; Move the book pointers into registers
        mov     ebx, [book1]
        mov     ecx, [book2]

cmp_years:
        
        mov     al, byte [ebx + YEAR_OFFSET]
        mov     ah, byte [ecx + YEAR_OFFSET]
        cmp     al, ah
        jl      set_less
        jg      set_greater    
    
check_titles:
cloop_init:

        ; esi will be the pointer to book1's title
        lea     esi, [ebx + TITLE_OFFSET]

        ; edi will be the pointer to book2's title
        lea     edi, [ecx + TITLE_OFFSET]

; Divide loop
cloop_top:

        ; Check the titles.
        mov     al, byte [esi]
        mov     ah, byte [edi]
        
        cmp     al, ah
        ; Set them equal if we have a result...
        jl      set_less
        jg      set_greater
        ; ..Otherwise let it move to the next.

cloop_cont: 
        ; If we get here, it means they're equal.

        ; We can check if we've reached the end by checking if one of them
        ; is equal to \0 (because we know they're already equal)
        cmp     byte [esi], 0
        je      set_equal       
 
        inc     esi
        inc     edi
        jmp     cloop_top
            
cloop_end:
                

set_less:
        mov     eax, -1
        jmp     exit 

set_greater:
        mov     eax,  1
        jmp     exit

set_equal:
        mov     eax,  0
        jmp     exit

exit:
        ; Stash eax for a second.
        mov     [finans], eax
 
        ; Fix the registers.
        popa

        ; Unstash eax
        mov     eax, [finans]
        
        ret        

