//Une foncion main qui attend un entier n en ligne de commande et qui affiche bonjour n°i puis au revoir n°i (sur deux lignes distinctes) où i varie de 0 à n-1
use std::env;
fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <n>", args[0]);
        return;
    }
    let n: usize = args[1].parse().expect("Please provide a valid integer");
    for i in 0..n {
        println!("Bonjour n°{}", i);
        println!("Au revoir n°{}", i);
    }
}