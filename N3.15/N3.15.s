section .data
    N db 4                    ; объявление переменной N типа байт и присвоение ей значения 4
    incorrect db "Incorrect data", 0  ; объявление строки "Incorrect data" с завершающим нулевым байтом
    newline db 10              ; объявление переменной newline и присвоение ей значения 10 (код символа новой строки)
    space db " ", 0            ; объявление переменной space и присвоение ей значения пробела с завершающим нулевым байтом
    A db 'A', 0               ; объявление переменной A и присвоение ей значения 'A' с завершающим нулевым байтом

section .text
    global _start

_start:
    ; Set N to 4
    mov byte [N], 4           ; перемещение значения 4 в переменную N

    ; Compare N with 26
    cmp byte [N], 26          ; сравнение значения в N с 26
    jg incorrect_data         ; переход к метке incorrect_data, если значение в N больше 26

    ; Loop for i = N to 1
    movzx esi, byte [N]       ; загрузка значения N в регистр esi (расширение до 32 бит)
    loop_i:
        ; Loop for k = i to 1
        movzx edi, byte [N]   ; загрузка значения N в регистр edi (расширение до 32 бит)
        loop_k:
            ; Calculate Str = 'A' + (k - 1) mod 4
            mov al, 'A'         ; перемещение значения 'A' в регистр al
            add al, dil         ; прибавление значения dil к al
            dec al              ; уменьшение значения al на 1
            mov [A], al         ; сохранение значения al в переменной A

            ; Print Str
            mov eax, 4          ; помещение номера системного вызова для вывода в eax
            mov ebx, 1          ; помещение номера файлового дескриптора (stdout) в ebx
            mov ecx, A          ; помещение адреса строки A в ecx
            mov edx, 1          ; помещение длины строки в edx
            int 0x80            ; вызов прерывания для вывода

            ; Print space
            mov eax, 4          ; помещение номера системного вызова для вывода в eax
            mov ebx, 1          ; помещение номера файлового дескриптора (stdout) в ebx
            mov ecx, space      ; помещение адреса строки space в ecx
            mov edx, 1          ; помещение длины строки в edx
            int 0x80            ; вызов прерывания для вывода

            ; Decrement k
            dec edi             ; уменьшение значения edi
            cmp edi,esi         ; сравнение значения edi с esi
            jge loop_k          ; переход к метке loop_k, если значение edi больше или равно esi

        ; Print newline
        mov eax, 4              ; помещение номера системного вызова для вывода в eax
        mov ebx, 1              ; помещение номера файлового дескриптора (stdout) в ebx
        mov ecx, newline        ; помещение адреса переменной newline в ecx
        mov edx, 1              ; помещение длины строки в edx
        int 0x80                ; вызов прерывания для вывода

        ; Decrement i
        dec esi                 ; уменьшение значения esi
        cmp esi, 0              ; сравнение значения esi с 0
        jg loop_i               ; переход к метке loop_i, если значение esi больше 0

    ; Exit program
    mov eax, 60                 ; помещение номера системного вызова для выхода из программы в eax
    xor edi, edi                ; помещение 0 в регистр edi
    syscall                     ; вызов системного вызова для выхода

incorrect_data:
    ; Print "Incorrect data"
    mov eax, 4                  ; помещение номера системного вызова для вывода в eax
    mov ebx, 1                  ; помещение номера файлового дескриптора (stdout) в ebx
    mov ecx, incorrect          ; помещение адреса строки incorrect в ecx
    mov edx, 14                 ; помещение длины строки в edx
    int 0x80                    ; вызов прерывания для вывода

    ; Exit program
    mov eax, 60                 ; помещение номера системного вызова для выхода из программы в eax
    xor edi, edi                ; помещение 0 в регистр edi
    syscall                     ; вызов системного вызова для выхода
