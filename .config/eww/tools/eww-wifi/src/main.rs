use network_manager::NetworkManager;
use serde:: Serialize;

#[derive(Serialize)]
#[allow(dead_code)]
struct Wifi {
    symbol: char,
    ssid: String,
    strength: String
}

impl Wifi {
    pub fn new (symbol: char, ssid: String, strength: String) -> Self{
        Wifi {
            symbol,
            ssid,
            strength
        }
    }
}


fn main() {
    let manager = NetworkManager::new();
    let active_cons = manager.get_active_connections().unwrap();
    let mut wifi: Wifi =  Wifi::new('-', String::from("a"), String::from("none"));
    for active_con in active_cons {
        if wifi.symbol != '-' {
            break;
        }
        wifi = match active_con.settings().kind.as_str() {
            "802-11-wireless" => {
                Wifi::new('󰤨', String::from(active_con.settings().ssid.as_str().unwrap()), String::from("None"))
            },
            _ => {
                Wifi::new('󰤮', String::from("Not Connected"), String::from("none"))
            }
        };
    }
    println!("{}", serde_json::to_string(&wifi).unwrap());
}
