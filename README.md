# DLX RISC uProcessor

Authors: 
 - Alfredo Paolino
 - Vincenzo Petrolo
 - Diamante Simone Crescenzo

## Outline
- [DLX RISC uProcessor](#dlx-risc-uprocessor)
  - [Outline](#outline)
  - [Datapath](#datapath)
  - [Instruction Memory](#instruction-memory)
  - [Data memory](#data-memory)
  - [Control Unit](#control-unit)
  - [Simulation – I-type tests](#simulation--i-type-tests)
  - [Simulation – R-type tests](#simulation--r-type-tests)
  - [Simulation – Iterative Division](#simulation--iterative-division)
  - [Synthesis](#synthesis)
  - [Physical layout](#physical-layout)
  - [Technical report](#technical-report)
  - [Possible improvements](#possible-improvements)


## Datapath
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.012.png)
- ALU : It is described, using a mixed behavioral-structural description in order to use the Pentium-4 adder in case of additions or subtractions.
- Register File : It is composed of 32 registers and has 2 read ports and 1 write port.
- Adders : Ripple carry adders used for computing next Program Counter.
- Multiplexers : Are used to choose between input sources in the Register File, Program Counter and ALU.
- Pipeline registers : Are used to store the results from previous stage.

## Instruction Memory
- Size : 2 kB
- Word : 32 bits
- It contains the firmware that is loaded into the microprocessor. 
- Asynchronous memory.
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.013.png)

## Data memory
- Size : 2 kB
- Word size: 32 bits
- It stores data coming from registers. 
- Asynchronous memory.
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.014.png)
## Control Unit
- LUT size : 62 lines
- Control Word: 9 bits
- Hardwired implementation 
- Modular control word generation  through **std\_logic\_vector** concatenation to improve  readability during debugging  phase.
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.015.png)

## Simulation – I-type tests
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.017.jpeg)
- In order to verify that the instruction set for I- type instructions works, we wrote a simple assembly program that performs: 
  - Additions; 
  - Subtractions; 
  - Mask operations  through logical  instructions (i.e. AND/OR/XOR etc..). 
  - Eventually the program halts.

## Simulation – R-type tests
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.018.jpeg)
- In order to verify that the instruction set for R- type instructions works,  we wrote a simple  assembly program that  performs: 
  - Additions; 
  - Subtractions; 
  - Shift operations. 
  - Eventually the program halts.

## Simulation – Iterative Division
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.019.jpeg)
- In conclusion, to create a more complete program  we went through the  iterative division  simulation. 
- The algorithm is executed after a call to a procedure  (JAL) and performs 81/27. 
- When the procedure  ends it stores the result  into memory and load  again into another  register. Then it returns to  the caller.
- Eventually the program halts.

## Synthesis
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.020.jpeg)
- Starting from a clock frequency of 50 MHz we  reached up to 1 GHz,  without major synthesis  optimizations. 
- Eventually 2 GHz clock  frequency goal was  achieved using aggressive  optimization flow with the  usage of **compile\_ultra,  set\_dont\_touch** to avoid  removal of skewing registers and **set\_max\_delay** to  constrain the quasi-critical  paths.

## Physical layout
![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.021.jpeg)
- We followed the flow for the place & route phase. 
- After the post-routing  optimization phase, we run a  static power analysis and got an  estimated power of **500 mW**  running at 1 GHz. 
- The total power estimated  from PrimeTime (1 GHz) was:  **426 mW**

## Technical report

- The final step was to produce a report describing more in detail what is shown in this  presentation.

## Possible improvements

For a future version, some of the possible improvements:

- Data Hazard Unit
- Branch Prediction Unit
- Floating Point Unit
- Instruction/Data cache
- Extended Instruction set
- Reducing to 1 the Branch delay slot
- Verification using UVM