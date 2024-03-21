# set(LLVM_TARGET_DEFINITIONS MMAOps.td)
# mlir_tablegen(MMAOpsEnums.h.inc -gen-enum-decls)
# mlir_tablegen(MMAOpsEnums.cpp.inc -gen-enum-defs)

# set(LLVM_TARGET_DEFINITIONS MMAOps.td)
# mlir_tablegen(MMAOpsAttributes.h.inc -gen-attrdef-decls)
# mlir_tablegen(MMAOpsAttributes.cpp.inc -gen-attrdef-defs)

add_mlir_dialect(MMAOps mma)
#报错说cannot create target "-gen-dialect-docDocGen" because another target with the same name already exists.
# add_mlir_doc(MMADialect -gen-dialect-doc MMADialect MMA/)
# add_mlir_doc(MMAOps -gen-op-doc MMAOps MMA/)