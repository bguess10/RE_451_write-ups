#![feature(asm)]

use std::collections::BTreeMap;


#[derive(Copy, Clone, Debug, PartialEq)]
struct Operands {
    op1 : u8,
    op2 : u8,
}

impl Operands {
    fn new(op1 : u8, op2 : u8) -> Self {
        Self { 
            op1 : op1,
            op2 : op2,
        }   
    }
}

#[derive(Hash, Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord)]
struct AFlags {
    cf : bool,
    pf : bool,
    af : bool,
    zf : bool,
    sf : bool,
    of : bool,
}

impl AFlags {
    fn new(eflags : u16) -> Self {
        Self {
            cf : (eflags & 0x0001) != 0,
            pf : (eflags & 0x0004) != 0,
            af : (eflags & 0x0010) != 0,
            zf : (eflags & 0x0040) != 0,
            sf : (eflags & 0x0080) != 0,
            of : (eflags & 0x0800) != 0,
        }
    }
}

fn print_flags(map : &BTreeMap<AFlags, Operands>) {
    println!("Total Length: {}", map.len());
    println!("Op1, Op2, cf, pf, af, zf, sf, of");
    for (key, value) in map.iter() {
        println!(
            "\\texttt{{ 0x{:0<2x} }} & \\texttt{{ 0x{:0<2x} }} & {:1} & {:1} & {:1} & {:1} & {:1} & {:1} \\\\",
            value.op1,
            value.op2,
            key.cf as u8,
            key.pf as u8,
            key.af as u8,
            key.zf as u8,
            key.sf as u8,
            key.of as u8); 
    }
}

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
fn main() {
    
    let mut map : BTreeMap<AFlags, Operands> = BTreeMap::new(); 

    for i in 0..=255 {
        for j in 0..=255 {
            let mut flags : u16;
            unsafe {
                asm!(r#"
                    cmp al, bl  
                    pushfq
                    pop rax
                    "#
                    : "={ax}" (flags)
                    : "{al}" (i as u8), "{bl}" (j as u8)
                    : "cc", "eax", "bl"
                    : "intel"
                );
            }

            let aflags = AFlags::new(flags);
            if !map.contains_key(&aflags) {
                map.insert(
                    aflags,
                    Operands::new(i as u8, j as u8));
            }

            let keyflags = AFlags::new(flags);
        }
    }

    print_flags(&map);
}




