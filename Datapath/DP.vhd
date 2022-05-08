library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DP is
port (  
    CLK, RST : in std_logic;
    ADDR_R1 : in std_logic_vector(4 downto 0);
    ADDR_R2 : in std_logic_vector(4 downto 0);
    ADDR_R3 : in std_logic_vector(4 downto 0);
    IMM : in std_logic_vector(15 downto 0);
    JLABEL : in std_logic_vector(25 downto 0);
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
    signal JLABEL_i : std_logic_vector (31 downto 0);
    signal PC_OFFSET_i : std_logic_vector(31 downto 0);
    signal JAL_MUX_OUT_i : std_logic_vector(31 downto 0);
    
    
begin
    
    SE_IMM_i(15 downto 0) <= IMM;
    SE_IMM_i(31 downto 16) <= (others => IMM(15));
    SHSE_IMM_i <= SE_IMM_i(29 downto 0)&"00";
    PC_OUT <= PC_OUT_i;
    ALU_OUT <= ALU_OUT_i;
    DATA_OUT <= DATA_OUT2_i;
    PcMuxSel <= Jump or (Branch and ZERO_i);
    JLABEL_i <= "0000" & JLABEL & "00";
    
    PC: REG generic map (32) port map (CLK, RST, PC_IN_i, PC_OUT_i);
    PC_ADDER: ADDER port map (PC_OUT_i, x"00000004", PC_ADDER_OUT_i);
    ADDR_WR_MUX: MUX21 generic map (5) port map (ADDR_R2, ADDR_R3, RegDst, ADDR_WR_MUX_OUT_i); 
    JAL_MUX : MUX21 generic map (32) port map (MEM_MUX_OUT_i, PC_ADDER_OUT_i, Jal, JAL_MUX_OUT_i);
    REGFILE: RF port map (RST, RegWrite, ADDR_R1, ADDR_R2, ADDR_WR_MUX_OUT_i, JAL_MUX_OUT_i, DATA_OUT1_i, DATA_OUT2_i);
    ALU_MUX: MUX21 port map (DATA_OUT2_i, SE_IMM_i, ALUSrc, ALU_MUX_OUT_i);
    ALU_DP: ALU port map (DATA_OUT1_i, ALU_MUX_OUT_i, ALUOpcode, ALU_OUT_i, ZERO_i);
    JUMP_MUX: MUX21 generic map (32) port map (JLABEL_i ,SHSE_IMM_i, PcMuxSel, PC_OFFSET_i);
    PC_BRANCH_ADDER: ADDER port map (PC_ADDER_OUT_i, PC_OFFSET_i, PC_BRANCH_ADDER_OUT_i);
    PC_MUX: MUX21 port map (PC_ADDER_OUT_i, PC_BRANCH_ADDER_OUT_i, PCSrc, PC_IN_i);
    MEM_MUX: MUX21 port map (DATA_IN, ALU_OUT_i, MemToReg, MEM_MUX_OUT_i);
    
end struct;
