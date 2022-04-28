//====- LowerToLLVM.cpp - Lowering from Toy+Affine+Std to LLVM ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements full lowering of Toy operations to LLVM MLIR dialect.
// 'toy.print' is lowered to a loop nest that calls `printf` on each element of
// the input array. The file also sets up the ToyToLLVMLoweringPass. This pass
// lowers the combination of Arithmetic + Affine + SCF + Func dialects to the
// LLVM one:
//
//                         Affine --
//                                  |
//                                  v
//                       Arithmetic + Func --> LLVM (Dialect)
//                                  ^
//                                  |
//     'toy.print' --> Loop (SCF) --
//
//===----------------------------------------------------------------------===//

#include "toy/Dialect.h"
#include "toy/Passes.h"

#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ArithmeticToLLVM/ArithmeticToLLVM.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVMPass.h"
#include "mlir/Conversion/LLVMCommon/ConversionTarget.h"
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Conversion/MemRefToLLVM/MemRefToLLVM.h"
#include "mlir/Conversion/SCFToControlFlow/SCFToControlFlow.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ADT/Sequence.h"
#include "mlir/IR/OpImplementation.h"

#include <unistd.h>

using namespace mlir;


//===----------------------------------------------------------------------===//
// ToyToLLVMLoweringPass
//===----------------------------------------------------------------------===//

namespace {
struct ToyToLLVMLoweringPass
    : public PassWrapper<ToyToLLVMLoweringPass, OperationPass<ModuleOp>> {
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(ToyToLLVMLoweringPass)

  void getDependentDialects(DialectRegistry &registry) const override {
    registry.insert<LLVM::LLVMDialect, scf::SCFDialect>();
  }
  void runOnOperation() final;
};
} // namespace



// first one is sub, second one is addpa
bool complex_pattern_matcher( Value op0, Value op1, Value op2, Value op3, Value op0_1, Value op1_1, Value op2_1, Value op3_1 ){

  // op0.dump();
  // op1.dump();
  // op2.dump();
  // op3.dump();
  // op0_1.dump();
  // op1_1.dump();
  // op2_1.dump();
  // op3_1.dump();

  std::vector<Value> vec = { op0, op1,op2,op3 }; 

  // make sure no same value
  if (op0==op1||op0==op2||op0==op3||op1==op2||op1==op3||op2==op3){
    return false;
  }
  if (op0_1==op1_1||op0_1==op2_1||op0_1==op3_1||op1_1==op2_1||op1_1==op3_1||op2_1==op3_1){
    return false;
  }


  // make sure 1 to 1 match {1, 2, 3, 4} <-> {1, 2, 3, 4} 
  if ( std::find(vec.begin(), vec.end(), op0_1) == vec.end() ){
    return false;
  }

  if ( std::find(vec.begin(), vec.end(), op1_1) == vec.end() ){
    return false;
  }
  if ( std::find(vec.begin(), vec.end(), op2_1) == vec.end() ){
    return false;
  }
  if ( std::find(vec.begin(), vec.end(), op3_1) == vec.end() ){
    return false;
  }

  // make sure complex
  if ( op0==op0_1 && op1==op1_1   ){
    return false;
  }
  if ( op0==op1_1 && op1==op0_1   ){
    return false;
  }
  if ( op0==op2_1 && op1==op3_1   ){
    return false;
  }
  if ( op0==op3_1 && op1==op2_1   ){
    return false;
  }

  return true;
}

