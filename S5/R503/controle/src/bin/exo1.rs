use std::io::{self, prelude::*};

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).expect("ff");
    let mut lines = input.lines();

    let firstline = lines.next().unwrap().chars().rev();
    
    for elem in firstline {
        print!("{}", elem);
    }
    println!();
}
