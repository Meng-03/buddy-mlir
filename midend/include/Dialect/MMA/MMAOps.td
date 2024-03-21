//===- MMAOps.td - MMA Dialect Ops -------------------------*- tablegen -*-===//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//===----------------------------------------------------------------------===//
//
// This is the top level file for operations in the mma dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MMA_MMAOPS_TD
#define MMA_MMAOPS_TD

include "MMADialect.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/IR/EnumAttr.td"


// matmul op
def MMA_MatMulOp: MMA_Op<"matmul",[]>{
  let summary =[{
    mma.matmul %A, %B, %C {attr_1 = ?, attr_2 = ?, ...} 
    : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>)
  }];
  //在%C上修改的，所以不用定义outs？
  //Arg 是哪里来的是一个类吗？？
  let arguments=(ins  Arg<AnyRankedOrUnrankedMemRef,"A",[MemRead]>:$A,
                      Arg<AnyRankedOrUnrankedMemRef,"B",[MemRead]>:$B,
                      Arg<AnyRankedOrUnrankedMemRef,"C",[MemRead]>:$C);

  //是在什么时候按照下面的格式打印？输出mlir的时候
  //error: expected literal, variable, directive, or optional group
  let assemblyFormat=[{
    $A `,` $B `,` $C attr-dict `:` type($A) `,` type($B) `,` type($C)
  }];
}

//===----------------------------------------------------------------------===//
// Test constant operation.
//===----------------------------------------------------------------------===//

def MMA_TestConstantOp : MMA_Op<"test_constant", []> {
  let summary = "Test Constant Operation.";

  let results = (outs AnyInteger:$result);

  let assemblyFormat = [{
    attr-dict `:` type($result)
  }];
}

#endif // MMA_MMAOPS_TD
