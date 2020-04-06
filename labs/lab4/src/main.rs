#![feature(const_generics)]

use std::fs::File;
use std::io::prelude::*;
use 

struct ThreshArray<U, const N : usize> {
    len : usize,
    member : [U ; N],
}

impl<U, const N : usize> ThreshArray<U,N> {
    fn new() -> Self {
        return
    }
}

struct Instruction {
    prefix: ThreshArray<u8, 4>,
    instruction: ThreshArray<u8, 2>,
    modreg: ThreshArray<u8, 1>,
    OSIB: ThreshArray<u8, 1>,
    displacement : ThreshArray<u8, 4>,
    constant: ThreshArray<u8, 4>
}

struct ByteReader {
    cursor : usize,
    vec : Vec<u8>,
}

impl ByteReader {
    fn new(v : Vec<u8>) -> Self {
        Self {
            cursor : 0,
            vec : v
        }
    }

    fn skip_elf_header(&mut self) {
        self.cursor += 0x40;
    }

    fn match_prefix(&mut self) -> {
        match self.vec[self.cursor] {
            0xf0..0xf3 => ,
            _ => 
        }
    }

    fn match_opcode


}

fn openfile(filename : impl AsRef<str>) -> Result<Vec<u8>, std::io::Error> {
    let mut file = File::open(filename.as_ref())?;
    let mut contents = Vec::new();
    match file.read_to_end(&mut contents) {
        Ok(_) => Ok(contents),
        Err(e) => Err(e)
    }
}




fn main() {
    let v = openfile("lab4_ex1").unwrap();
    let br = ByteReader::new(v);
}
