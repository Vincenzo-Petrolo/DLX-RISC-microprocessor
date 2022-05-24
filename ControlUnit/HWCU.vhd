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
        PCSrc    : out std_logic;
        En_IF_ID : out std_logic;
        --WB
        MemToReg : out std_logic;
        RegDst   : out std_logic;
        Jal      : out std_logic;
        RegWrite : out std_logic

    );
end HWCU;

architecture beh of HWCU is
    subtype control_word is std_logic_vector(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_WB_LEN - 1 downto 0);
    -- Define LUT type
    type lut_t is array (0 to 17) of control_word;
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
    -- Registers for pipeline
    signal curr_EX, next_EX                                           : std_logic_vector(2 downto 0);
    signal curr_aluopcode, next_aluopcode                             : std_logic_vector(ALU_OPCODE_LEN-1 downto 0);
    signal curr_MEM1, next_MEM1, curr_MEM2, next_MEM2                 : std_logic_vector(1 downto 0);
    signal curr_WB1, next_WB1, curr_WB2, next_WB2, curr_WB3, next_WB3 : std_logic_vector(4 downto 0);
    -- General wiring
    signal wire_lut_out : std_logic_vector(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_WB_LEN - 1 downto 0);
begin
    reg_update : process (CLK, RST, next_aluopcode, next_MEM1, next_MEM2, next_WB1, next_WB2, next_WB3)
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
    cwreg_pipeline : process (OPCODE, lookup_table, wire_lut_out, curr_MEM1, curr_WB1, curr_WB2)
    begin
        -- FIRST STAGE OF PIPELINE (Right out the LUT)
        -- Map the first bits into the MEM pipeline register
        next_MEM1 <= wire_lut_out(CW_IF_LEN + CW_ID_LEN + CW_EX_LEN + CW_WB_LEN - 1 downto CW_ID_LEN + CW_EX_LEN + CW_WB_LEN);
        -- Map the other bits into the EX register of the pipeline
        next_EX <= wire_lut_out(CW_EX_LEN + CW_WB_LEN - 1 downto CW_WB_LEN);
        -- Map the remaining bits in the WB
        next_WB1 <= wire_lut_out(CW_ID_LEN + CW_EX_LEN + CW_WB_LEN - 1 downto CW_EX_LEN + CW_WB_LEN) & wire_lut_out(CW_WB_LEN - 1 downto 0);

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
                next_aluopcode <= FUNC(3 downto 0);
            when 16#02# | 16#03# =>
                --J, JAL
                next_aluopcode <= ALU_ADD(3 downto 0);
            when 16#04# | 16#05# => --BEQZ,BNEZ
                next_aluopcode <= ALU_ADD(3 downto 0);
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
            when others => 
                next_aluopcode <= (others => '0');
        end case;
    end process;

    -- Map the pipeline registers to the output
    AluSrc <= curr_EX(0);
    Jump <= curr_EX(1);
    Branch <= curr_EX(2);
    ALUOpcode <= curr_aluopcode;
    PCSrc <= curr_MEM2(1);
    En_IF_ID <= curr_MEM2(0);
    RegDst <= curr_WB3(3);
    Regwrite <= curr_WB3(2);
    MemToReg <= curr_WB3(1);
    Jal <= curr_WB3(0);


end architecture; -- arch
