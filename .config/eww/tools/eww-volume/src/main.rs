use pipewire::{main_loop:: MainLoop, context:: Context};    
fn main() {
    let mainloop = MainLoop::new(None).expect("mainloop");
    let context = Context::new(&mainloop).expect("context");
    let core = context.connect(None).expect("core");
    let registry = core.get_registry().expect("registery");
    println!("{:#?}", registry);
}
