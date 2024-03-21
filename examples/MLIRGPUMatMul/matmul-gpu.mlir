module attributes {gpu.container_module}{
    func.func private @printMemrefF32(%ptr : memref<*xf32>)
    func.func @main(){
        %A=memref.alloc():memref<4x4xf32>
        %B=memref.alloc():memref<4x4xf32>
        %C=memref.alloc():memref<4x4xf32>
        %c1=arith.constant 1:index
        %c32=arith.constant 32:index
        %cf1 = arith.constant 1.0 : f32
        linalg.fill
        ins(%cf1 : f32)
        outs(%A:memref<4x4xf32>)

        linalg.fill
        ins(%cf1 : f32)
        outs(%B:memref<4x4xf32>)

        linalg.fill
        ins(%cf1 : f32)
        outs(%C:memref<4x4xf32>)
        //优化点：自动根据矩阵大小 和 硬件型号填充 blocks，threads
        gpu.launch blocks(%bx,%by,%bz) in (%sz_bx=%c1,%sz_by=%c1,%sz_bz=%c1) 
                   threads(%tx,%ty,%tz) in (%sz_tx=%c32,%sz_ty=%c1,%sz_tz=%c1){
            mma.matmul %A, %B, %C , : memref<4x4xf32> , memref<4x4xf32> , memref<4x4xf32>  
            gpu.terminator
        }

        // gpu.module @gpumma{
        //     gpu.func @matmul(%a : memref<4x4xf32>, %b : memref<4x4xf32>, %c : memref<4x4xf32>) kernel {
        //         //这里的" %c , : "后续记得把,删除，dialect op中目前已经修改，但是暂未构建
        //         mma.matmul %a, %b, %c , : memref<4x4xf32> , memref<4x4xf32> , memref<4x4xf32>  
        //         gpu.return
        //     }
        // }
        // call @matmul(%A,%B,%C):(memref<4x4xf32>,memref<4x4xf32>,memref<4x4xf32>)->()
        //mlir这里是必须转换成和func input一样的类型吗
        %printC= memref.cast %C : memref<4x4xf32> to memref<*xf32>
        call @printMemrefF32(%printC):(memref<*xf32>)->()
        memref.dealloc %A : memref<4x4xf32>
        memref.dealloc %B : memref<4x4xf32>
        memref.dealloc %C : memref<4x4xf32>
        return 
    }
}