void ToyToLLVMLoweringPass::runOnOperation() {
  // The first thing to define is the conversion target. This will define the
  // final target for this lowering. For this lowering, we are only targeting
  // the LLVM dialect.
  LLVMConversionTarget target(getContext());
  target.addLegalOp<ModuleOp>();

  // printf( "Entering MyComplex\n");



  // During this lowering, we will also be lowering the MemRef types, that are
  // currently being operated on, to a representation in LLVM. To perform this
  // conversion we use a TypeConverter as part of the lowering. This converter
  // details how one type maps to another. This is necessary now that we will be
  // doing more complicated lowerings, involving loop region arguments.

  // LLVMTypeConverter typeConverter(&getContext());

  // Now that the conversion target has been defined, we need to provide the
  // patterns used for lowering. At this point of the compilation process, we
  // have a combination of `toy`, `affine`, and `std` operations. Luckily, there
  // are already exists a set of patterns to transform `affine` and `std`
  // dialects. These patterns lowering in multiple stages, relying on transitive
  // lowerings. Transitive lowering, or A->B->C lowering, is when multiple
  // patterns must be applied to fully transform an illegal operation into a
  // set of legal ones.

  RewritePatternSet patterns(&getContext());
  // populateAffineToStdConversionPatterns(patterns);
  // populateSCFToControlFlowConversionPatterns(patterns);
  // mlir::arith::populateArithmeticToLLVMConversionPatterns(typeConverter,
  //                                                         patterns);
  // populateMemRefToLLVMConversionPatterns(typeConverter, patterns);
  // cf::populateControlFlowToLLVMConversionPatterns(typeConverter, patterns);
  // populateFuncToLLVMConversionPatterns(typeConverter, patterns);

  // The only remaining operation to lower from the `toy` dialect, is the
  // PrintOp.
  //patterns.add<PrintOpLowering>(&getContext());

  // We want to completely lower to LLVM, so we use a `FullConversion`. This
  // ensures that only legal operations will remain after the conversion.
  mlir::ModuleOp function = getOperation();

  llvm::SmallPtrSet<mlir::Operation *, 16> mul_add_exprs;   
  llvm::SmallPtrSet<mlir::Operation *, 16> mul_sub_exprs;   

  std::vector<std::vector<mlir::Operation*>> erase_ops_vector;
  function->dump();

  function.walk([&](mlir::Operation *op) {

    bool is_mul_add_expr, is_mul_sub_expr;
    is_mul_add_expr = 0;
    is_mul_sub_expr = 0;

    // check if the current op is linked as () * () + () * ()
    if ( dyn_cast<toy::AddOp>(op) ) {
      is_mul_add_expr = 1;
      for (Value operand : op->getOperands()){
        if (! dyn_cast<toy::MatmulOp>(operand.getDefiningOp())){
          is_mul_add_expr = 0;
        } 
      }
    }

    // check if the current op is linked as () * () - () * ()
    if ( dyn_cast<toy::SubOp>(op) ) {
      is_mul_sub_expr = 1;
      for (Value operand : op->getOperands()){
        if (! dyn_cast<toy::MatmulOp>(operand.getDefiningOp())){
          // op->dump();
          is_mul_sub_expr = 0;
        } 
      }
    }

      // check mul_add_exprs if there any pairs can be matched as a complex pattern
      // only check mul_add_exprs when the current element is mul_sub_expr
      // cached the element for future iterations 
      if (is_mul_sub_expr ){
        // printf( "enter is_mul_sub_expr if \n");
        // op->dump();

        bool match = 0;
        Value opL = op->getOperand(0);
        Value opR = op->getOperand(1);
        Value opLL = opL.getDefiningOp()->getOperand(0);
        Value opLR = opL.getDefiningOp()->getOperand(1);
        Value opRL = opR.getDefiningOp()->getOperand(0);
        Value opRR = opR.getDefiningOp()->getOperand(1);

        for ( auto elem : mul_add_exprs ){
          Value opL2 = elem->getOperand(0);
          Value opR2 = elem->getOperand(1);
          Value opLL2 = opL2.getDefiningOp()->getOperand(0);
          Value opLR2 = opL2.getDefiningOp()->getOperand(1);
          Value opRL2 = opR2.getDefiningOp()->getOperand(0);
          Value opRR2 = opR2.getDefiningOp()->getOperand(1);

          if (complex_pattern_matcher(opLL,opLR,opRL,opRR,opLL2,opLR2,opRL2,opRR2)){
            // printf( " match_complex in is_mul_sub_expr  \n");
            match = 1 ;
            erase_ops_vector.push_back( { opL.getDefiningOp(),opR.getDefiningOp(), opL2.getDefiningOp(),opR2.getDefiningOp(), elem, op } );
          }
        }
        if (match == 0){
          mul_sub_exprs.insert(op);
        }
      }
      
      if (is_mul_add_expr ){
        bool match = 0;
        Value opL = op->getOperand(0);
        Value opR = op->getOperand(1);
        Value opLL = opL.getDefiningOp()->getOperand(0);
        Value opLR = opL.getDefiningOp()->getOperand(1);
        Value opRL = opR.getDefiningOp()->getOperand(0);
        Value opRR = opR.getDefiningOp()->getOperand(1);

        for ( auto elem : mul_sub_exprs ){
          Value opL2 = elem->getOperand(0);
          Value opR2 = elem->getOperand(1);
          Value opLL2 = opL2.getDefiningOp()->getOperand(0);
          Value opLR2 = opL2.getDefiningOp()->getOperand(1);
          Value opRL2 = opR2.getDefiningOp()->getOperand(0);
          Value opRR2 = opR2.getDefiningOp()->getOperand(1);


         if (  complex_pattern_matcher (opLL2,opLR2,opRL2,opRR2,opLL,opLR,opRL,opRR)){
            // printf( " match_complex in is_mul_sub_expr  \n");
            match = 1 ;
            erase_ops_vector.push_back( { opL.getDefiningOp(),opR.getDefiningOp(), opL2.getDefiningOp(),opR2.getDefiningOp(), elem, op } );
         }
        }
        if (match == 0){
          mul_add_exprs.insert(op);
        }

      }


  });

  for ( auto elem : erase_ops_vector){
    auto loc = elem[0]->getLoc();
    mlir::OpBuilder builder(elem[0]);

  //   // three ways to create a op
  //   // way1
  //   // auto x = builder.create<toy::AddOp>(loc, elem->getOperand(0) , elem->getOperand(0));
  //   // auto x = Operation::create( loc,  elem->getName(), elem->getOperandTypes() , elem->getOperands() , elem->getAttrDictionary());
  //   // way2
  //   // StringAttr opName= builder.getStringAttr("toy.addOp");
  //   // auto x = builder.create(loc,opName, elem->getOperands() );
  //   // way3 - the working one 
  //   auto x = builder.create<toy::MatmulOp>(loc, elem->getOperand(0) , elem->getOperand(0));

    auto complexkernel = builder.create<toy::ComplexMulKernelOp>(loc, elem[0]->getOperand(0) , elem[1]->getOperand(0),  elem[2]->getOperand(0), elem[3]->getOperand(0) );
    // elem[0]->dump();
    // elem[1]->dump();
    // elem[2]->dump();
    // elem[3]->dump();
    // elem[4]->dump();
    // elem[5]->dump();


    elem[4]->getResult(0).replaceAllUsesWith( complexkernel->getResult(0) );
    elem[5]->getResult(0).replaceAllUsesWith( complexkernel->getResult(0) );

    // earase order matters! 
    elem[4]->erase();
    elem[5]->erase();
    elem[0]->erase();
    elem[1]->erase();
    elem[2]->erase();
    elem[3]->erase();

  }
  // printf("After MyComplexFussPass\n");
  function->dump();



  // mlir::OpAsmPrinter::printGenericOp(module);

  // if (failed(applyPartialConversion(module, target, std::move(patterns))))
  //   signalPassFailure();
}

/// Create a pass for lowering operations the remaining `Toy` operations, as
/// well as `Affine` and `Std`, to the LLVM dialect for codegen.
std::unique_ptr<mlir::Pass> mlir::toy::createMyComplexFusePass() {
  return std::make_unique<ToyToLLVMLoweringPass>();
}
