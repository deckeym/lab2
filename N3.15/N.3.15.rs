use std::io;

fn reglament_check(num: i32) -> bool {
    let mut prev_digit = num % 10;
    let mut num = num / 10;
    while num != 0 {
        let current_digit = num % 10;
        if current_digit <= prev_digit {
            prev_digit = current_digit;
            num /= 10;
        } else {
            return false;
        }
    }
    true
}

fn num_reverser(num_blank: i32) -> i32 {
    if reglament_check(num_blank) {
        let mut reversed_num = 0;
        let mut num_blank = num_blank;
        while num_blank != 0 {
            reversed_num = reversed_num * 10 + num_blank % 10;
            num_blank /= 10;
        }
        reversed_num
    } else {
        0
    }
}

fn main() {
    const DEFAULT_COUNT: i32 = 4;
    let n = DEFAULT_COUNT;

    for _ in 0..n {
        let mut number = String::new();
        io::stdin().read_line(&mut number).expect("Failed to read line");
        let number: i32 = number.trim().parse().expect("Please enter a number");
        println!("{} ", num_reverser(number));
    }
}