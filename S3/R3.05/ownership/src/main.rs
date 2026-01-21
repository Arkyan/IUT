#[derive(Clone)]
#[derive(Copy)]
struct Rectangle {
    lenght: f64,
    width: f64,
}

fn main() {
    let x: f64 = 24.0;
    let y: f64 = 20.0;

    let mut w: f64 = 10.0;
    let mut h: f64 = 15.0;

    let my_rectangle:Rectangle = Rectangle{lenght: 2.0, width: 4.0};

    println!("{}", average(x, y));
    println!("{}", perimeter(my_rectangle.clone()));
    println!("{}", perimeter(my_rectangle.clone()));
    println!("{}", perimeter2(&my_rectangle));
    println!("{}", perimeter2(&my_rectangle));
    println!("{}", perimeter(my_rectangle));
    println!("{}", perimeter(my_rectangle));

    print_references();

    swap(&mut w, &mut h);
    println!("{:?}", w);
    println!("{:?}", h);
    swap(&mut w, &mut h);
    println!("{:?}", w);
    println!("{:?}", h);
}

fn average(entier1: f64, entier2: f64) -> f64 {
    (entier1 + entier2)/2.0
}

fn perimeter(rectangle: Rectangle) -> f64 {
    (rectangle.lenght + rectangle.width)*2.0
}

fn perimeter2(rectangle: &Rectangle) -> f64 {
    (rectangle.lenght + rectangle.width)*2.0
}

fn print_references() {
    let mut x:i32 = 18;
    //let ref1:&i32 = &x;
    //let ref2:&i32 = &x;
    //let ref3:&mut i32 = &mut x;
    //let ref4: &mut i32 = &mut x;

    //println!("ref1:{:?} ref2:{:?}",ref1,ref2);
    //println!("ref3:{:?} ref4:{:?}",ref3,ref4);
}

fn swap(ref1: &mut f64, ref2: &mut f64) {
    let tmp = *ref1;
    *ref1 = *ref2;
    *ref2 = tmp;
}