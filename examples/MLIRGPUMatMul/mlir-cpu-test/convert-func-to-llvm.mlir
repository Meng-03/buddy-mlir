module {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @printMemrefF32(i64, !llvm.ptr) attributes {sym_visibility = "private"}
  llvm.func @matmul(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: !llvm.ptr, %arg15: !llvm.ptr, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.insertvalue %arg5, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.insertvalue %arg6, %6[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %9 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %arg7, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %arg10, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %arg12, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg11, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %arg13, %15[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %18 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = llvm.insertvalue %arg14, %18[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %arg15, %19[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %arg16, %20[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %arg17, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.insertvalue %arg19, %22[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.insertvalue %arg18, %23[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %arg20, %24[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = builtin.unrealized_conversion_cast %25 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %27 = builtin.unrealized_conversion_cast %8 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %28 = builtin.unrealized_conversion_cast %17 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %29 = builtin.unrealized_conversion_cast %26 : memref<4x4xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = builtin.unrealized_conversion_cast %30 : i64 to index
    %32 = llvm.mlir.constant(4 : index) : i64
    %33 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%30 : i64)
  ^bb1(%34: i64):  // 2 preds: ^bb0, ^bb8
    %35 = builtin.unrealized_conversion_cast %34 : i64 to index
    %36 = builtin.unrealized_conversion_cast %35 : index to i64
    %37 = builtin.unrealized_conversion_cast %35 : index to i64
    %38 = llvm.icmp "slt" %36, %32 : i64
    llvm.cond_br %38, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%30 : i64)
  ^bb3(%39: i64):  // 2 preds: ^bb2, ^bb7
    %40 = builtin.unrealized_conversion_cast %39 : i64 to index
    %41 = builtin.unrealized_conversion_cast %40 : index to i64
    %42 = builtin.unrealized_conversion_cast %40 : index to i64
    %43 = llvm.icmp "slt" %41, %32 : i64
    llvm.cond_br %43, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%30 : i64)
  ^bb5(%44: i64):  // 2 preds: ^bb4, ^bb6
    %45 = builtin.unrealized_conversion_cast %44 : i64 to index
    %46 = builtin.unrealized_conversion_cast %45 : index to i64
    %47 = builtin.unrealized_conversion_cast %45 : index to i64
    %48 = llvm.icmp "slt" %46, %32 : i64
    llvm.cond_br %48, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %49 = llvm.extractvalue %27[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.mlir.constant(4 : index) : i64
    %51 = llvm.mul %37, %50  : i64
    %52 = llvm.add %51, %47  : i64
    %53 = llvm.getelementptr %49[%52] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %54 = llvm.load %53 : !llvm.ptr -> f32
    %55 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.mlir.constant(4 : index) : i64
    %57 = llvm.mul %47, %56  : i64
    %58 = llvm.add %57, %42  : i64
    %59 = llvm.getelementptr %55[%58] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %60 = llvm.load %59 : !llvm.ptr -> f32
    %61 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.mlir.constant(4 : index) : i64
    %63 = llvm.mul %37, %62  : i64
    %64 = llvm.add %63, %42  : i64
    %65 = llvm.getelementptr %61[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %66 = llvm.load %65 : !llvm.ptr -> f32
    %67 = llvm.fmul %54, %60  : f32
    %68 = llvm.fadd %66, %67  : f32
    %69 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %70 = llvm.mlir.constant(4 : index) : i64
    %71 = llvm.mul %37, %70  : i64
    %72 = llvm.add %71, %42  : i64
    %73 = llvm.getelementptr %69[%72] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %68, %73 : f32, !llvm.ptr
    %74 = llvm.add %46, %33  : i64
    %75 = builtin.unrealized_conversion_cast %74 : i64 to index
    llvm.br ^bb5(%74 : i64)
  ^bb7:  // pred: ^bb5
    %76 = llvm.add %41, %33  : i64
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    llvm.br ^bb3(%76 : i64)
  ^bb8:  // pred: ^bb3
    %78 = llvm.add %36, %33  : i64
    %79 = builtin.unrealized_conversion_cast %78 : i64 to index
    llvm.br ^bb1(%78 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.mlir.constant(4 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(16 : index) : i64
    %9 = llvm.mlir.zero : !llvm.ptr
    %10 = llvm.getelementptr %9[%8] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.call @malloc(%11) : (i64) -> !llvm.ptr
    %13 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %5, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %6, %18[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %6, %19[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.insertvalue %7, %20[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %23 = llvm.mlir.constant(4 : index) : i64
    %24 = llvm.mlir.constant(4 : index) : i64
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.mlir.constant(16 : index) : i64
    %27 = llvm.mlir.zero : !llvm.ptr
    %28 = llvm.getelementptr %27[%26] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.call @malloc(%29) : (i64) -> !llvm.ptr
    %31 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %30, %32[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.mlir.constant(0 : index) : i64
    %35 = llvm.insertvalue %34, %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %23, %35[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %24, %36[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.insertvalue %24, %37[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.insertvalue %25, %38[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = builtin.unrealized_conversion_cast %39 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    %41 = llvm.mlir.constant(4 : index) : i64
    %42 = llvm.mlir.constant(4 : index) : i64
    %43 = llvm.mlir.constant(1 : index) : i64
    %44 = llvm.mlir.constant(16 : index) : i64
    %45 = llvm.mlir.zero : !llvm.ptr
    %46 = llvm.getelementptr %45[%44] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.call @malloc(%47) : (i64) -> !llvm.ptr
    %49 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %50 = llvm.insertvalue %48, %49[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %48, %50[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(0 : index) : i64
    %53 = llvm.insertvalue %52, %51[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %41, %53[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %42, %54[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %42, %55[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.insertvalue %43, %56[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %58 = builtin.unrealized_conversion_cast %57 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> to memref<4x4xf32>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%59: i64):  // 2 preds: ^bb0, ^bb5
    %60 = builtin.unrealized_conversion_cast %59 : i64 to index
    %61 = builtin.unrealized_conversion_cast %60 : index to i64
    %62 = builtin.unrealized_conversion_cast %60 : index to i64
    %63 = llvm.icmp "slt" %61, %1 : i64
    llvm.cond_br %63, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%2 : i64)
  ^bb3(%64: i64):  // 2 preds: ^bb2, ^bb4
    %65 = builtin.unrealized_conversion_cast %64 : i64 to index
    %66 = builtin.unrealized_conversion_cast %65 : index to i64
    %67 = builtin.unrealized_conversion_cast %65 : index to i64
    %68 = llvm.icmp "slt" %66, %1 : i64
    llvm.cond_br %68, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %69 = llvm.extractvalue %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %70 = llvm.mlir.constant(4 : index) : i64
    %71 = llvm.mul %62, %70  : i64
    %72 = llvm.add %71, %67  : i64
    %73 = llvm.getelementptr %69[%72] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %73 : f32, !llvm.ptr
    %74 = llvm.add %66, %0  : i64
    %75 = builtin.unrealized_conversion_cast %74 : i64 to index
    llvm.br ^bb3(%74 : i64)
  ^bb5:  // pred: ^bb3
    %76 = llvm.add %61, %0  : i64
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    llvm.br ^bb1(%76 : i64)
  ^bb6:  // pred: ^bb1
    llvm.br ^bb7(%2 : i64)
  ^bb7(%78: i64):  // 2 preds: ^bb6, ^bb11
    %79 = builtin.unrealized_conversion_cast %78 : i64 to index
    %80 = builtin.unrealized_conversion_cast %79 : index to i64
    %81 = builtin.unrealized_conversion_cast %79 : index to i64
    %82 = llvm.icmp "slt" %80, %1 : i64
    llvm.cond_br %82, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9(%2 : i64)
  ^bb9(%83: i64):  // 2 preds: ^bb8, ^bb10
    %84 = builtin.unrealized_conversion_cast %83 : i64 to index
    %85 = builtin.unrealized_conversion_cast %84 : index to i64
    %86 = builtin.unrealized_conversion_cast %84 : index to i64
    %87 = llvm.icmp "slt" %85, %1 : i64
    llvm.cond_br %87, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %88 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %89 = llvm.mlir.constant(4 : index) : i64
    %90 = llvm.mul %81, %89  : i64
    %91 = llvm.add %90, %86  : i64
    %92 = llvm.getelementptr %88[%91] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %92 : f32, !llvm.ptr
    %93 = llvm.add %85, %0  : i64
    %94 = builtin.unrealized_conversion_cast %93 : i64 to index
    llvm.br ^bb9(%93 : i64)
  ^bb11:  // pred: ^bb9
    %95 = llvm.add %80, %0  : i64
    %96 = builtin.unrealized_conversion_cast %95 : i64 to index
    llvm.br ^bb7(%95 : i64)
  ^bb12:  // pred: ^bb7
    llvm.br ^bb13(%2 : i64)
  ^bb13(%97: i64):  // 2 preds: ^bb12, ^bb17
    %98 = builtin.unrealized_conversion_cast %97 : i64 to index
    %99 = builtin.unrealized_conversion_cast %98 : index to i64
    %100 = builtin.unrealized_conversion_cast %98 : index to i64
    %101 = llvm.icmp "slt" %99, %1 : i64
    llvm.cond_br %101, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    llvm.br ^bb15(%2 : i64)
  ^bb15(%102: i64):  // 2 preds: ^bb14, ^bb16
    %103 = builtin.unrealized_conversion_cast %102 : i64 to index
    %104 = builtin.unrealized_conversion_cast %103 : index to i64
    %105 = builtin.unrealized_conversion_cast %103 : index to i64
    %106 = llvm.icmp "slt" %104, %1 : i64
    llvm.cond_br %106, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %107 = llvm.extractvalue %57[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.mlir.constant(4 : index) : i64
    %109 = llvm.mul %100, %108  : i64
    %110 = llvm.add %109, %105  : i64
    %111 = llvm.getelementptr %107[%110] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %4, %111 : f32, !llvm.ptr
    %112 = llvm.add %104, %0  : i64
    %113 = builtin.unrealized_conversion_cast %112 : i64 to index
    llvm.br ^bb15(%112 : i64)
  ^bb17:  // pred: ^bb15
    %114 = llvm.add %99, %0  : i64
    %115 = builtin.unrealized_conversion_cast %114 : i64 to index
    llvm.br ^bb13(%114 : i64)
  ^bb18:  // pred: ^bb13
    %116 = llvm.extractvalue %21[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.extractvalue %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %118 = llvm.extractvalue %21[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %119 = llvm.extractvalue %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %120 = llvm.extractvalue %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %121 = llvm.extractvalue %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %122 = llvm.extractvalue %21[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %123 = llvm.extractvalue %39[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %124 = llvm.extractvalue %39[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %125 = llvm.extractvalue %39[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %126 = llvm.extractvalue %39[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %127 = llvm.extractvalue %39[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %128 = llvm.extractvalue %39[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %129 = llvm.extractvalue %39[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %130 = llvm.extractvalue %57[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %131 = llvm.extractvalue %57[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %132 = llvm.extractvalue %57[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %133 = llvm.extractvalue %57[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %134 = llvm.extractvalue %57[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %135 = llvm.extractvalue %57[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %136 = llvm.extractvalue %57[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @matmul(%116, %117, %118, %119, %120, %121, %122, %123, %124, %125, %126, %127, %128, %129, %130, %131, %132, %133, %134, %135, %136) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    %137 = llvm.mlir.constant(1 : index) : i64
    %138 = llvm.alloca %137 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %57, %138 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %139 = llvm.mlir.constant(2 : index) : i64
    %140 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %141 = llvm.insertvalue %139, %140[0] : !llvm.struct<(i64, ptr)> 
    %142 = llvm.insertvalue %138, %141[1] : !llvm.struct<(i64, ptr)> 
    %143 = builtin.unrealized_conversion_cast %142 : !llvm.struct<(i64, ptr)> to memref<*xf32>
    %144 = llvm.extractvalue %142[0] : !llvm.struct<(i64, ptr)> 
    %145 = llvm.extractvalue %142[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @printMemrefF32(%144, %145) : (i64, !llvm.ptr) -> ()
    %146 = llvm.extractvalue %21[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%146) : (!llvm.ptr) -> ()
    %147 = llvm.extractvalue %39[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%147) : (!llvm.ptr) -> ()
    %148 = llvm.extractvalue %57[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%148) : (!llvm.ptr) -> ()
    llvm.return
  }
}

