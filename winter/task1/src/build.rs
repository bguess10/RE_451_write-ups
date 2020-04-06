extern crate cc;

fn main() {
    cc::Build::new()
        .file("src/question1.s")
        .file("src/question2a.s")
        .file("src/question2b.s")
        .file("src/question2c.s")
        .compile("task1-lib");
}