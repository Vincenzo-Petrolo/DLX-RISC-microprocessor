library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DP is
port (  
    CLK, RST : in std_logic;
    INSTRUCTION : in std_logic_vector(31 downto 0);
    DATA_IN : in std_logic_vector(31 downto 0);
    
    --CONTROL SIGNALS--
    RegDst : in std_logic;
    RegWrite : in std_logic;
    PCSrc : in std_logic;
    ALUSrc : in std_logic;
    ALUOpcode : in std_logic_vector(3 downto 0);
    MemToReg : in std_logic;
    Jump : in std_logic;
    Branch : in std_logic;
    Jal : in std_logic;
    
    --DATA SIGNALS--
    PC_OUT : out std_logic_vector(31 downto 0);
    ALU_OUT : out std_logic_vector(31 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0)
    );
end DP;

architecture struct of DP is
    
    component RF is
    port (
        RST      : in  std_logic;
        WE       : in  std_logic;
        ADDR_RD1 : in  std_logic_vector(4 downto 0);
        ADDR_RD2 : in  std_logic_vector(4 downto 0);
        ADDR_WR  : in  std_logic_vector(4 downto 0);
        DATA_IN  : in  std_logic_vector(31 downto 0);
        DATA_OUT1: out std_logic_vector(31 downto 0);
        DATA_OUT2: out std_logic_vector(31 downto 0)
    );
    end component;
    
    component REG is
    generic (
        BITS : integer := 32
    );
    port (
        CLK, RST : in std_logic;
        I : in std_logic_vector(BITS-1 downto 0);
        O : out std_logic_vector(BITS-1 downto 0)
    );
    end component;
    
    component MUX21 is
	 generic (
		 NBIT : natural := 32
	 );
	 port (
	 	 IN0, IN1 : in std_logic_vector((NBIT-1) downto 0);
		 S : in std_logic;
		 O : out std_logic_vector((NBIT-1) downto 0)
		 );
    end component;
    
    component ALU is
    port (
        OP1, OP2 : in std_logic_vector(31 downto 0);
        ALU_OP : in std_logic_vector(3 downto 0);
        RES : out std_logic_vector(31 downto 0);
        ZERO : out std_logic
    );
    end component;


    component ADDER is
        port (
            A,B : in std_logic_vector(31 downto 0);
            S : out std_logic_vector(31 downto 0)
        );
    end component;

    -- INSTRUCTION signals
    signal ADDR_R1_i : std_logic_vector(4 downto 0);
    signal ADDR_R2_i : std_logic_vector(4 downto 0);
    signal ADDR_R3_i : std_logic_vector(4 downto 0);
    signal JLABEL_i : std_logic_vector (31 downto 0);

    signal PC_IN_i, PC_OUT_i, PC_ADDER_OUT_i : std_logic_vector(31 downto 0);
    signal ADDR_WR_MUX_OUT_i : std_logic_vector(4 downto 0);
    signal DATA_OUT1_i, DATA_OUT2_i : std_logic_vector(31 downto 0);
    signal SE_IMM_i, SHSE_IMM_i : std_logic_vector(31 downto 0);
    signal ALU_MUX_OUT_i : std_logic_vector(31 downto 0);
    signal ALU_OUT_i : std_logic_vector(31 downto 0);
    signal PC_BRANCH_ADDER_OUT_i : std_logic_vector(31 downto 0);
    signal MEM_MUX_OUT_i : std_logic_vector(31 downto 0);
    signal PcMuxSel : std_logic;
    signal ZERO_i : std_logic;
    signal PC_OFFSET_i : std_logic_vector(31 downto 0);
    signal JAL_MUX_OUT_i : std_logic_vector(31 downto 0);

    -- Pipeline REGS signals
    signal PC_ADDER_REG_IF_ID_i: std_logic_vector(31 downto 0);
    signal INSTRMEM_REG_IF_ID_i: std_logic_vector(31 downto 0);
    signal PC_ADDER_REG_ID_EX_i: std_logic_vector(31 downto 0);
    signal RF_DATA_OUT1_REG_ID_EX_i: std_logic_vector(31 downto 0);
    signal RF_DATA_OUT2_REG_ID_EX_i: std_logic_vector(31 downto 0);
    signal SE_IMM_REG_ID_EX_i: std_logic_vector(31 downto 0);
    signal PC_BRANCH_ADDER_OUT_REG_EX_MEM_i: std_logic_vector(31 downto 0);
    signal ALU_OUT_REG_EX_MEM_i: std_logic_vector(31 downto 0);
    signal RF_DATA_OUT2_REG_EX_MEM_i: std_logic_vector(31 downto 0);
    
