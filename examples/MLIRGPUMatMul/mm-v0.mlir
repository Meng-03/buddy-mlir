module{
    //这个print是在哪里定义过的吗？
    //和op.td中定义的格式很相关，' '空格都会影响
    func.func private @printMemrefF32(%ptr : memref<*xf32>)
    func.func @matmul(%a : memref<4x4xf32>, %b : memref<4x4xf32>, %c : memref<4x4xf32>){
        //这里的" %c , : "后续记得把,删除，dialect op中目前已经修改，但是暂未构建
        mma.matmul %a, %b, %c : memref<4x4xf32> , memref<4x4xf32> , memref<4x4xf32>  
        return
    }
    func.func @main(){
        %A=memref.alloc():memref<4x4xf32>
        %B=memref.alloc():memref<4x4xf32>
        %C=memref.alloc():memref<4x4xf32>
        
        %cf1 = arith.constant 1.0 : f32
        //类型和数字
        linalg.fill
        ins(%cf1 : f32)
        outs(%A:memref<4x4xf32>)

        linalg.fill
        ins(%cf1 : f32)
        outs(%B:memref<4x4xf32>)

        linalg.fill
        ins(%cf1 : f32)
        outs(%C:memref<4x4xf32>)

        call @matmul(%A,%B,%C):(memref<4x4xf32>,memref<4x4xf32>,memref<4x4xf32>)->()
        //mlir这里是必须转换成和func input一样的类型吗
        %printC= memref.cast %C : memref<4x4xf32> to memref<*xf32>
        call @printMemrefF32(%printC):(memref<*xf32>)->()
        memref.dealloc %A : memref<4x4xf32>
        memref.dealloc %B : memref<4x4xf32>
        memref.dealloc %C : memref<4x4xf32>
        return 
    }
}