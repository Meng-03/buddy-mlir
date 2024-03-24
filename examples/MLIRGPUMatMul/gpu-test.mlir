func.func @main() {
    %c2 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    gpu.launch 
        blocks(%0, %1, %2) in (%3 = %c1, %4 = %c1, %5 = %c1) 
        threads(%6, %7, %8) in (%9 = %c2, %10 = %c2, %11 = %c1) { 
        gpu.printf "Hello from %d\n" %6 : index
        %lb = arith.constant 0 : index
        %ub = arith.constant 5 : index
        %step = arith.constant 1 : index
        %sum_0 = arith.constant 0.0 : f32
        %t = arith.constant 5.0 : f32
        %sum = scf.for %iv = %lb to %ub step %step 
        iter_args(%sum_iter = %sum_0) -> (f32) {
            %a = arith.addf %sum_iter , %t : f32            
            scf.yield %a : f32
        }
        gpu.printf "Hello from %d\n" %sum_0 : f32
        gpu.terminator
    }
    return
}