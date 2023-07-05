#![warn(
    clippy::pedantic,
    clippy::nursery,
    clippy::expect_used,
    clippy::unwrap_used
)]

use color_eyre::eyre::Result;

fn main() {
    color_eyre::install()?;
    println!("Hello, world!");
}
