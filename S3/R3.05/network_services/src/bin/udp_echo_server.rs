//cargo run --bin udp_pong_serveur -- 12345
//cargo run --bin udp_ping_client -- 127.0.0.1 12345
//OR
// ncat -u 127.0.0.1 12345 --> écrire

use tokio::net::UdpSocket;
use anyhow::Result;
use clap::Parser;

const LOCALHOST: &str = "127.0.0.1";
const PONG: &str = "PONG\n";

#[derive(Parser)]
struct Parameters {
    /// Port d'écoute
    port: u16,
}

#[tokio::main]
async fn main() -> Result<()> {
    let parameters = Parameters::parse();
    let addr = format!("{}:{}", LOCALHOST, parameters.port);

    let socket = UdpSocket::bind(&addr).await?;
    println!("Serveur UDP à l'écoute sur {}", addr);

    let mut buf = vec![0u8; 1024];

    loop {
        let (len, src) = socket.recv_from(&mut buf).await?;
        let msg = &buf[..len];
        println!("Reçu de {}: {}", src, String::from_utf8_lossy(msg));

        // Répondre PONG
        let recu = String::from_utf8_lossy(msg);
        socket.send_to(recu.as_bytes(), &src).await?;
    }
}
