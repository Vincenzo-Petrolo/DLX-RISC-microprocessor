library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.op_func.all;
use work.cw_flags.all;

entity HWCU is
    port (
        OPCODE   : in std_logic_vector(5 downto 0);
        FUNC     : in std_logic_vector(10 downto 0);
        CLK, RST : in std_logic;
        --CONTROL SIGNALS--
        RegDst    : out std_logic;
        RegWrite  : out std_logic;
        PCSrc     : out std_logic;
        ALUSrc    : out std_logic;
        ALUOpcode : out std_logic_vector(3 downto 0);
        MemToReg  : out std_logic;
        Jump      : out std_logic;
        Branch    : out std_logic;
        Jal       : out std_logic

    );
end HWCU;

architecture beh of HWCU is
    subtype control_word is std_logic_vector(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_WB_LEN - 1 downto 0);
    -- Define LUT type
    type lut_t is array (0 to 1) of control_word;
    -- Declare the LUT of the hardwired CU
    signal lookup_table : lut_t := (
        --RTYPE Mapping
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_1 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_0) &         --EX
        std_logic_vector(SEL_MEMTOREG_1 or SEL_JAL_0),                 --WB
        --J
        std_logic_vector(SEL_PCSRC_1 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_0) & --ID
        std_logic_vector(BRANCH_0 or JUMP_1 or SEL_ALUSRC_0) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --JAL
        std_logic_vector(SEL_PCSRC_1 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_1 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_1 or SEL_ALUSRC_0) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_1),                 --WB
        --BEQZ
        std_logic_vector(SEL_PCSRC_1 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_0) & --ID
        std_logic_vector(BRANCH_1 or JUMP_0 or SEL_ALUSRC_0) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --BNEZ, ALU receives ALUOPCDOE which tells it to check against != 0 but it uses ZERO flag signal
        std_logic_vector(SEL_PCSRC_1 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_0) & --ID
        std_logic_vector(BRANCH_1 or JUMP_0 or SEL_ALUSRC_0) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --ADDI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SUBI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --ANDI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --ORI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --XORI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SLLI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --NOP
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_0) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_0) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SRLI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SNEI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SLEI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --SGEI
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),                 --WB
        --LW
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_1) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_1 or SEL_JAL_0),                 --WB
        --SW
        std_logic_vector(SEL_PCSRC_0 or EN_IF_ID_1) &                  --IF
        std_logic_vector(SEL_REGDST_0 or SEL_R31_0 or EN_REGWRITE_0) & --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) &         --EX
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0)                  --WB
    );

begin

end architecture; -- arch