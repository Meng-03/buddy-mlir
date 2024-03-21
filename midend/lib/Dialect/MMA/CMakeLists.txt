add_mlir_dialect_library(BuddyMMA
  MMADialect.cpp
  MMAOps.cpp

  LINK_LIBS PUBLIC
  MLIRIR
  )