library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.op_func.all;
use work.cw_flags.all;
use work.aluOpCodes.all;

entity HWCU is
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
end HWCU;

architecture beh of HWCU is
    subtype control_word is std_logic_vector(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN - 1 downto 0);
    -- Define LUT type
    type lut_t is array (0 to 61) of control_word;
    -- Declare the LUT of the hardwired CU
    signal lookup_table : lut_t := (
        --RTYPE Mapping 0x00
        std_logic_vector(SEL_REGDST_1 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_0) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x01 is missing 0x01
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --J 0x2
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_1 or SEL_ALUSRC_0) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --JAL 0x3
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_1 or SEL_ALUSRC_0) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_1),         --WB
        --BEQZ 0x4
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_1 or JUMP_0 or SEL_ALUSRC_0) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --BNEZ, ALU receives ALUOPCDOE which tells it to check against != 0 but it uses ZERO flag signal 0x5
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_1 or JUMP_0 or SEL_ALUSRC_0) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --BFPT 0x6
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --BFPF 0x7
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --ADDI 0x8
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --ADDUI 0x9
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SUBI 0xa
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SUBUI 0xb
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --ANDI 0xc
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --ORI 0xd
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --XORI 0xe
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LHI 0xf
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --RFE 0x10
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --TRAP 0x11
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --JR 0x12
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --JALR 0x13
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SLLI 0x14
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --NOP 0x15
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SRLI 0x16
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SRAI 0x17
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SEQI 0x18
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SNEI 0x19
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SLTI 0x1a
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SGTI 0x1b
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SLEI 0x1c
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SGEI 0x1d
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x1e is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x1f is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LB 0x20
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LH 0x21
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x22 is missing 
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LW 0x23
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_1) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_1) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_1 or SEL_JAL_0),         --WB
        --LBU 0x24
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LHU 0x25
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LF 0x26
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --LD 0x27
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SB 0x28
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SH 0x29
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x2a is missing 
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SW 0x2b
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_1 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x2c is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x2d is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SF 0x2e
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SD 0x2f
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x30 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x31 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x32 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x33 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x34 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x35 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x36 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x37 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --ITLB 0x38
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --PLACEHOLDER because OPCODE 0x39 is missing
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SLTUI 0x3a
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SGTUI 0x3b
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SLEUI 0x3c
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0),         --WB
        --SGEUI 0x3d
        std_logic_vector(SEL_REGDST_0 or EN_REGWRITE_0) &      --ID
        std_logic_vector(BRANCH_0 or JUMP_0 or SEL_ALUSRC_1) & --EX
        std_logic_vector(WE_0 or RE_0) &                       --MEM
        std_logic_vector(SEL_MEMTOREG_0 or SEL_JAL_0)          --WB
    );
    -- Registers for pipeline
    signal curr_EX, next_EX                                           : std_logic_vector(2 downto 0);
    signal curr_aluopcode, next_aluopcode                             : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0);
    signal curr_MEM1, next_MEM1, curr_MEM2, next_MEM2                 : std_logic_vector(1 downto 0);
    signal curr_WB1, next_WB1, curr_WB2, next_WB2, curr_WB3, next_WB3 : std_logic_vector(2 downto 0);
    -- General wiring
    signal wire_lut_out : std_logic_vector(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN - 1 downto 0);
