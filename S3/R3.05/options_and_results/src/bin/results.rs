use anyhow::anyhow;

fn main() {
    let string1:&str = "-17";
    let string2:&str = "Tux";

    convert_to_int(string1);
    convert_to_int(string2);

    println!("---------");

    convert_to_int2(string1);
    //convert_to_int2(string2);

    println!("---------");

    convert_to_int3(string1).expect("TODO: panic message");
    convert_to_int3(string2).expect("TODO: panic message");
}

fn convert_to_int(value: &str) -> Option<i32> {
    match value.parse::<i32>() {
        Ok(num) => {
            let square = num * num;
            println!("Le carré de {} est {}", num, square);
            Some(square)
        }
        Err(_) => {
            println!("'{}' n'est pas un nombre entier.", value);
            None
        }
    }
}

fn convert_to_int2(value: &str) {
    let num = value.parse::<i32>().expect(&format!("'{}' n'est pas un entier valide ! 💥", value));
    let square = num * num;
    println!("Le carré de {} est {}", num, square)
}

fn convert_to_int3(value: &str) -> anyhow::Result<()> {
    match value.parse::<i32>() {
        Ok(num) => {
            let square = num * num;
            println!("Le carré de {} est {}", num, square);
        }
        Err(_) => {
            println!("'{}' n'est pas un nombre entier.", value);
        }
    }
    Ok(())
}
