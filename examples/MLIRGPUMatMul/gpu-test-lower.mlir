module attributes {gpu.container_module} {
  llvm.func @main() {
    %0 = llvm.mlir.constant(4 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    gpu.launch_func  @main_kernel::@main_kernel blocks in (%1, %1, %1) threads in (%0, %0, %1) : i64 
    llvm.return
  }
  gpu.binary @main_kernel  [#gpu.object<#nvvm.target<O = 3, chip = "sm_70">, "P\EDU\BA\01\00\10\00H\10\00\00\00\00\00\00\02\00\01\01@\00\00\00 \0D\00\00\00\00\00\00\00\00\00\00\00\00\00\00\07\00\01\00F\00\00\00\00\00\00\00\00\00\00\00\11\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\7FELF\02\01\013\07\00\00\00\00\00\00\00\02\00\BE\00t\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\A0\09\00\00\00\00\00\00F\05F\00@\00\00\00\00\00@\00\0E\00\01\00\00.shstrtab\00.strtab\00.symtab\00.symtab_shndx\00.nv.info\00.text.main_kernel\00.nv.info.main_kernel\00.nv.shared.main_kernel\00.nv.global.init\00.rel.text.main_kernel\00.rela.text.main_kernel\00.nv.constant0.main_kernel\00.debug_frame\00.rel.debug_frame\00.rela.debug_frame\00.nv.rel.action\00\00.shstrtab\00.strtab\00.symtab\00.symtab_shndx\00.nv.info\00main_kernel\00.text.main_kernel\00.nv.info.main_kernel\00.nv.shared.main_kernel\00.nv.global.init\00printfFormat_1\00printfFormat_0\00vprintf\00.rel.text.main_kernel\00.rela.text.main_kernel\00.nv.constant0.main_kernel\00_SREG\00.debug_frame\00.rel.debug_frame\00.rela.debug_frame\00.nv.rel.action\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00>\00\00\00\03\00\0C\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00|\00\00\00\03\00\0D\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\8C\00\00\00\01\00\0D\00\00\00\00\00\00\00\00\00\0F\00\00\00\00\00\00\00\9B\00\00\00\01\00\0D\00\0F\00\00\00\00\00\00\00\0F\00\00\00\00\00\00\00\DF\00\00\00\03\00\0B\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\FF\00\00\00\03\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00/\01\00\00\03\00\07\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\002\00\00\00\12\10\0C\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\AA\00\00\00\12\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\FF\FF\FF\FF(\00\00\00\00\00\00\00\FF\FF\FF\FF\FF\FF\FF\FF\03\00\04|\FF\FF\FF\FF\0F\0C\81\80\80(\00\08\FF\81\80(\08\81\80\80(\00\00\00\00\00\00\00\FF\FF\FF\FF0\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\F0\01\00\00\00\00\00\00\04\04\00\00\00\04\0C\00\00\00\0C\81\80\80(\10\04L\00\00\00\00\00\00\04/\08\00\08\00\00\00\18\00\00\00\04#\08\00\08\00\00\00\00\00\00\00\04\12\08\00\08\00\00\00\10\00\00\00\04\11\08\00\08\00\00\00\10\00\00\00\046\04\00\01\00\00\00\047\04\00t\00\00\00\03\1B\FF\00\04\0F\04\00\09\00\00\00\041\04\00\10\00\00\00\04\1C\04\00p\01\00\00\00\00\00\00K\00\00\00\00\00\00\00\00\02\02\08\10\0A/\22\00\00\00\08\00\00\00\00\00\00\08\08\00\00\00\00\00\00\10\08\00\00\00\00\00\00\18\08\00\00\00\00\00\00 \08\00\00\00\00\00\00(\08\00\00\00\00\00\000\08\00\00\00\00\00\008\08\00\00\00\00\01\00\00\08\00\00\00\00\01\00\08\08\00\00\00\00\01\00\10\08\00\00\00\00\01\00\18\08\00\00\00\00\01\00 \08\00\00\00\00\01\00(\08\00\00\00\00\01\000\08\00\00\00\00\01\008\08\00\00\00\00\02\00\00\08\00\00\00\00\02\00\08\08\00\00\00\00\02\00\10\08\00\00\00\00\02\00\18\08\00\00\00\00\02\00 \08\00\00\00\00\02\00(\08\00\00\00\00\02\000\08\00\00\00\00\02\008\08\00\00\00\00\00\00\00\14,\00\00\00`\01\00\00\00\00\00\00:\00\00\00\09\00\00\00 \01\00\00\00\00\00\009\00\00\00\03\00\00\00\10\01\00\00\00\00\00\008\00\00\00\03\00\00\00\E0\00\00\00\00\00\00\00:\00\00\00\09\00\00\00`\00\00\00\00\00\00\009\00\00\00\04\00\00\00@\00\00\00\00\00\00\008\00\00\00\04\00\00\00P\01\00\00\00\00\00\009\00\00\00\08\00\00\00p\01\00\00\00\00\00\00@\01\00\00\00\00\00\008\00\00\00\08\00\00\00p\01\00\00\00\00\00\00\D0\00\00\00\00\00\00\009\00\00\00\08\00\00\00\F0\00\00\00\00\00\00\00\C0\00\00\00\00\00\00\008\00\00\00\08\00\00\00\F0\00\00\00\00\00\00\00H\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00$v\01\FF\00\0A\00\00\FF\00\8E\07\00\C8\0F\00\89\F3\FF\FF\FF\00\00\00\FF\00\0E\00\00\E2\0F\00\19y\08\00\00\00\00\00\00!\00\00\00\22\0E\00\10x\01\01\F0\FF\FF\FF\FF\E0\FF\07\00\E4\0F\00\02x\04\00\00\00\00\00\00\0F\00\00\00\E4\0F\00\10z\10\01\00\08\00\00\FF\E0\F1\07\00\E4\0F\00\02x\05\00\00\00\00\00\00\0F\00\00\00\C6\0F\00$v\02\FF\00\09\00\00\FF\06\0E\00\00\E4\0F\00$r\06\FF\FF\00\00\00\10\00\8E\07\00\E4\0F\00$r\07\FF\FF\00\00\00\02\00\8E\07\00\E2\0F\00\19x\09\FF\1F\00\00\00\08\14\01\00\00\D0\1F\00\87s\00\01\08\00\00\00\00\0A\10\00\00\E4\01\00\02x\14\00\00\00\00\00\00\0F\00\00\00\E4\0F\00\02x\15\00\00\00\00\00\00\0F\00\00\00\CC\0F\00Cy\00\00\00\00\00\00\00\00\C0\03\00\EA\1F\00\87s\00\01\FF\08\00\00\00\0A\10\00\00\E2\01\00\10x\06\10\08\00\00\00\FF\E0\F1\07\00\E4\0F\00\02x\04\00\00\00\00\00\00\0F\00\00\00\E4\0F\00\02x\05\00\00\00\00\00\00\0F\00\00\00\E2\0F\00$r\07\FF\FF\00\00\00\02\06\0E\00\00\C4\0F\00\02x\14\00\00\00\00\00\00\0F\00\00\00\E4\0F\00\02x\15\00\00\00\00\00\00\0F\00\00\00\CC\0F\00Cy\00\00\00\00\00\00\00\00\C0\03\00\EA\1F\00My\00\00\00\00\00\00\00\00\80\03\00\EA\0F\00Gy\00\00\F0\FF\FF\FF\FF\FF\83\03\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00\18y\00\00\00\00\00\00\00\00\00\00\00\C0\0F\00Hello from %d\0A\00Hello from %d\0A\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00@\00\00\00\00\00\00\00\06\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\0B\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00F\01\00\00\00\00\00\00>\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\13\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\88\02\00\00\00\00\00\00\F0\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00\08\00\00\00\00\00\00\00\18\00\00\00\00\00\00\00\C7\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00x\03\00\00\00\00\00\00p\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00)\00\00\00\00\00\00p\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\E8\03\00\00\00\00\00\000\00\00\00\00\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00D\00\00\00\00\00\00p\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\18\04\00\00\00\00\00\00,\00\00\00\00\00\00\00\03\00\00\00\0C\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\F7\00\00\00\0B\00\00p\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00H\04\00\00\00\00\00\00\D8\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\80\00\00\00\09\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00 \05\00\00\00\00\00\00`\00\00\00\00\00\00\00\03\00\00\00\0C\00\00\00\08\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00\96\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\80\05\00\00\00\00\00\00`\00\00\00\00\00\00\00\03\00\00\00\0C\00\00\00\08\00\00\00\00\00\00\00\18\00\00\00\00\00\00\00\D4\00\00\00\09\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\E0\05\00\00\00\00\00\00\10\00\00\00\00\00\00\00\03\00\00\00\04\00\00\00\08\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00\AD\00\00\00\01\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\F0\05\00\00\00\00\00\00`\01\00\00\00\00\00\00\00\00\00\00\0C\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\002\00\00\00\01\00\00\00\06\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\80\07\00\00\00\00\00\00\00\02\00\00\00\00\00\00\03\00\00\00\08\00\00\18\80\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00p\00\00\00\01\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\80\09\00\00\00\00\00\00\1E\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\01\01H\00\00\00\A0\02\00\00\00\00\00\00\9A\02\00\00@\00\00\00\00\00\06\00F\00\00\00\00\00\00\00\00\00\00\00\11 \00\00\00\00\00\00\00\00\00\00\00\00\00\00s\05\00\00\00\00\00\00\00\00\00\00\00\00\00\00\F0 \0A\0A\0A\0A.version 6.0\0A.target sm_70\0A.address_size 64.\00\F0\0Bextern .func (.param .b32 \12\00\F5\05_retval0) vprintf\0A(\0A$\00$64\16\00\11_\13\00?_0,\1D\00\08\F2\0C1\0A)\0A;\0A.global .align 1 .b8 (\00\F0\08Format_1[15] = {72, 101\05\00\148\05\00Q11, 3\18\00\00\05\00#14\13\002109\18\00 37\0D\00\100\05\00O, 0}p\00\11\1F0p\00:\F6\16\0A.visible .entry main_kernel()\0A{\0A.loc\90\00\118\90\00!__\15\00\F2\02_depot0[16];\0A.regG\01;%SP\0F\00\15L\10\00\8932 %r<6>!\00\E3rd<11>;\0A\0Amov.u3\00\1B,f\00b;\0Acvta\8E\00\04%\00\13,]\00\018\00\01[\00\911, %tid.x/\00a.s64.s\19\00\10d\1A\00rr1;\0Aadd?\00Brd2,E\00\190\16\00#3,\80\00W0;\0Astq\00\10[\1D\00!],M\00\03t\00\022\00+4,\A2\01\03\AC\00\02\CB\01\04&\00\115:\00v4;\0A{ \0A\09\0F\01Ctempr\02Ireg;\91\02\01\0B\00\02\87\00\01\0B\00\01\15\00\12[\16\00\22+0\8B\00\1F53\00\00\1F13\00\02\1413\00\1723\00332 3\03\C4;\0Acall.uni (F\033, \0A\15\03Q, \0A(\0A5\0020, \09\00t1\0A);\0Aldh\00\01g\01C2, [=\00\97+0];\0A} \0A\09\\\01\136r\01\198r\01\147r\01\198W\01\1F8\83\01\03\127\C5\00\0A,\00\1B9\83\01\1F1\83\01\02!10;\00\1F9\84\01=/10\85\01\1F\1763\00\0F\85\01<\1F4\85\01\00\90ret;\0A\0A}\0A\00\00\00\00\00\00\00">]
}

