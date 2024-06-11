use std::char;

use brightness::{Brightness, BrightnessDevice};
use futures::{executor::block_on, TryStreamExt};
use serde::Serialize;

#[derive(Serialize)]
struct Bright {
    symbol: char,
    value: String,
}

impl Bright {
    pub fn new(symbol: char, value: String) -> Self {
        Bright { symbol, value }
    }
}

fn main() {
    block_on(run());
}

async fn run() {
    brightness::brightness_devices()
        .try_fold(0, |count, dev| async move {
            show_brightness(&dev).await?;
            Ok(count + 1)
        })
        .await
        .unwrap();
}

async fn show_brightness(dev: &BrightnessDevice) -> Result<(), brightness::Error> {
    if dev.device_name().await? == "intel_backlight" {
        let mut symbol: char = '-';
        let value = dev.get().await?;

        if value == 0 {
            symbol = '';
        } else if value <= 10 {
            symbol = '';
        } else if value <= 20 {
            symbol = '';
        } else if value <= 30 {
            symbol = '';
        } else if value <= 40 {
            symbol = '';
        } else if value <= 50 {
            symbol = '';
        } else if value <= 60 {
            symbol = '';
        } else if value <= 70 {
            symbol = '';
        } else if value <= 80 {
            symbol = ''
        } else if value <= 90 {
            symbol = '';
        } else if value <= 100 {
            symbol = '';
        }

        let b = Bright::new(symbol, value.to_string());
        println!("{}", serde_json::to_string(&b).unwrap());
    }
    Ok(())
}
