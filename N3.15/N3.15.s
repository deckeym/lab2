
section .data                           ; Секция данных
    sequence dq 4, 87, 129, 33, 45      ; Массив чисел
    bufferCapacity equ 20               ; Емкость буфера
    space db ' '                        ; Пробел

section .bss                            ; Секция нулевого источника
    buffer resb bufferCapacity          ; Буфер
    bf resb 1                           ; Переменная bf объемом в 1 байт

section .text                           ; Секция текста
    global _start                       ; Глобальная точка входа _start

_start:                                 ; Начало программы
    mov rbx, sequence                   ; Помещаем адрес начала массива sequence в rbx
    mov rcx, 40                         ; Помещаем число 40 в rcx (количество элементов * 8)

    call number_loop                    ; Вызываем процедуру number_loop
    call exit                           ; Вызываем процедуру exit

number_loop:                            ; Процедура number_loop
    push rsi                            ; Сохраняем значение регистра rsi на стеке
    push rdi                            ; Сохраняем значение регистра rdi на стеке
    push rdx                            ; Сохраняем значение регистра rdx на стеке

    mov rsi, 0                          ; Загружаем 0 в регистр rsi
    mov rdi, rcx                        ; Загружаем значение rcx в регистр rdi
    mov rdx, rbx                        ; Загружаем значение rbx в регистр rdx

    loop:                               ; Метка цикла
        cmp rsi, rdi                    ; Сравниваем значения rsi и rdi
        je end_loop                     ; Если они равны, переходим к метке end_loop

        mov rax, rdx[rsi]               ; Помещаем значение из массива по адресу rdx+rsi в регистр rax
        mov rbx, buffer                 ; Помещаем адрес буфера в регистр rbx
        mov rcx, bufferCapacity         ; Помещаем значение bufferCapacity в регистр rcx
        call atoi                       ; Вызываем процедуру atoi
        call is_increasing              ; Вызываем процедуру is_increasing

        cmp rax, 0                      ; Сравниваем значение rax с 0
        je no                           ; Если оно равно 0, переходим к метке no

        call reverse                    ; Вызываем процедуру reverse
        call output                     ; Вызываем процедуру output
        call print_space                ; Вызываем процедуру print_space

        no:                             ; Метка no

        add rsi, 8                      ; Увеличиваем значение rsi на 8
        jmp loop                        ; Переходим к метке loop
       
    end_loop:                           ; Метка end_loop
    
    pop rdx                             ; Извлекаем значение из стека в регистр rdx
    pop rdi                             ; Извлекаем значение из стека в регистр rdi
    pop rsi                             ; Извлекаем значение из стека в регистр rsi
    ret                                 ; Возвращаемся

is_increasing:                          ; Процедура is_increasing
    push rsi                            ; Сохраняем значение регистра rsi на стеке
    push rdx                            ; Сохраняем значение регистра rdx на стеке
    push rdi                            ; Сохраняем значение регистра rdi на стеке

    mov rsi, 0                          ; Загружаем 0 в регистр rsi
    mov rax, 0                          ; Загружаем 0 в регистр rax
    mov dl, '0'                         ; Загружаем символ '0' в регистр dl

    cmp rcx, 1                          ; Сравниваем значение rcx с 1
    je no_increasing                    ; Если они равны, переходим к метке no_increasing

    is_increasing_loop:                 ; Метка is_increasing_loop
        cmp rsi, rcx                    ; Сравниваем значения rsi и rcx
        je is_increasing_end_loop       ; Если они равны, переходим к метке is_increasing_end_loop

        cmp byte rbx[rsi], dl           ; Сравниваем байт в памяти по адресу rbx+rsi с значением в dl
        jle no_increasing               ; Если значение в rbx+rsi меньше или равно dl, переходим к метке no_increasing

        mov dl, rbx[rsi]                ; Помещаем значение из массива по адресу rbx+rsi в регистр dl
        inc rsi                         ; Увеличиваем значение rsi на 1
        jmp is_increasing_loop          ; Переходим к метке is_increasing_loop

    is_increasing_end_loop:             ; Метка is_increasing_end_loop
    mov rax, 1                          ; Помещаем 1 в регистр rax

    no_increasing:                      ; Метка no_increasing
    pop rdi                             ; Извлекаем значение из стека в регистр rdi
    pop rdx                             ; Извлекаем значение из стека в регистр rdx
    pop rsi                             ; Извлекаем значение из стека в регистр rsi
    ret                                 ; Возвращаемся

