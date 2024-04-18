def reglament_check(num)
    prev_digit = num % 10
    num = num / 10
    while num != 0
      current_digit = num % 10
      if current_digit <= prev_digit
        prev_digit = current_digit
        num /= 10
      else
        return false
      end
    end
    true
  end
  
  def num_reverser(num_blank)
    if reglament_check(num_blank)
      reversed_num = 0
      while num_blank != 0
        reversed_num = reversed_num * 10 + num_blank % 10
        num_blank /= 10
      end
      reversed_num
    else
      0
    end
  end
  
  # Define the numbers you want to process
  numbers = [1234, 4321, 2111, 9876]
  
  numbers.each do |number|
    puts "#{num_reverser(number)} "
  end
  puts