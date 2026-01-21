use port_scanner::{is_open, Parameters};


#[tokio::main]
async fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 5 {
        eprintln!("Usage: {} <host> <port_min> <port_max> <timeout>", args[0]);
        std::process::exit(1);
    }

    let params:Parameters = Parameters {
        host: args[1].clone(),
        port_min: args[2].parse().expect("Invalid port_min"),
        port_max: args[3].parse().expect("Invalid port_max"),
        timeout: args[4].parse().expect("Invalid timeout"),
    };

    for port in params.port_min..=params.port_max {
        if is_open(&params.host, port, params.timeout).await {
            println!("Port {} is open", port);
        } else {
            println!("Port {} is closed", port);
        }
    }

}