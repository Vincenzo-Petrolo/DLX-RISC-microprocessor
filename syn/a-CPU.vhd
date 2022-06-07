library ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
        CLK, RST : in std_logic;
        -- DP signals to package
        PC_OUT_IMEM      : out std_logic_vector(31 downto 0);
        INSTRUCTION_IMEM : in std_logic_vector(31 downto 0);
        DATA_IN_MEM     : in std_logic_vector(31 downto 0);
        ADDR_MEM     : out std_logic_vector(31 downto 0);
        DATA_OUT_MEM    : out std_logic_vector(31 downto 0);
        -- CU signals to package
        RE_MEM       : out std_logic;
        WE_MEM       : out std_logic

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
            ALUSrc    : in std_logic;
            ALUOpcode : in std_logic_vector(3 downto 0);
            MemToReg  : in std_logic;
            Jump      : in std_logic;
            Branch    : in std_logic;
            Jal       : in std_logic;
            --DATA SIGNALS--
            PC_OUT                : out std_logic_vector(31 downto 0);
            ALU_OUT               : out std_logic_vector(31 downto 0);
            DATA_OUT              : out std_logic_vector(31 downto 0);
            INSTRUCTION_IF_ID_OUT : out std_logic_vector(31 downto 0)
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
            WE : out std_logic;
            RE : out std_logic;
            --WB
            MemToReg : out std_logic;
            RegDst   : out std_logic;
            Jal      : out std_logic;
            RegWrite : out std_logic

        );
    end component;

    signal INSTR_IF_ID_i                        : std_logic_vector(31 downto 0);
    signal RegDst_i, RegWrite_i                          : std_logic;
    signal ALUSrc_i, MemToReg_i, Jump_i, Branch_i, Jal_i : std_logic;

    signal ALUOpcode_i           : std_logic_vector(3 downto 0);

begin
    CPU_DP : DP port map(
        CLK, RST, INSTRUCTION_IMEM, DATA_IN_MEM, RegDst_i, RegWrite_i, ALUSrc_i, ALUOpcode_i,
        MemToReg_i, Jump_i, Branch_i, Jal_i, PC_OUT_IMEM, ADDR_MEM, DATA_OUT_MEM, INSTR_IF_ID_i);
    CPU_CU       : HWCU port map(
        CLK => CLK, RST => RST, OPCODE => INSTR_IF_ID_i(31 downto 26), FUNC => INSTR_IF_ID_i(10 downto 0),
        ALUSrc => ALUSrc_i, Jump => Jump_i, Branch => Branch_i, ALUOpcode => ALUOpcode_i,
        MemToReg => MemToReg_i, RegDst => RegDst_i, Jal => Jal_i, RegWrite => RegWrite_i, WE => WE_MEM, RE => RE_MEM);
end struct;