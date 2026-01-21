use port_scanner::{Parameters, is_open};
use std::env;
use std::time::Instant;

#[tokio::main]
async fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 5 {
        println!("Usage: scanner host port_min port_max timeout");
        return;
    }

    let params: Parameters = Parameters {
        host: args[1].clone(),
        port_min: args[2].parse().unwrap(),
        port_max: args[3].parse().unwrap(),
        timeout: args[4].parse().unwrap(),
    };

    let start = Instant::now();

    // Créer un vecteur pour stocker toutes les tâches
    let mut tasks = Vec::new();

    for port in params.port_min..=params.port_max {
        let host = params.host.clone();
        let timeout = params.timeout;

        // Lancer une tâche par port
        let task = tokio::spawn(async move {
            if is_open(&host, port, timeout).await {
                println!("Port {} is open", port);
            }
        });

        tasks.push(task);
    }

    // Attendre que toutes les tâches se terminent
    for task in tasks {
        let _ = task.await;
    }

    let elapsed = start.elapsed();
    println!("\nScan terminé en {:.2} secondes", elapsed.as_secs_f64());
}