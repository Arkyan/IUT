use std::io::{self, prelude::*};

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).expect("ff");
    let lines = input.lines();

    for line in lines{
        let mut alphabet = vec!['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o' ,'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

        for elem in line.to_lowercase().chars() {
            if let Some(index) = alphabet.iter().position(|e| *e == elem) {
                alphabet.remove(index);
            }
        }

        if alphabet.is_empty() {
            println!("PANGRAMME")
        } else {
            for elem in alphabet {
                print!("{}", elem);
            }
            println!()
        }
    }

}
