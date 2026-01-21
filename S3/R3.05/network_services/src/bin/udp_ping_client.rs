// ncat -u -l 12345
// cargo run -- 127.0.0.1 12345

use tokio::net::UdpSocket;
use anyhow::Result;
use clap::Parser;

const PING: &str = "PING\n";

#[derive(Parser)]
struct Parameters {
    host: String,
    port: u16,
}

#[tokio::main]
async fn main() -> Result<()> {
    let parameters = Parameters::parse();
    let server = format!("{}:{}", parameters.host, parameters.port);

    let socket = UdpSocket::bind("0.0.0.0:0").await?;

    socket.send_to(PING.as_bytes(), &server).await?;

    let mut buf = vec![0; 1024];
    let (len, addr) = socket.recv_from(&mut buf).await?;

    println!("Réponse du serveur {} : {}", addr, String::from_utf8_lossy(&buf[..len]));

    Ok(())
}
