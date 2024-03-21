module {
    func @matmul_linalg(%A: memref<8x8xf32>, %B: memref<8x8xf32>, %C: memref<8x8xf32>) {
        linalg.matmul ins(%A, %B : memref<8x8xf32>, memref<8x8xf32>)
            outs(%C: memref<8x8xf32>)
        return
    }

    func @main() {
        %A = memref.alloc() : memref<8x8xf32>
        %B = memref.alloc() : memref<8x8xf32>
        %C = memref.alloc() : memref<8x8xf32>
        
        %cf1 = constant 1.0 : f32
        
        linalg.fill(%A, %cf1) : memref<8x8xf32>, f32
        linalg.fill(%B, %cf1) : memref<8x8xf32>, f32
        linalg.fill(%C, %cf1) : memref<8x8xf32>, f32
        
        call @matmul_linalg(%A, %B, %C) : (memref<8x8xf32>, memref<8x8xf32>, memref<8x8xf32>) -> ()
        return
    }
}