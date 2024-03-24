//====- MMAConverttoAffine.cpp - MMA Dialect Convert to Affine Pass  ---------------------===//
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
// This file defines mma dialect Convert to Affine Pass
//
//===----------------------------------------------------------------------===//

// #include "mlir/Dialect/Arith/IR/Arith.h"
// #include "mlir/Dialect/Bufferization/Transforms/Bufferize.h"
// #include "mlir/Dialect/Func/IR/FuncOps.h"
// #include "mlir/Dialect/LLVMIR/LLVMDialect.h"
// #include "mlir/Dialect/MemRef/IR/MemRef.h"
// #include "mlir/Dialect/Vector/IR/VectorOps.h"
// #include "mlir/Dialect/Linalg/IR/Linalg.h"

#include <mlir/Dialect/Affine/IR/AffineOps.h>
#include <mlir/Dialect/Func/IR/FuncOps.h>
#include <mlir/Dialect/Linalg/IR/Linalg.h>
#include <mlir/IR/Dialect.h>
#include <mlir/IR/Operation.h>
#include <mlir/IR/TypeUtilities.h>
#include <mlir/IR/Value.h>
#include <mlir/Pass/Pass.h>

#include <MMA/MMADialect.h>
#include <MMA/MMAOps.h>

using namespace mlir;
using namespace buddy;
using namespace mlir::linalg;
using namespace vector;

//===----------------------------------------------------------------------===//
// Rewrite Pattern
//===----------------------------------------------------------------------===//

namespace {
    //这里引用的MatMulOp这个名字 是在哪里定义的
class MMAmatmultestLowering : public OpRewritePattern<mma::MatMulOp>{
public:
    //C++11引入的构造函数继承特性的应用，允许派生类通过简洁的语法重用基类构造函数，
    //而不需要在派生类中显式定义相同的构造函数
    using OpRewritePattern<mma::MatMulOp>::OpRewritePattern;

    LogicalResult matchAndRewrite(mma::MatMulOp op,
                                  PatternRewriter &rewriter)const override{
        auto loc = op->getLoc();
        Value A=op->getOperand(0);
        Value B=op->getOperand(1);
        Value C=op->getOperand(2);
        //这里create<>中添加的是C++的op定义，不是mlir中的
        // rewriter.create<linalg::MatmulOp>(
        //                                 loc,
        //                                 ValueRange{A,B},
        //                                 ValueRange{C}
        //                                 );    

        // Dims
        Value M = rewriter.create<memref::DimOp>(loc, A, 0);
        Value N = rewriter.create<memref::DimOp>(loc, B, 1);
        Value K = rewriter.create<memref::DimOp>(loc, B, 0);

        

        rewriter.eraseOp(op);
        return success();
    }
};
} // end anonymous namespace
void populateLowerMMAConversionPatterns(RewritePatternSet &patterns) {
    patterns.add<MMAmatmultestLowering>(patterns.getContext());
}

//===----------------------------------------------------------------------===//
// LowerMMAPass
//===----------------------------------------------------------------------===//

namespace {
class LowerMMAPass : public PassWrapper<LowerMMAPass, OperationPass<ModuleOp>> {
public:
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerMMAPass)
  LowerMMAPass() = default;
  LowerMMAPass(const LowerMMAPass &) {}

  StringRef getArgument() const final { return "lower-mma"; }
  StringRef getDescription() const final { return "Lower MMA Dialect."; }

  void runOnOperation() override;

  void getDependentDialects(DialectRegistry &registry) const override {
    // clang-format off
    //这里是这个方言所依赖的其他方言？
    registry.insert<
        buddy::mma::MMADialect,
        linalg::LinalgDialect,
        func::FuncDialect,
        vector::VectorDialect,
        memref::MemRefDialect,
        LLVM::LLVMDialect>();
    // clang-format on
  }
};
} // end anonymous namespace.

void LowerMMAPass::runOnOperation() {
  MLIRContext *context = &getContext();
  ModuleOp module = getOperation();

  ConversionTarget target(*context);
  //这里是不是就是这个方言在向下翻译的时候允许使用的其他方言？
  // clang-format off
  target.addLegalDialect<
      arith::ArithDialect,
      linalg::LinalgDialect,
      func::FuncDialect,
      vector::VectorDialect,
      memref::MemRefDialect,
      LLVM::LLVMDialect>();
  // clang-format on
  target.addLegalOp<ModuleOp, func::FuncOp, func::ReturnOp>();

  RewritePatternSet patterns(context);
  populateLowerMMAConversionPatterns(patterns);

  if (failed(applyPartialConversion(module, target, std::move(patterns))))
    signalPassFailure();
}

namespace mlir {
namespace buddy {
void registerLowerMMAPass() { PassRegistration<LowerMMAPass>(); }
} // namespace buddy
} // namespace mlir
