
use std::io;

fn string_fixer(line: &str, global_count: &mut i32) -> String {
    let mut work_row = line.to_string();
    let mut count = 0;
    let mut i = 0;
    while i < work_row.len() - 1 {
        let code_symbol = work_row.as_bytes()[i] as i32;
        let next_symbol = (code_symbol + 1) as u8 as char;
        if work_row.as_bytes()[i] == work_row.as_bytes()[i + 1] {
            count += 1;
        }
        if count == 2 {
            work_row.insert(i + 1, next_symbol);
            count = 0;
            *global_count += 1;
        }
        i += 1;
    }
    work_row
}

fn main() {
    let mut global_count = 0;
    println!("Enter row, please - ");
    let mut line = String::new();
    io::stdin().read_line(&mut line).expect("Failed to read line");
    let final_row = string_fixer(&line, &mut global_count);
    println!("Fixed row - {}", final_row);
    println!("Value of changes - {}", global_count);
}