atoi:                                   ; Процедура atoi
    push rdi                            ; Сохраняем значение регистра rdi на стеке
    push rdx                            ; Сохраняем значение регистра rdx на стеке
    push rsi                            ; Сохраняем значение регистра rsi на стеке
   
    mov rsi, 10                         ; Загружаем значение 10 в регистр rsi
    mov rdi, rcx                        ; Помещаем значение rcx в регистр rdi
    mov rcx, 0                          ; Загружаем 0 в регистр rcx

    atoi_loop:                          ; Метка atoi_loop
        cmp rdi, 0                      ; Сравниваем значение rdi с 0
        jle atoi_loop_end               ; Если оно мень ше или равно 0, переходим к метке atoi_loop_end
        cmp rax, 0                      ; Сравниваем значение rax с 0
        jle atoi_loop_end               ; Если оно меньше или равно 0, переходим к метке atoi_loop_end
        
        mov rdx, 0                      ; Загружаем 0 в регистр rdx
        div rsi                         ; Делим значение в rax на значение в rsi, сохраняем остаток в rdx
        add rdx, '0'                    ; Прибавляем '0' к значению в rdx
        mov rbx[rcx], rdx               ; Помещаем значение в rdx по адресу rbx+rcx

        inc rcx                         ; Увеличиваем значение rcx на 1
        dec rdi                         ; Уменьшаем значение rdi на 1
        jmp atoi_loop                   ; Переходим к метке atoi_loop
        
    atoi_loop_end:                      ; Метка atoi_loop_end
    call reverse                        ; Вызываем процедуру reverse
    mov rax, rcx                        ; Помещаем значение rcx в rax

    pop rsi                             ; Извлекаем значение из стека в регистр rsi
    pop rdx                             ; Извлекаем значение из стека в регистр rdx
    pop rdi                             ; Извлекаем значение из стека в регистр rdi
    ret                                 ; Возвращаемся

reverse:                                ; Процедура reverse
    push rax                            ; Сохраняем значение регистра rax на стеке
    push rdx                            ; Сохраняем значение регистра rdx на стеке
    push rsi                            ; Сохраняем значение регистра rsi на стеке

    mov rax, rbx                        ; Помещаем значение rbx в rax
    mov rsi, rbx                        ; Помещаем значение rbx в rsi
    add rsi, rcx                        ; Добавляем значение rcx к rsi
    dec rsi                             ; Уменьшаем значение rsi на 1

    reverse_loop:                       ; Метка reverse_loop
        cmp rsi, rax                    ; Сравниваем значения rsi и rax
        jbe reverse_loop_end            ; Если rsi меньше или равен rax, переходим к метке reverse_loop_end
        
        mov dl, [rax]                   ; Помещаем байт из памяти по адресу rax в регистр dl
        mov dh, [rsi]                   ; Помещаем байт из памяти по адресу rsi в регистр dh
        mov [rax], dh                   ; Помещаем значение dh в память по адресу rax
        mov [rsi], dl                   ; Помещаем значение dl в память по адресу rsi

        inc rax                         ; Увеличиваем значение rax на 1
        dec rsi                         ; Уменьшаем значение rsi на 1
        jmp reverse_loop                ; Переходим к метке reverse_loop
        
    reverse_loop_end:                   ; Метка reverse_loop_end
    pop rsi                             ; Извлекаем значение из стека в регистр rsi
    pop rdx                             ; Извлекаем значение из стека в регистр rdx
    pop rax                             ; Извлекаем значение из стека в регистр rax

    ret                                 ; Возвращаемся  

output:                                 ; Процедура output
    push rax                            ; Сохраняем значение регистра rax на стеке
    push rdi                            ; Сохраняем значение регистра rdi на стеке
    push rsi                            ; Сохраняем значение регистра rsi на стеке
    push rdx                            ; Сохраняем значение регистра rdx на стеке

    mov rax, 1                          ; Загружаем 1 в регистр rax (для системного вызова write)
    mov rdi, 1                          ; Загружаем 1 в регистр rdi (для файлового дескриптора stdout)
    mov rsi, rbx                        ; Загружаем адрес буфера в регистр rsi
    mov rdx, rcx                        ; Загружаем длину строки в регистр rdx
    syscall                             ; Выполняем системный вызов

    pop rdx                             ; Извлекаем значение из стека в регистр rdx
    pop rsi                             ; Извлекаем значение из стека в регистр rsi
    pop rdi                             ; Извлекаем значение из стека в регистр rdi
    pop rax                             ; Извлекаем значение из стека в регистр rax

    ret                                 ; Возвращаемся

print_space:                            ; Процедура print_space
    push rbx                            ; Сохраняем значение регистра rbx на стеке
    push rcx                            ; Сохраняем значение регистра rcx на стеке

    mov rbx, space                      ; Загружаем символ пробела в регистр rbx
    mov rcx, 1                          ; Загружаем 1 в регистр rcx
    call output                         ; Вызываем процедуру output

    pop rcx                             ; Извлекаем значение из стека в регистр rcx
    pop rbx                             ; Извлекаем значение из стека в регистр rbx
    
    ret                                 ; Возвращаемся

exit:                                   ; Процедура exit
    mov rax, 60                         ; Загружаем 60 в регистр rax (для системного вызова exit)
    mov rdi, 0                          ; Загружаем 0 в регистр rdi (код завершения)
    syscall                             ; Выполняем системный вызов
