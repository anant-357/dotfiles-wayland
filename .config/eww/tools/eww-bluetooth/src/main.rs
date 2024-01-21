use bluer::{Adapter, Address, DiscoveryTransport, DiscoveryFilter};
use futures::pin_mut;
async fn query_devices(adapter: &Adapter, addr: Address){
    let device = adapter.device(addr)?;
    println!("Name: {:?}", device.name().await?);
}

fn main() {
    let session = bluer::Session::new().await?;
    let adapter = session.default_adapter().await?;
    adapter.set_powered(true).await?;
    let filter = DiscoveryFilter {
        transport: DiscoveryTransport::Auto,
        ..Default::default()
    };
    adapter.set_discovery_filter(filter).await.unwrap();
    println!("Using discovery filter:\n{:#?}\n\n", adapter.discovery_filter().await);

    let device_events = adapter.discover_devices().await.unwrap();
    pin_mut!(device_events);
    
    
    println!("Hello, world!");
}
