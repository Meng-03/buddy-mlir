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
    %25 = llvm.mlir.constant(4 : index) : i64
    %26 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%24 : i64)
  ^bb1(%27: i64):  // 2 preds: ^bb0, ^bb8
    %28 = llvm.icmp "slt" %27, %25 : i64
    llvm.cond_br %28, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.mlir.constant(4 : index) : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%29 : i64)
  ^bb3(%32: i64):  // 2 preds: ^bb2, ^bb7
    %33 = llvm.icmp "slt" %32, %30 : i64
    llvm.cond_br %33, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    %34 = llvm.mlir.constant(0 : index) : i64
    %35 = llvm.mlir.constant(4 : index) : i64
    %36 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb5(%34 : i64)
  ^bb5(%37: i64):  // 2 preds: ^bb4, ^bb6
    %38 = llvm.icmp "slt" %37, %35 : i64
    llvm.cond_br %38, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %39 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.mlir.constant(4 : index) : i64
    %41 = llvm.mul %27, %40  : i64
    %42 = llvm.add %41, %37  : i64
    %43 = llvm.getelementptr %39[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %44 = llvm.load %43 : !llvm.ptr -> f32
    %45 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.mlir.constant(4 : index) : i64
    %47 = llvm.mul %37, %46  : i64
    %48 = llvm.add %47, %32  : i64
    %49 = llvm.getelementptr %45[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %50 = llvm.load %49 : !llvm.ptr -> f32
    %51 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(4 : index) : i64
    %53 = llvm.mul %27, %52  : i64
    %54 = llvm.add %53, %32  : i64
    %55 = llvm.getelementptr %51[%54] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %56 = llvm.load %55 : !llvm.ptr -> f32
    %57 = llvm.fmul %44, %50  : f32
    %58 = llvm.fadd %56, %57  : f32
    %59 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.mlir.constant(4 : index) : i64
    %61 = llvm.mul %27, %60  : i64
    %62 = llvm.add %61, %32  : i64
    %63 = llvm.getelementptr %59[%62] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %58, %63 : f32, !llvm.ptr
    %64 = llvm.add %37, %36  : i64
    llvm.br ^bb5(%64 : i64)
  ^bb7:  // pred: ^bb5
    %65 = llvm.add %32, %31  : i64
    llvm.br ^bb3(%65 : i64)
  ^bb8:  // pred: ^bb3
    %66 = llvm.add %27, %26  : i64
    llvm.br ^bb1(%66 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(4 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(16 : index) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.getelementptr %5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.call @malloc(%7) : (i64) -> !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %2, %14[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %3, %16[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.mlir.constant(4 : index) : i64
    %19 = llvm.mlir.constant(4 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.constant(16 : index) : i64
    %22 = llvm.mlir.zero : !llvm.ptr
    %23 = llvm.getelementptr %22[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %24 = llvm.ptrtoint %23 : !llvm.ptr to i64
    %25 = llvm.call @malloc(%24) : (i64) -> !llvm.ptr
    %26 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %18, %30[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %19, %31[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.insertvalue %19, %32[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %20, %33[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.mlir.constant(4 : index) : i64
    %36 = llvm.mlir.constant(4 : index) : i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.mlir.constant(16 : index) : i64
    %39 = llvm.mlir.zero : !llvm.ptr
    %40 = llvm.getelementptr %39[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %41 = llvm.ptrtoint %40 : !llvm.ptr to i64
    %42 = llvm.call @malloc(%41) : (i64) -> !llvm.ptr
    %43 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.insertvalue %35, %47[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.insertvalue %36, %48[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.insertvalue %36, %49[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %37, %50[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.mlir.constant(0 : index) : i64
    %53 = llvm.mlir.constant(4 : index) : i64
    %54 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%52 : i64)
  ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb5
    %56 = llvm.icmp "slt" %55, %53 : i64
    llvm.cond_br %56, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %57 = llvm.mlir.constant(0 : index) : i64
    %58 = llvm.mlir.constant(4 : index) : i64
    %59 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb3(%57 : i64)
  ^bb3(%60: i64):  // 2 preds: ^bb2, ^bb4
    %61 = llvm.icmp "slt" %60, %58 : i64
    llvm.cond_br %61, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %62 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %63 = llvm.mlir.constant(4 : index) : i64
    %64 = llvm.mul %55, %63  : i64
    %65 = llvm.add %64, %60  : i64
    %66 = llvm.getelementptr %62[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %0, %66 : f32, !llvm.ptr
    %67 = llvm.add %60, %59  : i64
    llvm.br ^bb3(%67 : i64)
  ^bb5:  // pred: ^bb3
    %68 = llvm.add %55, %54  : i64
    llvm.br ^bb1(%68 : i64)
  ^bb6:  // pred: ^bb1
    %69 = llvm.mlir.constant(0 : index) : i64
    %70 = llvm.mlir.constant(4 : index) : i64
    %71 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb7(%69 : i64)
  ^bb7(%72: i64):  // 2 preds: ^bb6, ^bb11
    %73 = llvm.icmp "slt" %72, %70 : i64
    llvm.cond_br %73, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    %74 = llvm.mlir.constant(0 : index) : i64
    %75 = llvm.mlir.constant(4 : index) : i64
    %76 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb9(%74 : i64)
  ^bb9(%77: i64):  // 2 preds: ^bb8, ^bb10
    %78 = llvm.icmp "slt" %77, %75 : i64
    llvm.cond_br %78, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %79 = llvm.extractvalue %34[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %80 = llvm.mlir.constant(4 : index) : i64
    %81 = llvm.mul %72, %80  : i64
    %82 = llvm.add %81, %77  : i64
    %83 = llvm.getelementptr %79[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %0, %83 : f32, !llvm.ptr
    %84 = llvm.add %77, %76  : i64
    llvm.br ^bb9(%84 : i64)
  ^bb11:  // pred: ^bb9
    %85 = llvm.add %72, %71  : i64
    llvm.br ^bb7(%85 : i64)
  ^bb12:  // pred: ^bb7
    %86 = llvm.mlir.constant(0 : index) : i64
    %87 = llvm.mlir.constant(4 : index) : i64
    %88 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb13(%86 : i64)
  ^bb13(%89: i64):  // 2 preds: ^bb12, ^bb17
    %90 = llvm.icmp "slt" %89, %87 : i64
    llvm.cond_br %90, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    %91 = llvm.mlir.constant(0 : index) : i64
    %92 = llvm.mlir.constant(4 : index) : i64
    %93 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb15(%91 : i64)
  ^bb15(%94: i64):  // 2 preds: ^bb14, ^bb16
    %95 = llvm.icmp "slt" %94, %92 : i64
    llvm.cond_br %95, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %96 = llvm.extractvalue %51[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %97 = llvm.mlir.constant(4 : index) : i64
    %98 = llvm.mul %89, %97  : i64
    %99 = llvm.add %98, %94  : i64
    %100 = llvm.getelementptr %96[%99] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %0, %100 : f32, !llvm.ptr
    %101 = llvm.add %94, %93  : i64
    llvm.br ^bb15(%101 : i64)
  ^bb17:  // pred: ^bb15
    %102 = llvm.add %89, %88  : i64
    llvm.br ^bb13(%102 : i64)
  ^bb18:  // pred: ^bb13
    %103 = llvm.extractvalue %17[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %104 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.extractvalue %17[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.extractvalue %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.extractvalue %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.extractvalue %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.extractvalue %17[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.extractvalue %34[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.extractvalue %34[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.extractvalue %34[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.extractvalue %34[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %114 = llvm.extractvalue %34[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %115 = llvm.extractvalue %34[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %116 = llvm.extractvalue %34[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.extractvalue %51[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %118 = llvm.extractvalue %51[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %119 = llvm.extractvalue %51[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %120 = llvm.extractvalue %51[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %121 = llvm.extractvalue %51[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %122 = llvm.extractvalue %51[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %123 = llvm.extractvalue %51[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @matmul(%103, %104, %105, %106, %107, %108, %109, %110, %111, %112, %113, %114, %115, %116, %117, %118, %119, %120, %121, %122, %123) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    %124 = llvm.mlir.constant(1 : index) : i64
    %125 = llvm.alloca %124 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %51, %125 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %126 = llvm.mlir.constant(2 : index) : i64
    %127 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %128 = llvm.insertvalue %126, %127[0] : !llvm.struct<(i64, ptr)> 
    %129 = llvm.insertvalue %125, %128[1] : !llvm.struct<(i64, ptr)> 
    %130 = llvm.extractvalue %129[0] : !llvm.struct<(i64, ptr)> 
    %131 = llvm.extractvalue %129[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @printMemrefF32(%130, %131) : (i64, !llvm.ptr) -> ()
    %132 = llvm.extractvalue %17[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%132) : (!llvm.ptr) -> ()
    %133 = llvm.extractvalue %34[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%133) : (!llvm.ptr) -> ()
    %134 = llvm.extractvalue %51[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%134) : (!llvm.ptr) -> ()
    llvm.return
  }
}