begin
    reg_update : process (CLK, RST, next_aluopcode, next_EX, next_MEM1, next_MEM2, next_WB1, next_WB2, next_WB3)
    begin
        if (RST = '1') then
            curr_aluopcode <= (others => '0');
            curr_EX        <= (others => '0');
            curr_MEM1      <= (others => '0');
            curr_MEM2      <= (others => '0');
            curr_WB1       <= (others => '0');
            curr_WB2       <= (others => '0');
            curr_WB3       <= (others => '0');
        elsif (rising_edge(CLK)) then
            curr_aluopcode <= next_aluopcode;
            curr_EX        <= next_EX;
            curr_MEM1      <= next_MEM1;
            curr_MEM2      <= next_MEM2;
            curr_WB1       <= next_WB1;
            curr_WB2       <= next_WB2;
            curr_WB3       <= next_WB3;

        end if;
    end process;

    -- Get the control word out from the LUT and map into a wire
    wire_lut_out <= lookup_table(to_integer(unsigned(OPCODE)));

    -- takes care of OPCODE and the wiring of cw* registers
    cwreg_pipeline : process (OPCODE, lookup_table, wire_lut_out, curr_MEM1, curr_WB1, curr_WB2, curr_WB3, curr_EX, curr_MEM2)
    begin
        -- FIRST STAGE OF PIPELINE (Right out the LUT)
        -- Map the first bits into the MEM pipeline register
        next_MEM1 <= wire_lut_out(CW_MEM_LEN + CW_WB_LEN - 1 downto CW_WB_LEN);
        -- Map the other bits into the EX register of the pipeline
        next_EX <= wire_lut_out(CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN - 1 downto CW_MEM_LEN + CW_WB_LEN);
        -- Map the remaining bits in the WB
        next_WB1 <= wire_lut_out(CW_ID_LEN + CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN - 2 downto CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN) & wire_lut_out(CW_WB_LEN - 1 downto 0);
        -- NEXT STAGES of pipeline
        next_MEM2 <= curr_MEM1;
        next_WB2  <= curr_WB1;
        next_WB3  <= curr_WB2;
    end process;

    alucontrol : process (OPCODE, FUNC)
    begin
        --See excel file for explanation on this approach, discuss together
        case to_integer(unsigned(OPCODE)) is
            when 16#00# => --RTYPE
                -- r type operations, directly forward the func
                --taking the last 5 bits
                case to_integer(unsigned(FUNC)) is
                    when 16#04# =>
                        -- SLL
                        next_aluopcode <= ALU_SLL;
                    when 16#06# =>
                        -- SRL
                        next_aluopcode <= ALU_SRL;
                    when 16#20# =>
                        -- ADD
                        next_aluopcode <= ALU_ADD;
                    when 16#22# =>
                        -- SUB
                        next_aluopcode <= ALU_SUB;
                    when 16#24# =>
                        -- AND
                        next_aluopcode <= ALU_AND;
                    when 16#25# =>
                        -- OR
                        next_aluopcode <= ALU_OR;
                    when 16#26# =>
                        -- XOR
                        next_aluopcode <= ALU_XOR;
                    when 16#29# =>
                        -- SNE
                        next_aluopcode <= ALU_SNE;
                    when 16#2C# =>
                        -- SLE
                        next_aluopcode <= ALU_SLE;
                    when 16#2D# =>
                        -- SGE
                        next_aluopcode <= ALU_SGE;
                    when others =>
                        next_aluopcode <= ALU_ADD;
                end case;

            when 16#02# | 16#03# =>
                --J, JAL
                next_aluopcode <= ALU_ADD(3 downto 0);
            when 16#04# => --BEQZ
                next_aluopcode <= ALU_BEQZ(3 downto 0);
            when 16#05# => --BNEZ
                next_aluopcode <= ALU_BNEZ(3 downto 0);
            when 16#08# => --ADDI
                next_aluopcode <= ALU_ADD(3 downto 0);
            when 16#0A# => --SUBI
                next_aluopcode <= ALU_SUB(3 downto 0);
            when 16#0C# => --ANDI
                next_aluopcode <= ALU_AND(3 downto 0);
            when 16#0D# => --ORI
                next_aluopcode <= ALU_OR(3 downto 0);
            when 16#0E# => --XORI
                next_aluopcode <= ALU_XOR(3 downto 0);
            when 16#14# => --SLLI
                next_aluopcode <= ALU_SLL(3 downto 0);
            when 16#15# => --NOP
                next_aluopcode <= ALU_ADD(3 downto 0);
            when 16#16# => --SRLI
                next_aluopcode <= ALU_SRL(3 downto 0);
            when 16#19# => --SNEI
                next_aluopcode <= ALU_SNE(3 downto 0);
            when 16#1C# => --SLEI
                next_aluopcode <= ALU_SLE(3 downto 0);
            when 16#1D# => --SGEI
                next_aluopcode <= ALU_SGE(3 downto 0);
            when 16#23# => --LW
                next_aluopcode <= ALU_ADD(3 downto 0);
            when 16#2B# => --SW
                next_aluopcode <= ALU_ADD(3 downto 0);
            when others               =>
                next_aluopcode <= (others => '0');
        end case;
    end process;

    -- Map the pipeline registers to the output
    AluSrc    <= curr_EX(0);
    Jump      <= curr_EX(1);
    Branch    <= curr_EX(2);
    ALUOpcode <= curr_aluopcode;
    RegDst    <= wire_lut_out(CW_ID_LEN + CW_EX_LEN + CW_MEM_LEN + CW_WB_LEN - 1);
    Regwrite  <= curr_WB3(2);
    MemToReg  <= curr_WB3(1);
    Jal       <= curr_WB3(0);
    WE        <= curr_MEM2(0);
    RE        <= curr_MEM2(1);
end architecture; -- arch
