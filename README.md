![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.001.jpeg)

DLX Presentation![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.002.png)

Microelectronic Systems 2021-2022

Alfredo Paolino, Vincenzo Petrolo, Diamante Simone Crescenzo![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.003.png)

Outline![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- VHDL Design
  - Datapath
  - Instruction memory
  - Data memory
  - Control Unit

•Simulation

- Synthesis
- Physical layout
- Technical report
- Possible improvements![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

VHDL Design![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- Chosen approach: Bottom-up

` `![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.006.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.007.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.008.png)

1 2 3![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.009.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.010.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.011.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

VHDL Design (cont.)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- And then we merged them![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.012.png)![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

Datapath![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- ALU : It is described, using a mixed behavioral-structural description in order to use the Pentium-4 adder in case of additions or subtractions.
- Register File : It is composed of 32 registers and has 2 read ports and 1 write port.
- Adders : Ripple carry adders used for computing next Program Counter.
- Multiplexers : Are used to choose between input sources in the Register File, Program Counter and ALU.
- Pipeline registers : Are used to store the results from previous stage.![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

Instruction Memory![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- Size : 2 kB
- Word : 32 bits
- It contains the firmware that is  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.013.png)loaded into the microprocessor. 
- Asynchronous memory. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

Data memory![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- Size : 2 kB
- Word size: 32 bits
- It stores data coming from registers. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.014.png)
- Asynchronous memory. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

Control Unit![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- LUT size : 62 lines
- Control Word: 9 bits
- Hardwired implementation ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.015.png)
- Modular control word generation  through **std\_logic\_vector** concatenation to improve  readability during debugging  phase. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.016.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 7
Simulation – I-type tests![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- In order to verify that  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.017.jpeg)the instruction set for I- type instructions works, we wrote a simple assembly program that performs: 
  - Additions; 
  - Subtractions; 
  - Mask operations  through logical  instructions (i.e. AND/OR/XOR etc..). 

•Eventually the program  

halts. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 8
Simulation – R-type tests![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- In order to verify that  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.018.jpeg)the instruction set for R- type instructions works,  we wrote a simple  assembly program that  performs: 
  - Additions; 
  - Subtractions; 
  - Shift operations. 

•Eventually the program  

halts. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 9

Simulation – Iterative Division![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- In conclusion, to create a  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.019.jpeg)more complete program  we went through the  iterative division  simulation. 
- The algorithm is executed after a call to a procedure  (JAL) and performs 81/27. 
- When the procedure  ends it stores the result  into memory and load  again into another  register. Then it returns to  the caller. 

•Eventually the program  

halts. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 11

Synthesis![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- Starting from a clock  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.020.jpeg)frequency of 50 MHz we  reached up to 1 GHz,  without major synthesis  optimizations. 
- Eventually 2 GHz clock  frequency goal was  achieved using aggressive  optimization flow with the  usage of **compile\_ultra,  set\_dont\_touch** to avoid  removal of skewing registers and **set\_max\_delay** to  constrain the quasi-critical  paths. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

Physical layout![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- We followed the flow for the  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.021.jpeg)place & route phase. 
- After the post-routing  optimization phase, we run a  static power analysis and got an  estimated power of **500 mW**  running at 1 GHz. 
- The total power estimated  from PrimeTime (1 GHz) was:  **426 mW ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)**

Technical report![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

- The final step was to produce a report  ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.022.jpeg)describing more in detail what is shown in this  presentation. ![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 14
Possible improvements![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.004.png)

For a future PRO version, some of the possible improvements:

- Data Hazard Unit
- Branch Prediction Unit
- Floating Point Unit
- Instruction/Data cache
- Extended Instruction set
- Reducing to 1 the Branch delay slot
- Verification using UVM![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.005.png)

DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 15

**Thanks for your attention!![](images/Aspose.Words.d7010438-ceac-4eee-a29b-0d19d26c434b.003.png)**
DLX PRESENTATION - MICROELECTRONIC SYSTEMS 21/22 16
