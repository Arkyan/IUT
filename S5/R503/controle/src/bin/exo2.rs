use std::io;
use std::io::Read;

fn main() {
    let mut string = String::new();
    io::stdin()
        .read_to_string(&mut string)
        .expect("ff");

    let lines = string.lines();

    for line in lines {
        let mut result = 0;
        let values = line.split_whitespace();
        for value in values {
            if value.parse::<i32>().is_ok() {
                result += value.parse::<i32>().unwrap();
            }
        }
        println!("{}", result)
    }
}