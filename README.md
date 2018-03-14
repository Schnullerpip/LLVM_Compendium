# LLVM_Compendium
just a collection of useful scripts and research

## Definitions

*instruction selection* - In computer science, instruction selection is the stage of a compiler backend that transforms its middle-level intermediate representation (IR) into a low-level IR where each operation directly corresponds to an instruction available on the target machine.

*register allocation* - In compiler optimization, register allocation is the process of assigning a large number of target program variables onto a small number of CPU registers.

*instruction scheduling* - In computer science, instruction scheduling is a compiler optimization used to improve instruction-level parallelism, which improves performance on machines with instruction pipelines. Put more simply, without changing the meaning of the code, it tries to. Avoid pipeline stalls by rearranging the order of instructions.

*three adress form/code* - In computer science, three-address code is an intermediate code used by optimizing compilers to aid in the implementation of code-improving transformations. Each TAC instruction has at most three operands and is typically a combination of assignment and a binary operator. For example, t1 := t2 + t3


*llvm file formats* 
```sh
$ .ll - textual format
$ .bc - efficient and dense on-disk binary "bitcode" format
$ The LLVM Project also provides tools to convert the on-disk format from text to binary: llvm-as assembles the textual .ll file into a .bc file containing the bitcode goop and llvm-dis turns a .bc file into a .ll file
```
