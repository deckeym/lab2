def string_fixer(line):
    work_row = line
    count = 0
    added_count = 0  # Добавленный счётчик
    i = 0
    while i < len(work_row) - 1:
        code_symbol = ord(work_row[i])
        code_symbol += 1
        next_symbol = chr(code_symbol)
        if work_row[i] == work_row[i + 1]:
            count += 1
        if count == 2:
            work_row = work_row[:i + 1] + next_symbol + work_row[i + 1:]
            added_count += 1  # Увеличиваем счётчик при добавлении символа
            count = 0
        i += 1
    return work_row, added_count  # Возвращаем исходную строку и добавленное количество символов

line = input("Введите строку, пожалуйста - ")
final_row, global_count = string_fixer(line)
print("\nИсправленная строка -", final_row)
print("Количество внесённых изменений -", global_count)
