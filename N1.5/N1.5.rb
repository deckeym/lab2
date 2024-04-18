def string_fixer(line)
    work_row = line.dup
    count = 0
    i = 0
    global_count = 0  # Initialize global_count here
    while i < work_row.length - 1
      code_symbol = work_row[i].ord
      code_symbol += 1
      next_symbol = code_symbol.chr
      if work_row[i] == work_row[i + 1]
        count += 1
      end
      if count == 2
        work_row.insert(i + 1, next_symbol)
        count = 0
        global_count += 1
      end
      i += 1
    end
    [work_row, global_count]
  end
  
  puts "Enter row, please - "
  line = gets.chomp
  global_count = 0
  final_row, global_count = string_fixer(line)
  puts "\nFixed row - #{final_row}\nValue of changes - #{global_count}"
  