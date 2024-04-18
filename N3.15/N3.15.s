section .data
    N db 4
    incorrect db "Incorrect data", 0
    newline db 10
    space db " ", 0
    A db 'A', 0

section .text
    global _start

_start:
    ; Set N to 4
    mov byte [N], 4

    ; Compare N with 26
    cmp byte [N], 26
    jg incorrect_data

    ; Loop for i = N to 1
    movzx esi, byte [N]
    loop_i:
        ; Loop for k = i to 1
        movzx edi, byte [N]
        loop_k:
            ; Calculate Str = 'A' + (k - 1) mod 4
            mov al, 'A'
            add al, dil
            dec al
            mov [A], al

            ; Print Str
            mov eax, 4
            mov ebx, 1
            mov ecx, A
            mov edx, 1
            int 0x80

            ; Print space
            mov eax, 4
            mov ebx, 1
            mov ecx, space
            mov edx, 1
            int 0x80

            ; Decrement k
            dec edi
            cmp edi,esi
            jge loop_k

        ; Print newline
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 0x80

        ; Decrement i
        dec esi
        cmp esi, 0
        jg loop_i

    ; Exit program
    mov eax, 60
    xor edi, edi
    syscall

incorrect_data:
    ; Print "Incorrect data"
    mov eax, 4
    mov ebx, 1
    mov ecx, incorrect
    mov edx, 14
    int 0x80

    ; Exit program
    mov eax, 60
    xor edi, edi
    syscall