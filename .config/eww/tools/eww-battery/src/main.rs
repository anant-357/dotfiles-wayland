use std::char;

use serde::Serialize;

#[derive(Serialize)]
#[allow(dead_code)]
struct Time {
    hour: u32,
    minutes: u32,
}
#[derive(Serialize)]
#[allow(dead_code)]
struct Battery {
    symbol: char,
    capacity: u32,
    time: Time,
    charging: u8,
}

impl Battery {
    pub fn new(symbol: char, capacity: u32, charging: u8, time: Time) -> Self {
        Battery {
            symbol,
            capacity,
            charging,
            time,
        }
    }
}

fn main() {
    let mut manager = battery::Manager::new().unwrap().batteries().unwrap();

    let battery = manager.next().unwrap().unwrap();

    let battery_info = match battery.state() {
        battery::State::Charging => Battery::new(
            '󰛨',
            (battery.energy().value * 100. / battery.energy_full().value) as u32,
            1,
            Time {
                minutes: ((battery.time_to_full().unwrap().value / 60.0) % 60.0) as u32,
                hour: (battery.time_to_full().unwrap().value as u32 / 3600),
            },
        ),
        battery::State::Discharging => Battery::new(
            '󰖌',
            (battery.energy().value * 100. / battery.energy_full().value) as u32,
            0,
            Time {
                minutes: ((battery.time_to_empty().unwrap().value / 60.0) % 60.0) as u32,
                hour: (battery.time_to_empty().unwrap().value as u32 / 3600),
            },
        ),

        battery::State::Empty => Battery::new(
            '󰋔',
            0,
            1,
            Time {
                hour: 0,
                minutes: 0,
            },
        ),
        battery::State::Full => Battery::new(
            '󰣐',
            100,
            1,
            Time {
                hour: 0,
                minutes: 0,
            },
        ),
        battery::State::Unknown => Battery::new(
            '',
            55,
            1,
            Time {
                hour: 0,
                minutes: 0,
            },
        ),
        _ => Battery::new(
            '',
            55,
            1,
            Time {
                hour: 0,
                minutes: 0,
            },
        ),
    };
    println!("{}", serde_json::to_string(&battery_info).unwrap());
}
