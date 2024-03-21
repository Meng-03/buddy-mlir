module attributes {gpu.container_module} {
  func.func @main() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : index
    %cst = arith.constant 0.000000e+00 : f16
    %cst_0 = arith.constant 1.000000e+00 : f16
    %cst_1 = arith.constant 2.000000e+00 : f16
    %cst_2 = arith.constant 2.000000e+00 : f32
    %cst_3 = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() : memref<16x16xf16>
    %alloc_4 = memref.alloc() : memref<16x16xf16>
    %alloc_5 = memref.alloc() : memref<16x16xf32>
    %cast = memref.cast %alloc : memref<16x16xf16> to memref<*xf16>
    %cast_6 = memref.cast %alloc_4 : memref<16x16xf16> to memref<*xf16>
    %cast_7 = memref.cast %alloc_5 : memref<16x16xf32> to memref<*xf32>
    scf.for %arg0 = %c0 to %c16 step %c1 {
      scf.for %arg1 = %c0 to %c16 step %c1 {
        memref.store %cst_1, %alloc[%arg0, %arg1] : memref<16x16xf16>
        memref.store %cst_1, %alloc_4[%arg0, %arg1] : memref<16x16xf16>
        memref.store %cst_3, %alloc_5[%arg0, %arg1] : memref<16x16xf32>
      }
    }
    call @printMemrefF32(%cast_7) : (memref<*xf32>) -> ()
    gpu.host_register %cast : memref<*xf16>
    gpu.host_register %cast_6 : memref<*xf16>
    gpu.host_register %cast_7 : memref<*xf32>
    gpu.launch_func  @kernels::@kernel1 blocks in (%c1, %c1, %c1) threads in (%c32, %c1, %c1)  args(%alloc : memref<16x16xf16>, %alloc_4 : memref<16x16xf16>, %alloc_5 : memref<16x16xf32>)
    call @printMemrefF32(%cast_7) : (memref<*xf32>) -> ()
    memref.dealloc %alloc : memref<16x16xf16>
    memref.dealloc %alloc_4 : memref<16x16xf16>
    memref.dealloc %alloc_5 : memref<16x16xf32>
    return
  }
  gpu.module @kernels [#nvvm.target<O = 3, chip = "sm_70">]  {
    llvm.func @kernel1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) attributes {gpu.kernel, nvvm.kernel} {
      %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %8 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %9 = llvm.insertvalue %arg7, %8[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %10 = llvm.insertvalue %arg8, %9[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %11 = llvm.insertvalue %arg9, %10[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %12 = llvm.insertvalue %arg10, %11[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %13 = llvm.insertvalue %arg12, %12[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %14 = llvm.insertvalue %arg11, %13[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %15 = llvm.insertvalue %arg13, %14[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %16 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %17 = llvm.insertvalue %arg14, %16[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %18 = llvm.insertvalue %arg15, %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %19 = llvm.insertvalue %arg16, %18[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %20 = llvm.insertvalue %arg17, %19[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %21 = llvm.insertvalue %arg19, %20[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %22 = llvm.insertvalue %arg18, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %23 = llvm.insertvalue %arg20, %22[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %24 = llvm.mlir.constant(0 : index) : i64
      %25 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %26 = llvm.mlir.constant(16 : index) : i64
      %27 = llvm.mul %24, %26  : i64
      %28 = llvm.add %27, %24  : i64
      %29 = llvm.getelementptr %25[%28] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %30 = llvm.mlir.constant(16 : index) : i32
      %31 = nvvm.wmma.load %29, %30 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %32 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %33 = llvm.mlir.constant(16 : index) : i64
      %34 = llvm.mul %24, %33  : i64
      %35 = llvm.add %34, %24  : i64
      %36 = llvm.getelementptr %32[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f16
      %37 = llvm.mlir.constant(16 : index) : i32
      %38 = nvvm.wmma.load %36, %37 {eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<b>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %39 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %40 = llvm.mlir.constant(16 : index) : i64
      %41 = llvm.mul %24, %40  : i64
      %42 = llvm.add %41, %24  : i64
      %43 = llvm.getelementptr %39[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %44 = llvm.mlir.constant(16 : index) : i32
      %45 = nvvm.wmma.load %43, %44 {eltype = #nvvm.mma_type<f32>, frag = #nvvm.mma_frag<c>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (!llvm.ptr) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)>
      %46 = llvm.extractvalue %31[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %47 = llvm.extractvalue %31[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %48 = llvm.extractvalue %31[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %49 = llvm.extractvalue %31[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %50 = llvm.extractvalue %31[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %51 = llvm.extractvalue %31[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %52 = llvm.extractvalue %31[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %53 = llvm.extractvalue %31[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %54 = llvm.extractvalue %38[0] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %55 = llvm.extractvalue %38[1] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %56 = llvm.extractvalue %38[2] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %57 = llvm.extractvalue %38[3] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %58 = llvm.extractvalue %38[4] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %59 = llvm.extractvalue %38[5] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %60 = llvm.extractvalue %38[6] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %61 = llvm.extractvalue %38[7] : !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> 
      %62 = llvm.extractvalue %45[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %63 = llvm.extractvalue %45[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %64 = llvm.extractvalue %45[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %65 = llvm.extractvalue %45[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %66 = llvm.extractvalue %45[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %67 = llvm.extractvalue %45[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %68 = llvm.extractvalue %45[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %69 = llvm.extractvalue %45[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %70 = nvvm.wmma.mma %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %63, %64, %65, %66, %67, %68, %69 {eltypeA = #nvvm.mma_type<f16>, eltypeB = #nvvm.mma_type<f32>, k = 16 : i32, layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : (vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, f32, f32, f32, f32, f32, f32, f32, f32) -> !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)>
      %71 = llvm.extractvalue %70[0] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %72 = llvm.extractvalue %70[1] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %73 = llvm.extractvalue %70[2] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %74 = llvm.extractvalue %70[3] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %75 = llvm.extractvalue %70[4] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %76 = llvm.extractvalue %70[5] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %77 = llvm.extractvalue %70[6] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %78 = llvm.extractvalue %70[7] : !llvm.struct<(f32, f32, f32, f32, f32, f32, f32, f32)> 
      %79 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
      %80 = llvm.mlir.constant(16 : index) : i64
      %81 = llvm.mul %24, %80  : i64
      %82 = llvm.add %81, %24  : i64
      %83 = llvm.getelementptr %79[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f32
      %84 = llvm.mlir.constant(16 : index) : i32
      nvvm.wmma.store %83, %84, %71, %72, %73, %74, %75, %76, %77, %78 {eltype = #nvvm.mma_type<f32>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32} : !llvm.ptr, f32, f32, f32, f32, f32, f32, f32, f32
      llvm.return
    }
  }
  func.func private @printMemrefF32(memref<*xf32>)
}

