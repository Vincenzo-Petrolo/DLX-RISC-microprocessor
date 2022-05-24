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
            CLK, RST    : in std_logic;
            INSTRUCTION : in std_logic_vector(31 downto 0);
            DATA_IN     : in std_logic_vector(31 downto 0);

            --CONTROL SIGNALS--
            RegDst    : in std_logic;
            RegWrite  : in std_logic;
            PCSrc     : in std_logic;
            ALUSrc    : in std_logic;
            ALUOpcode : in std_logic_vector(3 downto 0);
            MemToReg  : in std_logic;
            Jump      : in std_logic;
            Branch    : in std_logic;
            Jal       : in std_logic;
			EN_IF_ID : in std_logic;

            --DATA SIGNALS--
            PC_OUT   : out std_logic_vector(31 downto 0);
            ALU_OUT  : out std_logic_vector(31 downto 0);
            DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;

    component INSTRMEM is
        port (
            ADDR_RD  : in std_logic_vector(31 downto 0);
            DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;

    component DATAMEM is
        port (
            CLK      : in std_logic;
            RST      : in std_logic;
            RE       : in std_logic;
            WE       : in std_logic;
            ADDR     : in std_logic_vector(31 downto 0);
            DATA_IN  : in std_logic_vector(31 downto 0);
            DATA_OUT : out std_logic_vector(31 downto 0)
        );
    end component;
	component HWCU is
		port (
		    OPCODE   : in std_logic_vector(5 downto 0);
		    FUNC     : in std_logic_vector(10 downto 0);
		    CLK, RST : in std_logic;
		    --CONTROL SIGNALS--
		    -- IF
		    -- ID
		    -- EX
		    ALUSrc    : out std_logic;
		    Jump      : out std_logic;
		    Branch    : out std_logic;
		    ALUOpcode : out std_logic_vector(3 downto 0);
		    --MEM
		    PCSrc    : out std_logic;
		    En_IF_ID : out std_logic;
		    --WB
		    MemToReg : out std_logic;
		    RegDst   : out std_logic;
		    Jal      : out std_logic;
		    RegWrite : out std_logic

		);
	end component;

    signal PC_OUT_i, ALU_OUT_i, DATA_OUT_i               : std_logic_vector(31 downto 0);
    signal INSTR_i                                       : std_logic_vector(31 downto 0);
    signal DATA_IN_i                                     : std_logic_vector(31 downto 0);
    signal RegDst_i, RegWrite_i, PCSrc_i                 : std_logic;
    signal ALUSrc_i, MemToReg_i, Jump_i, Branch_i, Jal_i : std_logic;
	signal EN_IF_ID_i : std_logic;
    signal ALUOpcode_i                                   : std_logic_vector(3 downto 0);
    signal MemRead_i, MemWrite_i                         : std_logic;

begin
    CPU_DP : DP port map(
        CLK, RST, INSTR_i, DATA_IN_i, RegDst_i, RegWrite_i, PCSrc_i, ALUSrc_i, ALUOpcode_i,
        MemToReg_i, Jump_i, Branch_i, Jal_i,EN_IF_ID_i, PC_OUT_i, ALU_OUT_i, DATA_OUT_i);
    CPU_INSTRMEM : INSTRMEM port map(PC_OUT_i, INSTR_i);
    CPU_DATAMEM  : DATAMEM port map(CLK, RST, MemRead_i, MemWrite_i, ALU_OUT_i, DATA_OUT_i, DATA_IN_i);
	CPU_CU : HWCU port map(CLK => CLK, RST => RST, OPCODE => INSTR_i(31 downto 26), FUNC => INSTR_i(10 downto 0),
							ALUSrc => ALUSrc_i, Jump => Jump_i, Branch => Branch_i, ALUOpcode => ALUOpcode_i, PCSrc => PCSrc_i,
							MemToReg => MemToReg_i,EN_IF_ID => EN_IF_ID_i, RegDst => RegDst_i, Jal => Jal_i,RegWrite => RegWrite_i);  
end struct;
