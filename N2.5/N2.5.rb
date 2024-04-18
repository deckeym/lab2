def word_converter(fourth_blank)
    fourth_blank.chars.permutation.to_a.uniq.map(&:join)
  end
  
  def string_splitter(enter_string)
    enter_string.split(' ')
  end
  
  def translate(word_to_translate, dictionary)
    word_to_translate.chars.map { |char| dictionary[char] }.join
  end
  
  def main(enter_string)
    dictionary = {
      'a' => '.-', 'b' => '-...', 'w' => '.--', 'g' => '--.', 'd' => '-..',
      'e' => '.', 'v' => '...-', 'z' => '--..', 'i' => '..', 'j' => '.---',
      'k' => '-.-', 'l' => '.-..', 'm' => '--', 'n' => '-.', 'o' => '---',
      'p' => '.--.', 'r' => '.-.', 's' => '...', 't' => '-', 'u' => '..-',
      'f' => '..-.', 'h' => '....', 'c' => '-.-.', 'q' => '--.-', 'y' => '-.--', 'x' => '-..-'
    }
  
    splitted_string = string_splitter(enter_string)
  
    bool_check_of_word_length = splitted_string.all? { |word| word.length <= 9 }
    bool_check_of_string_length = enter_string.length.between?(1, 100)
  
    if bool_check_of_string_length && bool_check_of_word_length
      all_combinations = splitted_string.flat_map { |word| word_converter(word) }
      translated_all_combinations = all_combinations.map { |word| translate(word, dictionary) }
      unique_morse_count = translated_all_combinations.uniq.size
  
      puts "\nAll combinations and their Morse translation: "
      all_combinations.zip(translated_all_combinations).each do |comb, translation|
        puts "#{comb} = (#{translation})"
      end
  
      puts "Number of unique Morse code translations: #{unique_morse_count}"
    else
      puts "Please, enter correct string"
    end
  end
  
  # Example usage:
  input_string = "ign igg ezn smg"
  main(input_string)