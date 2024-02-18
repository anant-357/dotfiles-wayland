use bluer::Session;
use serde::Serialize;

#[derive(Serialize)]
#[allow(dead_code)]
struct Bluetooth {
    symbol: char,
    name: String,
    battery: i16,
}

impl Bluetooth {
    pub fn new (symbol: char, name: String, battery: i16) -> Self {
        Bluetooth {
            symbol,
            name,
            battery
        }
    }

    pub fn set_symbol(&mut self, symbol: char){
        self.symbol = symbol;
    }

    pub fn set_name(&mut self, name: String){
        self.name = name;
    }

    pub fn set_battery(&mut self, battery: i16){
        self.battery = battery;
    }
    
}

#[tokio::main]
async fn main() {
    let session = Session::new().await;
    let adapter = session.expect("Session").default_adapter().await.expect("Adapter");
    let mut bluetooth = Bluetooth::new('-', String::from(""), -1);

    match adapter.is_powered().await.unwrap() {
            true => (),
            false => {bluetooth.set_symbol('󰂲'); ()}, 
    }

    for device_addr in adapter.device_addresses().await.expect("props") {
        let device = adapter.device(device_addr).expect("device");
        
        if device.is_connected().await.expect("connection status") {
            bluetooth.set_name(device.name().await.expect("name").unwrap());
            match device.icon().await.expect("icon").unwrap().as_str() {
                "computer" =>  bluetooth.set_symbol('󰇄'),
                "audio-headphones" => bluetooth.set_symbol('󰋋'),
                "audio-headset" => bluetooth.set_symbol('󰋎'),
                _ => ()
            }
            break;
        } else {
            bluetooth.set_symbol('󰂯')
        }
    }
    
    println!("{}", serde_json::to_string(&bluetooth).unwrap());
}
