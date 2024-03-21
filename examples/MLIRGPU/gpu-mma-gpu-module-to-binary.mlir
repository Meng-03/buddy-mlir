module attributes {gpu.container_module} {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @main() {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = builtin.unrealized_conversion_cast %0 : i64 to index
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(32 : index) : i64
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = builtin.unrealized_conversion_cast %5 : i64 to index
    %7 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %8 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %9 = llvm.mlir.constant(2.000000e+00 : f16) : f16
    %10 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %11 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %12 = llvm.mlir.constant(16 : index) : i64
    %13 = llvm.mlir.constant(16 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(256 : index) : i64
    %16 = llvm.mlir.zero : !llvm.ptr
    %17 = llvm.getelementptr %16[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f16
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.call @malloc(%18) : (i64) -> !llvm.ptr
    %20 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = llvm.insertvalue %19, %20[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.insertvalue %19, %21[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %23 = llvm.mlir.constant(0 : index) : i64
    %24 = llvm.insertvalue %23, %22[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %25 = llvm.insertvalue %12, %24[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %13, %25[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.insertvalue %13, %26[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %28 = llvm.insertvalue %14, %27[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.mlir.constant(16 : index) : i64
    %30 = llvm.mlir.constant(16 : index) : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.constant(256 : index) : i64
    %33 = llvm.mlir.zero : !llvm.ptr
    %34 = llvm.getelementptr %33[%32] : (!llvm.ptr, i64) -> !llvm.ptr, f16
    %35 = llvm.ptrtoint %34 : !llvm.ptr to i64
    %36 = llvm.call @malloc(%35) : (i64) -> !llvm.ptr
    %37 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %38 = llvm.insertvalue %36, %37[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %39 = llvm.insertvalue %36, %38[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %40 = llvm.mlir.constant(0 : index) : i64
    %41 = llvm.insertvalue %40, %39[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %42 = llvm.insertvalue %29, %41[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.insertvalue %30, %42[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %44 = llvm.insertvalue %30, %43[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %45 = llvm.insertvalue %31, %44[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %46 = llvm.mlir.constant(16 : index) : i64
    %47 = llvm.mlir.constant(16 : index) : i64
    %48 = llvm.mlir.constant(1 : index) : i64
    %49 = llvm.mlir.constant(256 : index) : i64
    %50 = llvm.mlir.zero : !llvm.ptr
    %51 = llvm.getelementptr %50[%49] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %52 = llvm.ptrtoint %51 : !llvm.ptr to i64
    %53 = llvm.call @malloc(%52) : (i64) -> !llvm.ptr
    %54 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %55 = llvm.insertvalue %53, %54[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %53, %55[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.mlir.constant(0 : index) : i64
    %58 = llvm.insertvalue %57, %56[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %59 = llvm.insertvalue %46, %58[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %60 = llvm.insertvalue %47, %59[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %61 = llvm.insertvalue %47, %60[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.insertvalue %48, %61[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.alloca %63 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %28, %64 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %65 = llvm.mlir.constant(2 : index) : i64
    %66 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %67 = llvm.insertvalue %65, %66[0] : !llvm.struct<(i64, ptr)> 
    %68 = llvm.insertvalue %64, %67[1] : !llvm.struct<(i64, ptr)> 
    %69 = llvm.mlir.constant(1 : index) : i64
    %70 = llvm.alloca %69 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %45, %70 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %71 = llvm.mlir.constant(2 : index) : i64
    %72 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %73 = llvm.insertvalue %71, %72[0] : !llvm.struct<(i64, ptr)> 
    %74 = llvm.insertvalue %70, %73[1] : !llvm.struct<(i64, ptr)> 
    %75 = llvm.mlir.constant(1 : index) : i64
    %76 = llvm.alloca %75 x !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %62, %76 : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr
    %77 = llvm.mlir.constant(2 : index) : i64
    %78 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %79 = llvm.insertvalue %77, %78[0] : !llvm.struct<(i64, ptr)> 
    %80 = llvm.insertvalue %76, %79[1] : !llvm.struct<(i64, ptr)> 
    scf.for %arg0 = %1 to %6 step %3 {
      %124 = builtin.unrealized_conversion_cast %arg0 : index to i64
      scf.for %arg1 = %1 to %6 step %3 {
        %125 = builtin.unrealized_conversion_cast %arg1 : index to i64
        %126 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
        %127 = llvm.mlir.constant(16 : index) : i64
        %128 = llvm.mul %124, %127  : i64
        %129 = llvm.add %128, %125  : i64
        %130 = llvm.getelementptr %126[%129] : (!llvm.ptr, i64) -> !llvm.ptr, f16
        llvm.store %9, %130 : f16, !llvm.ptr
        %131 = llvm.extractvalue %45[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
        %132 = llvm.mlir.constant(16 : index) : i64
        %133 = llvm.mul %124, %132  : i64
        %134 = llvm.add %133, %125  : i64
        %135 = llvm.getelementptr %131[%134] : (!llvm.ptr, i64) -> !llvm.ptr, f16
        llvm.store %9, %135 : f16, !llvm.ptr
        %136 = llvm.extractvalue %62[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
        %137 = llvm.mlir.constant(16 : index) : i64
        %138 = llvm.mul %124, %137  : i64
        %139 = llvm.add %138, %125  : i64
        %140 = llvm.getelementptr %136[%139] : (!llvm.ptr, i64) -> !llvm.ptr, f32
        llvm.store %11, %140 : f32, !llvm.ptr
      }
    }
    %81 = llvm.extractvalue %80[0] : !llvm.struct<(i64, ptr)> 
    %82 = llvm.extractvalue %80[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @printMemrefF32(%81, %82) : (i64, !llvm.ptr) -> ()
    %83 = llvm.mlir.zero : !llvm.ptr
    %84 = llvm.getelementptr %83[1] : (!llvm.ptr) -> !llvm.ptr, f16
    %85 = llvm.ptrtoint %84 : !llvm.ptr to i64
    %86 = llvm.extractvalue %68[0] : !llvm.struct<(i64, ptr)> 
    %87 = llvm.extractvalue %68[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @mgpuMemHostRegisterMemRef(%86, %87, %85) : (i64, !llvm.ptr, i64) -> ()
    %88 = llvm.mlir.zero : !llvm.ptr
    %89 = llvm.getelementptr %88[1] : (!llvm.ptr) -> !llvm.ptr, f16
    %90 = llvm.ptrtoint %89 : !llvm.ptr to i64
    %91 = llvm.extractvalue %74[0] : !llvm.struct<(i64, ptr)> 
    %92 = llvm.extractvalue %74[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @mgpuMemHostRegisterMemRef(%91, %92, %90) : (i64, !llvm.ptr, i64) -> ()
    %93 = llvm.mlir.zero : !llvm.ptr
    %94 = llvm.getelementptr %93[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %95 = llvm.ptrtoint %94 : !llvm.ptr to i64
    %96 = llvm.extractvalue %80[0] : !llvm.struct<(i64, ptr)> 
    %97 = llvm.extractvalue %80[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @mgpuMemHostRegisterMemRef(%96, %97, %95) : (i64, !llvm.ptr, i64) -> ()
    %98 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %99 = llvm.extractvalue %28[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %100 = llvm.extractvalue %28[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %101 = llvm.extractvalue %28[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %102 = llvm.extractvalue %28[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %103 = llvm.extractvalue %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %104 = llvm.extractvalue %28[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %105 = llvm.extractvalue %45[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %106 = llvm.extractvalue %45[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %107 = llvm.extractvalue %45[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %108 = llvm.extractvalue %45[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %109 = llvm.extractvalue %45[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %110 = llvm.extractvalue %45[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %111 = llvm.extractvalue %45[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %112 = llvm.extractvalue %62[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %113 = llvm.extractvalue %62[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %114 = llvm.extractvalue %62[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %115 = llvm.extractvalue %62[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %116 = llvm.extractvalue %62[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %117 = llvm.extractvalue %62[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %118 = llvm.extractvalue %62[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    gpu.launch_func  @kernels::@kernel1 blocks in (%2, %2, %2) threads in (%4, %2, %2) : i64 args(%98 : !llvm.ptr, %99 : !llvm.ptr, %100 : i64, %101 : i64, %102 : i64, %103 : i64, %104 : i64, %105 : !llvm.ptr, %106 : !llvm.ptr, %107 : i64, %108 : i64, %109 : i64, %110 : i64, %111 : i64, %112 : !llvm.ptr, %113 : !llvm.ptr, %114 : i64, %115 : i64, %116 : i64, %117 : i64, %118 : i64)
    %119 = llvm.extractvalue %80[0] : !llvm.struct<(i64, ptr)> 
    %120 = llvm.extractvalue %80[1] : !llvm.struct<(i64, ptr)> 
    llvm.call @printMemrefF32(%119, %120) : (i64, !llvm.ptr) -> ()
    %121 = llvm.extractvalue %28[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%121) : (!llvm.ptr) -> ()
    %122 = llvm.extractvalue %45[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%122) : (!llvm.ptr) -> ()
    %123 = llvm.extractvalue %62[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @free(%123) : (!llvm.ptr) -> ()
    llvm.return
  }
  gpu.binary @kernels  [#gpu.object<#nvvm.target<O = 3, chip = "sm_70">, properties = {O = 3 : i32}, assembly = "//\0A// Generated by LLVM NVPTX Back-End\0A//\0A\0A.version 6.0\0A.target sm_70\0A.address_size 64\0A\0A\09// .globl\09kernel1\0A\0A.visible .entry kernel1(\0A\09.param .u64 kernel1_param_0,\0A\09.param .u64 kernel1_param_1,\0A\09.param .u64 kernel1_param_2,\0A\09.param .u64 kernel1_param_3,\0A\09.param .u64 kernel1_param_4,\0A\09.param .u64 kernel1_param_5,\0A\09.param .u64 kernel1_param_6,\0A\09.param .u64 kernel1_param_7,\0A\09.param .u64 kernel1_param_8,\0A\09.param .u64 kernel1_param_9,\0A\09.param .u64 kernel1_param_10,\0A\09.param .u64 kernel1_param_11,\0A\09.param .u64 kernel1_param_12,\0A\09.param .u64 kernel1_param_13,\0A\09.param .u64 kernel1_param_14,\0A\09.param .u64 kernel1_param_15,\0A\09.param .u64 kernel1_param_16,\0A\09.param .u64 kernel1_param_17,\0A\09.param .u64 kernel1_param_18,\0A\09.param .u64 kernel1_param_19,\0A\09.param .u64 kernel1_param_20\0A)\0A{\0A\09.reg .b32 \09%r<18>;\0A\09.reg .f32 \09%f<17>;\0A\09.reg .b64 \09%rd<4>;\0A\0A\09ld.param.u64 \09%rd1, [kernel1_param_1];\0A\09mov.b32 \09%r1, 16;\0A\09wmma.load.a.sync.row.m16n16k16.f16 \09{%r2, %r3, %r4, %r5, %r6, %r7, %r8, %r9}, [%rd1], %r1;\0A\09ld.param.u64 \09%rd2, [kernel1_param_8];\0A\09wmma.load.b.sync.row.m16n16k16.f16 \09{%r10, %r11, %r12, %r13, %r14, %r15, %r16, %r17}, [%rd2], %r1;\0A\09ld.param.u64 \09%rd3, [kernel1_param_15];\0A\09wmma.load.c.sync.row.m16n16k16.f32 \09{%f1, %f2, %f3, %f4, %f5, %f6, %f7, %f8}, [%rd3], %r1;\0A\09wmma.mma.sync.row.row.m16n16k16.f32.f32\0A\09\09{%f9, %f10, %f11, %f12, %f13, %f14, %f15, %f16},\0A\09\09{%r2, %r3, %r4, %r5, %r6, %r7, %r8, %r9},\0A\09\09{%r10, %r11, %r12, %r13, %r14, %r15, %r16, %r17},\0A\09\09{%f1, %f2, %f3, %f4, %f5, %f6, %f7, %f8};\0A\09wmma.store.d.sync.row.m16n16k16.f32 \09[%rd3],{%f9, %f10, %f11, %f12, %f13, %f14, %f15, %f16}, %r1;\0A\09ret;\0A\0A}\0A\00">]
  llvm.func @printMemrefF32(i64, !llvm.ptr) attributes {sym_visibility = "private"}
  llvm.func @mgpuMemHostRegisterMemRef(i64, !llvm.ptr, i64)
}

