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
    llvm.br ^bb3(%24 : i64)
  ^bb3(%29: i64):  // 2 preds: ^bb2, ^bb7
    %30 = llvm.icmp "slt" %29, %25 : i64
    llvm.cond_br %30, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%24 : i64)
  ^bb5(%31: i64):  // 2 preds: ^bb4, ^bb6
    %32 = llvm.icmp "slt" %31, %25 : i64
    llvm.cond_br %32, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %33 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.mlir.constant(4 : index) : i64
    %35 = llvm.mul %27, %34  : i64
    %36 = llvm.add %35, %31  : i64
    %37 = llvm.getelementptr %33[%36] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %38 = llvm.load %37 : !llvm.ptr -> f32
    %39 = llvm.extractvalue %15[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.mlir.constant(4 : index) : i64
    %41 = llvm.mul %31, %40  : i64
    %42 = llvm.add %41, %29  : i64
    %43 = llvm.getelementptr %39[%42] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %44 = llvm.load %43 : !llvm.ptr -> f32
    %45 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.mlir.constant(4 : index) : i64
    %47 = llvm.mul %27, %46  : i64
    %48 = llvm.add %47, %29  : i64
    %49 = llvm.getelementptr %45[%48] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %50 = llvm.load %49 : !llvm.ptr -> f32
    %51 = llvm.fmul %38, %44  : f32
    %52 = llvm.fadd %50, %51  : f32
    %53 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.mlir.constant(4 : index) : i64
    %55 = llvm.mul %27, %54  : i64
    %56 = llvm.add %55, %29  : i64
    %57 = llvm.getelementptr %53[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %52, %57 : f32, !llvm.ptr
    %58 = llvm.add %31, %26  : i64
    llvm.br ^bb5(%58 : i64)
  ^bb7:  // pred: ^bb5
    %59 = llvm.add %29, %26  : i64
    llvm.br ^bb3(%59 : i64)
  ^bb8:  // pred: ^bb3
    %60 = llvm.add %27, %26  : i64
    llvm.br ^bb1(%60 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(4 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant(4 : index) : i64
    %5 = llvm.mlir.constant(4 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.getelementptr %8[16] : (!llvm.ptr) -> !llvm.ptr, f32
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr
    %12 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %4, %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %5, %17[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %19 = llvm.insertvalue %5, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.insertvalue %6, %19[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %21 = llvm.mlir.constant(4 : index) : i64
    %22 = llvm.mlir.constant(4 : index) : i64
    %23 = llvm.mlir.constant(1 : index) : i64
    %24 = llvm.mlir.constant(16 : index) : i64
    %25 = llvm.mlir.zero : !llvm.ptr
    %26 = llvm.getelementptr %25[16] : (!llvm.ptr) -> !llvm.ptr, f32
    %27 = llvm.ptrtoint %26 : !llvm.ptr to i64
    %28 = llvm.call @malloc(%27) : (i64) -> !llvm.ptr
    %29 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %30 = llvm.insertvalue %28, %29[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %28, %30[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.mlir.constant(0 : index) : i64
    %33 = llvm.insertvalue %32, %31[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %34 = llvm.insertvalue %21, %33[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %35 = llvm.insertvalue %22, %34[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.insertvalue %22, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %37 = llvm.insertvalue %23, %36[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %38 = llvm.mlir.constant(4 : index) : i64
    %39 = llvm.mlir.constant(4 : index) : i64
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.mlir.constant(16 : index) : i64
    %42 = llvm.mlir.zero : !llvm.ptr
    %43 = llvm.getelementptr %42[16] : (!llvm.ptr) -> !llvm.ptr, f32
    %44 = llvm.ptrtoint %43 : !llvm.ptr to i64
    %45 = llvm.call @malloc(%44) : (i64) -> !llvm.ptr
    %46 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %47 = llvm.insertvalue %45, %46[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %48 = llvm.insertvalue %45, %47[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %49 = llvm.mlir.constant(0 : index) : i64
    %50 = llvm.insertvalue %49, %48[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.insertvalue %38, %50[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %52 = llvm.insertvalue %39, %51[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %39, %52[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %40, %53[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.br ^bb1(%2 : i64)
  ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb5
    %56 = llvm.icmp "slt" %55, %1 : i64
    llvm.cond_br %56, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%2 : i64)
  ^bb3(%57: i64):  // 2 preds: ^bb2, ^bb4
    %58 = llvm.icmp "slt" %57, %1 : i64
    llvm.cond_br %58, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %59 = llvm.mlir.constant(4 : index) : i64
    %60 = llvm.mul %55, %59  : i64
    %61 = llvm.add %60, %57  : i64
    %62 = llvm.getelementptr %11[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %3, %62 : f32, !llvm.ptr
    %63 = llvm.add %57, %0  : i64
    llvm.br ^bb3(%63 : i64)
  ^bb5:  // pred: ^bb3
    %64 = llvm.add %55, %0  : i64
    llvm.br ^bb1(%64 : i64)
  ^bb6:  // pred: ^bb1
    llvm.br ^bb7(%2 : i64)
  ^bb7(%65: i64):  // 2 preds: ^bb6, ^bb11
    %66 = llvm.icmp "slt" %65, %1 : i64
    llvm.cond_br %66, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9(%2 : i64)
  ^bb9(%67: i64):  // 2 preds: ^bb8, ^bb10
    %68 = llvm.icmp "slt" %67, %1 : i64
    llvm.cond_br %68, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %69 = llvm.mlir.constant(4 : index) : i64
    %70 = llvm.mul %65, %69  : i64
    %71 = llvm.add %70, %67  : i64
    %72 = llvm.getelementptr %28[%71] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %3, %72 : f32, !llvm.ptr
    %73 = llvm.add %67, %0  : i64
    llvm.br ^bb9(%73 : i64)
  ^bb11:  // pred: ^bb9
    %74 = llvm.add %65, %0  : i64
    llvm.br ^bb7(%74 : i64)
  ^bb12:  // pred: ^bb7
    llvm.br ^bb13(%2 : i64)
  ^bb13(%75: i64):  // 2 preds: ^bb12, ^bb17
    %76 = llvm.icmp "slt" %75, %1 : i64
    llvm.cond_br %76, ^bb14, ^bb18
  ^bb14:  // pred: ^bb13
    llvm.br ^bb15(%2 : i64)
  ^bb15(%77: i64):  // 2 preds: ^bb14, ^bb16
    %78 = llvm.icmp "slt" %77, %1 : i64
    llvm.cond_br %78, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %79 = llvm.mlir.constant(4 : index) : i64
    %80 = llvm.mul %75, %79  : i64
    %81 = llvm.add %80, %77  : i64
    %82 = llvm.getelementptr %45[%81] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %3, %82 : f32, !llvm.ptr
    %83 = llvm.add %77, %0  : i64
    llvm.br ^bb15(%83 : i64)
  ^bb17:  // pred: ^bb15
    %84 = llvm.add %75, %0  : i64
    llvm.br ^bb13(%84 : i64)
  ^bb18:  // pred: ^bb13
    llvm.call @matmul(%11, %11, %15, %4, %5, %5, %6, %28, %28, %32, %21, %22, %22, %23, %45, %45, %49, %38, %39, %39, %40) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, i64, i64) -> ()
    %85 = llvm.mlir.constant(1 : index) : i64
    %86 = llvm.alloca %85 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %54, %86 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %87 = llvm.mlir.constant(2 : index) : i64
    %88 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %89 = llvm.insertvalue %87, %88[0] : !llvm.struct<(i64, ptr)> 
    %90 = llvm.insertvalue %86, %89[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @printMemrefF32(%87, %86) : (i64, !llvm.ptr) -> ()
    llvm.call @free(%11) : (!llvm.ptr) -> ()
    llvm.call @free(%28) : (!llvm.ptr) -> ()
    llvm.call @free(%45) : (!llvm.ptr) -> ()
    llvm.return
  }
}

