use std::io::{self, prelude::*};
use std::collections::HashMap;

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).expect("ff");
    let lines = input.lines();
    let mut count = 0;

    let mut joueur : HashMap<&str, i32> = HashMap::new();
    let mut game: HashMap<&str, i32> = HashMap::new();

    for line in lines {
        if line.is_empty(){
            count = 1;
        } else {
            let mut elements = line.split(':');

            if count == 0 {
                // init
                let action = elements.next().unwrap();
                let point = elements.next().unwrap().parse::<i32>().unwrap();
                game.insert(action, point);
            } else {
                // point
                let personne = elements.next().unwrap();
                let action = elements.next().unwrap();

                let point = game.get(action).copied().unwrap_or(0);
                *joueur.entry(personne).or_insert(0) += point;
            }
        }
    }

    for (personne, point) in joueur {
        if point <= 100 {
            let val = 100 - point;
            println!("{}:{}",personne, val )
        } else {
            println!("{}:Stage gratuit", personne)
        }
    }
}
