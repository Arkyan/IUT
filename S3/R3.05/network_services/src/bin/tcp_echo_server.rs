use tokio::net::TcpListener;
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use std::env;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Vérification de l'argument
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <port>", args[0]);
        std::process::exit(1);
    }

    let port = &args[1];
    let addr = format!("0.0.0.0:{}", port);

    // Écoute
    let listener = TcpListener::bind(&addr).await?;
    println!("Serveur TCP lancé sur {}", addr);

    loop {
        // Attente connexion cliente
        let (mut socket, client_addr) = listener.accept().await?;
        println!("Connexion de {}", client_addr);

        // On traite chaque client dans une TASK séparée
        tokio::spawn(async move {
            let mut buffer = [0u8; 1024];

            loop {
                // Lecture
                let n = match socket.read(&mut buffer).await {
                    Ok(0) => {
                        println!("Client {} déconnecté", client_addr);
                        return;
                    }
                    Ok(n) => n,
                    Err(e) => {
                        eprintln!("Erreur lecture {}: {}", client_addr, e);
                        return;
                    }
                };

                // Écriture (echo)
                if let Err(e) = socket.write_all(&buffer[..n]).await {
                    eprintln!("Erreur écriture {}: {}", client_addr, e);
                    return;
                }
            }
        });
    }
}