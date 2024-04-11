use mpris::{Metadata, PlaybackStatus, PlayerFinder};
use serde::Serialize;
use std::{char, env, fs::File, io::Write, path::Path};
use tokio;

#[derive(Serialize)]
struct Spotify {
    song: String,
    artist: String,
    art: String,
    symbol: char,
}

async fn download_cover_image(url: &str) {
    let response = reqwest::get(url).await.expect("url");
    let path = Path::new("/home/fisher/.config/eww/images/cover.jpg");

    let mut file = match File::create(&path) {
        Err(why) => panic!("couldn't create {}", why),
        Ok(file) => file,
    };
    file.write_all(&response.bytes().await.expect("content"))
        .expect("written");
}

async fn get_data(command: &str) -> Spotify {
    let fallback = Spotify {
        song: "Offline".to_string(),
        artist: "-".to_string(),
        art: String::from("images/default.jpg"),
        symbol: '󰎊',
    };
    let players = match PlayerFinder::new() {
        Ok(players) => players,
        Err(_) => {
            return fallback;
        }
    };
    let player = match players.find_by_name("Spotify") {
        Ok(player) => player,
        Err(_) => {
            return fallback;
        }
    };
    match command {
        "toggle" => {
            player.play_pause().expect("Could not play_pause");
            fallback
        }
        "next" => {
            player.next().expect("Could not next");
            fallback
        }
        "previous" => {
            player.previous().expect("Could not previous");
            fallback
        }
        "status" => {
            let metadata: Metadata = player
                .get_metadata()
                .expect("Could not get metadata for player");
            let symbol: char = match player.get_playback_status().unwrap() {
                PlaybackStatus::Playing => '󰏤',
                _ => '󰐊',
            };
            let spotify = Spotify {
                song: metadata.title().unwrap().to_string(),
                artist: metadata.artists().unwrap()[0].to_string(),
                art: String::from("images/cover.jpg"),
                symbol,
            };
            download_cover_image(metadata.art_url().unwrap()).await;
            spotify
        }
        _ => fallback,
    }
}

#[tokio::main]
async fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() > 1 {
        println!(
            "{}",
            serde_json::to_string(&get_data(args[1].as_str()).await).unwrap()
        );
    }
}
