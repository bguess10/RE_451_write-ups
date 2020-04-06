extern "C" {
    fn simple_avg() -> u64;
    fn ranged_avg(rax : u64) -> u64; 
    fn bad_ranged_avg(rax : u64) -> u64;
    fn simulate_range(rax : u64) -> u64;
}

fn main() {unsafe{
    let q1 = simple_avg();
    let q2a = ranged_avg(q1);
    let q2b = bad_ranged_avg(q1);
    let q2c = simulate_range(q1);
    println!("Question 1 Solution: {}", q1);
    println!("Question 2, Part A, Solution: {}", q2a);
    println!("Question 2, Part B, Solution: {}", q2b);
    println!("Question 2, Part C, Solution: {}", q2c);
}}
