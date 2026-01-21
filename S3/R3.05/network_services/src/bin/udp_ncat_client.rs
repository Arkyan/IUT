use std::env;
use std::io::{self, BufRead};
use std::net::UdpSocket;

fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() != 3 {
        eprintln!("Usage: {} <host> <port>", args[0]);
        std::process::exit(1);
    }

    let host = &args[1];
    let port = &args[2];
    let addr = format!("{}:{}", host, port);

    // Socket local (port aléatoire)
    let socket = UdpSocket::bind("0.0.0.0:0")?;
    socket.connect(&addr)?;

    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let line = line?;
        socket.send(line.as_bytes())?;

        let mut buf = [0u8; 2048];
        let n = socket.recv(&mut buf)?;
        println!("{}", String::from_utf8_lossy(&buf[..n]));
    }

    Ok(())
}
