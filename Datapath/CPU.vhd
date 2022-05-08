library ieee;
use ieee.std_logic_1164.all;

entity CPU is
port (
    CLK, RST : in std_logic
    );
end CPU;

architecture struct of CPU is

    component DP is
    port (  
        CLK, RST : in std_logic;
        ADDR_R1 : in std_logic_vector(4 downto 0);
        ADDR_R2 : in std_logic_vector(4 downto 0);
        ADDR_R3 : in std_logic_vector(4 downto 0);
        IMM : in std_logic_vector(15 downto 0);
        DATA_IN : in std_logic_vector(31 downto 0);
        
        --CONTROL SIGNALS--
        RegDst : in std_logic;
        RegWrite : in std_logic;
        PCSrc : in std_logic;
        ALUSrc : in std_logic;
        ALUOpcode : in std_logic_vector(3 downto 0);
        MemToReg : in std_logic;
        
        --DATA SIGNALS--
        PC_OUT : out std_logic_vector(31 downto 0);
        ALU_OUT : out std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component INSTRMEM is
    port (
        ADDR_RD  : in  std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component DATAMEM is
    port (
        CLK      : in  std_logic;
        RST      : in  std_logic;
        RE       : in  std_logic;
        WE       : in  std_logic;
        ADDR     : in  std_logic_vector(31 downto 0);
        DATA_IN  : in  std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal PC_OUT_i, ALU_OUT_i, DATA_OUT_i : std_logic_vector(31 downto 0);
    signal INSTR_i : std_logic_vector(31 downto 0);
    signal DATA_IN_i : std_logic_vector(31 downto 0);
    signal RegDst_i, RegWrite_i, PCSrc_i, ALUSrc_i, MemToReg_i : std_logic;
    signal ALUOpcode_i : std_logic_vector(3 downto 0);
    signal MemRead_i, MemWrite_i : std_logic;
    
begin
    CPU_DP: DP port map (CLK, RST, INSTR_i(25 downto 21),  INSTR_i(20 downto 16), INSTR_i(16 downto 11),
                        INSTR_i(15 downto 0), DATA_IN_i, RegDst_i, RegWrite_i, PCSrc_i, ALUSrc_i, ALUOpcode_i,
                        MemToReg_i, PC_OUT_i, ALU_OUT_i, DATA_OUT_i);
    CPU_INSTRMEM: INSTRMEM port map (PC_OUT_i, INSTR_i);
    CPU_DATAMEM: DATAMEM port map (CLK, RST, MemRead_i, MemWrite_i, ALU_OUT_i, DATA_OUT_i, DATA_IN_i);
end struct;