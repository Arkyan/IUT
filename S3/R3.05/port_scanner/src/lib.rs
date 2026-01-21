use std::time::Duration;

pub async fn is_open (host: &str, port: u16, timeout:u64) -> bool {
    matches!(tokio::time::timeout(Duration::from_secs(timeout), tokio::net::TcpStream::connect(format!("{}:{}", host, port))).await, Ok(Ok(_)))
}

//Une structure parameters qui permet de définir 4 arguments en ligne de commande host port min port masx timeout
pub struct Parameters {
    pub host: String,
    pub port_min: u16,
    pub port_max: u16,
    pub timeout: u64,
}