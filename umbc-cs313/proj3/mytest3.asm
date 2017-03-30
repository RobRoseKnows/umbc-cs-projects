; File: main.asm
;
; main program that exercises the prt_dec subroutine
;

%define STDIN 0
%define STDOUT 1
%define SYSCALL_EXIT  1
%define SYSCALL_READ  3
%define SYSCALL_WRITE 4

        SECTION .data                   ; initialized data section

lf:   	db  10            		; just a linefeed 
comma:  db ", "

msg1:	db " plus "	
len1 equ $ - msg1

msg2: 	db " minus "
len2 equ $ - msg2

msg3:	db " equals "
len3 equ $ - msg3


; REGister BEGinning
regbeg:	    db "EAX, EDX, EDI, EDP at beginning: "	
; ReGister Beginning LENgth
rgblen:     equ $ - regbeg

; REGister END
regend: 	db "EAX, EDX, EDI, EDP at end: "
; ReGister End LENgth
rgelen:     equ $ - regend

; EAX DESired
eaxdes:     equ 42
; EDX DESired
edxdes:     equ 0x0
; EDI DESired
edides:     equ 2001002
; EDP DESired
edpdes:     equ 0xFFFFFFFF 
        SECTION .text                   ; Code section.
        global  _start                  ; let loader see entry point
	extern	prt_dec

_start: 
	mov	eax, eaxdes
	mov	edx, edxdes
	mov	edi, edides
	mov	ebp, edpdes 

    ; Push all the registers.
    pusha
 
        ; Print out the registers at the beginning so we can check to see
        ; if they change.
        mov     eax, SYSCALL_WRITE
        mov     ebx, STDOUT
        mov     ecx, regbeg
        mov     edx, rgblen
        int     080h

    popa
 
	push	eax
	call	prt_dec
	add	esp, 4
	call	prt_comma

	push	edx
	call	prt_dec
	add	esp, 4
	call	prt_comma
	
	push	edi
	call	prt_dec
	add	esp, 4
	call	prt_comma

	push	ebp
	call	prt_dec
	add	esp, 4
	call	prt_lf


    push	dword 0x0
	call	prt_dec
	add	esp, 4
	call	prt_lf

	push	dword 0xFFFFFFFF
	call	prt_dec
	add	esp, 4
	call	prt_lf

	push	31415926
	call	prt_dec
	add	esp, 4
	call	prt_lf

	push	2
	call	prt_dec
	add	esp, 4
    pusha

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg1
        mov     edx, len1
        int     080h

    popa	
	push	3
	call	prt_dec
	add	esp, 4
    pusha

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg3
        mov     edx, len3
        int     080h

    popa
	push	5
	call	prt_dec
	add	esp, 4
	call	prt_lf

	push	7
	call	prt_dec
	add	esp, 4
    pusha

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg2
        mov     edx, len2
        int     080h
	
    popa
	push	4
	call	prt_dec
	add	esp, 4
    pusha

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, msg3
        mov     edx, len3
        int     080h

    popa
	push	3
	call	prt_dec
	add	esp, 4
	call	prt_lf




    ; Push all the registers.
    pusha
 
        ; Print out the registers at the beginning so we can check to see
        ; if they change.
        mov     eax, SYSCALL_WRITE
        mov     ebx, STDOUT
        mov     ecx, regbeg
        mov     edx, rgblen
        int     080h

    popa

	push	eax
	call	prt_dec
	add	esp, 4
	call	prt_comma

	push	edx
	call	prt_dec
	add	esp, 4
	call	prt_comma
	
	push	edi
	call	prt_dec
	add	esp, 4
	call	prt_comma

	push	ebp
	call	prt_dec
	add	esp, 4
	call	prt_lf
    

    

        ; final exit
        ;
exit:   mov     EAX, SYSCALL_EXIT       ; exit function
        mov     EBX, 0                  ; exit code, 0=normal
        int     080h                    ; ask kernel to take over



	; A subroutine to print a LF, all registers are preserved
prt_lf:
	push	eax
	push	ebx
	push	ecx
	push	edx

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, lf
        mov     edx, 1			; LF is a single character
        int     080h

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret


	; A subroutine to print a comma, all registers are preserved
prt_comma:
	push	eax
	push	ebx
	push	ecx
	push	edx

        mov     eax, SYSCALL_WRITE      ; write message
        mov     ebx, STDOUT
        mov     ecx, comma
        mov     edx, 2			; we're actually printing a comma and a space
        int     080h

	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	ret
