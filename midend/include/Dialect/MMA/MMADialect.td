//===- MMADialect.td - MMA Dialect Definition --------------*- tablegen -*-===//
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
// This is the top level file for the MMA dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MMA_MMADIALECT_TD
#define MMA_MMADIALECT_TD

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// MMA Dialect Definition.
//===----------------------------------------------------------------------===//
def MMA_Dialect : Dialect {
  let name = "mma";
  let summary = "The MMA Dialect.";
  let description = [{
    The `MMA` dialect is for optimizations related to matmul op.
  }];
  // let useDefaultAttributePrinterParser = 1;
  let cppNamespace = "::buddy::mma"; 
}

//===----------------------------------------------------------------------===//
// Base MMA Operation Definition.
//===----------------------------------------------------------------------===//
//MMA_Op对应到MMAOps.td
class MMA_Op<string mnemonic,list<Trait> traits =[]>: 
 Op<MMA_Dialect,mnemonic,traits>;

#endif // MMA_MMADIALECT_TD
