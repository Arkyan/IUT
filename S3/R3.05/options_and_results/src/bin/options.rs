fn main() {
    let sentence1:&str = "Bonjour Limoges";
    let sentence2:&str = "";

    println!("---------");

    print_first_word1(sentence1);
    print_first_word1(sentence2);

    println!("---------");

    print_first_word2(sentence1);
    //print_first_word2(sentence2);

    println!("---------");

    iterate_over_words(sentence1);
    iterate_over_words(sentence2);
}

fn print_first_word1(value: &str) {
    let mut iter = value.split_whitespace();

    match iter.next() {
        Some(word) => println!("Premier mot : {}", word),
        None => println!("Aucun mot trouvé."),
    }
}

fn print_first_word2(value: &str) {
    let mut iter = value.split_whitespace();

    if value.is_empty() {
        println!("La chaine doit être non vide");
    }

    let result = iter.next().expect("Bonjour Limoges");
    println!("Premier mot : {}", result);
}

fn iterate_over_words(value: &str) {
    let iter = value.split_whitespace();

    for word in iter {
        println!("{}", word);
    }
}