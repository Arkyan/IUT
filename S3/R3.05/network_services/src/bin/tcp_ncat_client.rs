use std::env;
use std::io::{self, BufRead, Read, Write};
use std::net::TcpStream;

fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() != 3 {
        eprintln!("Usage: {} <host> <port>", args[0]);
        std::process::exit(1);
    }

    let host = &args[1];
    let port = &args[2];
    let addr = format!("{}:{}", host, port);

    let mut stream = TcpStream::connect(&addr)?;
    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let line = line?;
        stream.write_all(line.as_bytes())?;
        stream.write_all(b"\n")?;

        let mut buf = [0u8; 2048];
        let n = stream.read(&mut buf)?;
        println!("{}", String::from_utf8_lossy(&buf[..n]));
    }

    Ok(())
}