begin
    
    ADDR_R1_i <= INSTRMEM_REG_IF_ID_i(25 downto 21);
    ADDR_R2_i <= INSTRMEM_REG_IF_ID_i(20 downto 16);
    ADDR_R3_i <= INSTRMEM_REG_IF_ID_i(15 downto 11);
    SE_IMM_i(15 downto 0) <= INSTRMEM_REG_IF_ID_i(15 downto 0);
    SE_IMM_i(31 downto 16) <= (others => INSTRMEM_REG_IF_ID_i(15));
    SHSE_IMM_i <= SE_IMM_i(29 downto 0)&"00";
    JLABEL_i <= "0000" & INSTRMEM_REG_IF_ID_i(25 downto 0) & "00";  -- to be modified for successive pipeline stage
    PC_OUT <= PC_OUT_i;
    ALU_OUT <= ALU_OUT_i;
    DATA_OUT <= DATA_OUT2_i;
    PcMuxSel <= Jump or (Branch and ZERO_i);
    
    PC: REG generic map (32) port map (CLK, RST, PC_IN_i, PC_OUT_i);
    PC_ADDER: ADDER port map (PC_OUT_i, x"00000004", PC_ADDER_OUT_i);
    ADDR_WR_MUX: MUX21 generic map (5) port map (ADDR_R2_i, ADDR_R3_i, RegDst, ADDR_WR_MUX_OUT_i); 
    JAL_MUX : MUX21 generic map (32) port map (MEM_MUX_OUT_i, PC_ADDER_OUT_i, Jal, JAL_MUX_OUT_i);
    REGFILE: RF port map (RST, RegWrite, ADDR_R1_i, ADDR_R2_i, ADDR_WR_MUX_OUT_i, JAL_MUX_OUT_i, DATA_OUT1_i, DATA_OUT2_i);
    ALU_MUX: MUX21 port map (DATA_OUT2_i, SE_IMM_i, ALUSrc, ALU_MUX_OUT_i);
    ALU_DP: ALU port map (DATA_OUT1_i, ALU_MUX_OUT_i, ALUOpcode, ALU_OUT_i, ZERO_i);
    JUMP_MUX: MUX21 generic map (32) port map (JLABEL_i ,SHSE_IMM_i, PcMuxSel, PC_OFFSET_i);
    PC_BRANCH_ADDER: ADDER port map (PC_ADDER_REG_ID_EX_i, PC_OFFSET_i, PC_BRANCH_ADDER_OUT_i);
    PC_MUX: MUX21 port map (PC_ADDER_OUT_i, PC_BRANCH_ADDER_OUT_i, PCSrc, PC_IN_i);
    MEM_MUX: MUX21 port map (DATA_IN, ALU_OUT_i, MemToReg, MEM_MUX_OUT_i);

    -- Pipeline REGS
    PC_ADDER_REG_IF_ID: REG generic map (32) port map (CLK, RST, PC_ADDER_OUT_i, PC_ADDER_REG_IF_ID_i);
    INSTRMEM_REG_IF_ID: REG generic map (32) port map (CLK, RST, INSTRUCTION, INSTRMEM_REG_IF_ID_i);
    PC_ADDER_REG_ID_EX: REG generic map (32) port map (CLK, RST, PC_ADDER_REG_IF_ID_i, PC_ADDER_REG_ID_EX_i);
    RF_DATA_OUT1_REG_ID_EX: REG generic map (32) port map (CLK, RST, DATA_OUT1_i, RF_DATA_OUT1_REG_ID_EX_i);
    RF_DATA_OUT2_REG_ID_EX: REG generic map (32) port map (CLK, RST, DATA_OUT2_i, RF_DATA_OUT2_REG_ID_EX_i);
    SE_IMM_REG_ID_EX_i: REG generic map (32) port map (CLK, RST, SE_IMM_i, SE_IMM_REG_ID_EX_i);
    PC_BRANCH_ADDER_OUT_REG_EX_MEM: REG generic map (32) port map (CLK, RST, PC_BRANCH_ADDER_OUT_i, PC_BRANCH_ADDER_OUT_REG_EX_MEM_i);
    ALU_OUT_REG_EX_MEM: REG generic map (32) port map (CLK, RST, ALU_OUT_i, ALU_OUT_REG_EX_MEM_i);
    RF_DATA_OUT2_REG_EX_MEM: REG generic map (32) port map (CLK, RST, RF_DATA_OUT2_REG_ID_EX_i, RF_DATA_OUT2_REG_EX_MEM_i);
    -- to restart from adding JLABEL_i register ID/EX

    
end struct;
