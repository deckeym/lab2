use std::collections::{HashMap, HashSet};

fn word_converter(fourth_blank: &str) -> Vec<String> {
    let mut converted_word = Vec::new();
    let mut blank_word = fourth_blank.chars().collect::<Vec<_>>();
    blank_word.sort();
    converted_word.push(blank_word.iter().collect());
    while next_permutation(&mut blank_word) {
        converted_word.push(blank_word.iter().collect());
    }
    converted_word
}

fn next_permutation(arr: &mut [char]) -> bool {
    let mut i = arr.len() - 1;
    while i > 0 && arr[i - 1] >= arr[i] {
        i -= 1;
    }
    if i <= 0 {
        return false;
    }
    let mut j = arr.len() - 1;
    while arr[j] <= arr[i - 1] {
        j -= 1;
    }
    arr.swap(i - 1, j);
    arr[i..].reverse();
    true
}

fn string_splitter(enter_string: &str) -> Vec<String> {
    enter_string.split_whitespace().map(|s| s.to_string()).collect()
}

fn translate(word_to_translate: &str, dictionary: &HashMap<&str, &str>) -> String {
    let mut translated_word = String::new();
    for c in word_to_translate.chars() {
        if let Some(&morse) = dictionary.get(&c.to_string().as_str()) {
            translated_word.push_str(morse);
        }
    }
    translated_word
}

fn unic_checker(translated_all_combinations: &[String], rn_comb: &str) -> Option<String> {
    let mut sos = 0; // ScoreOfSames
    for word in translated_all_combinations {
        if rn_comb == word {
            sos += 1;
        }
    }
    if sos > 1 {
        None
    } else {
        Some(rn_comb.to_string())
    }
}

fn main() {
    let dictionary: HashMap<&str, &str> = [
        ("a", ".-"), ("b", "-..."), ("w", ".--"), ("g", "--."), ("d", "-.."),
        ("e", "."), ("v", "...-"), ("z", "--.."), ("i", ".."), ("j", ".---"),
        ("k", "-.-"), ("l", ".-.."), ("m", "--"), ("n", "-."), ("o", "---"),
        ("p", ".--."), ("r", ".-."), ("s", "..."), ("t", "-"), ("u", "..-"),
        ("f", "..-."), ("h", "...."), ("c", "-.-."), ("q", "--.-"), ("y", "-.--"), ("x", "-..-")
    ].iter().cloned().collect();
    
    let enter_string = "ign igg ezn smg"; // Введите вашу строку здесь
    
    let splitted_string = string_splitter(enter_string);
    
    let bool_check_of_word_length = splitted_string.iter().all(|word| word.len() <= 9);
    let bool_check_of_string_length = enter_string.len() <= 100 && enter_string.len() >= 1;
    
    if !bool_check_of_string_length || !bool_check_of_word_length {
        println!("Please, enter correct string");
    } else {
        let mut all_combinations = Vec::new();
        for fourth_blank in &splitted_string {
            for combination in word_converter(fourth_blank) {
                all_combinations.push(combination);
            }
        }
        let translated_all_combinations: Vec<String> = all_combinations
            .iter()
            .map(|word| translate(word, &dictionary))
            .collect();
        
        let mut unic_combinations = HashSet::new();
        for rn_comb in &translated_all_combinations {
            if let Some(six_blank) = unic_checker(&translated_all_combinations, rn_comb) {
                unic_combinations.insert(six_blank);
            }
        }
        
        println!();
        println!("All combinations and their Morze translation: ");
        for (output_count, combination) in all_combinations.iter().enumerate() { // В этой строке мы изменили образец шаблона для ссылки на элемент
            println!("{} = ({})", combination, translated_all_combinations[output_count]);
        }
        
        println!("Unic words: ");
        for output in &unic_combinations {
            println!("({})", output);
        }
        
        println!("____________________________________________________");
        println!("               Value of unic words - {}", unic_combinations.len());
    }
}
