library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID is
    port (
        --INPUTS
        CLK, RST                    : in std_logic;

        -- IF signals
        INSTRUCTION                 : in std_logic_vector(31 downto 0);
        PC_BRANCH_ADDER_OUT_i       : in std_logic_vector(31 downto 0);
        PcMuxSel                    : in std_logic;

        -- ID signals
        RegDst                      : in std_logic;
        RegWrite                    : in std_logic;
        Jal                         : in std_logic;
        JAL_MUX_OUT_i               : in std_logic_vector(31 downto 0);
        ADDR_WR                     : in std_logic_vector(4 downto 0);

        -- OUTPUTS
        -- IF signals
        PC_OUT                      : out std_logic_vector(31 downto 0);
        --ID signals
        PC_ADDER_REG_IF_ID_i        : out std_logic_vector(31 downto 0);
        INSTRUCTION_IF_ID_OUT       : out std_logic_vector(31 downto 0);
        DATA_OUT1_i                 : out std_logic_vector(31 downto 0);
        DATA_OUT2_i                 : out std_logic_vector(31 downto 0);
        JLABEL_i                    : out std_logic_vector(31 downto 0);
        JAL_R31_ADDR_MUX_OUT_i      : out std_logic_vector(4 downto 0)
    );
end IF_ID;

architecture struct of IF_ID is

    component RF is
        port (
            CLK       : in std_logic;
            RST       : in std_logic;
            WE        : in std_logic;
            ADDR_RD1  : in std_logic_vector(4 downto 0);
            ADDR_RD2  : in std_logic_vector(4 downto 0);
            ADDR_WR   : in std_logic_vector(4 downto 0);
            DATA_IN   : in std_logic_vector(31 downto 0);
            DATA_OUT1 : out std_logic_vector(31 downto 0);
            DATA_OUT2 : out std_logic_vector(31 downto 0)
        );
    end component;

    component REG is
        generic (
            BITS : integer := 32
        );
        port (
            CLK, RST : in std_logic;
            I        : in std_logic_vector(BITS - 1 downto 0);
            O        : out std_logic_vector(BITS - 1 downto 0)
        );
    end component;

    component COMPARATOR is
        generic (
            NBIT : natural := 32
        );
        port (
            A, B : in std_logic_vector(NBIT-1 downto 0);
            C    : out std_logic
        );
    end component;

    component MUX21 is
        generic (
            NBIT : natural := 32
        );
        port (
            IN0, IN1 : in std_logic_vector((NBIT - 1) downto 0);
            S        : in std_logic;
            O        : out std_logic_vector((NBIT - 1) downto 0)
        );
    end component;

    component ADDER is
        port (
            A, B : in std_logic_vector(31 downto 0);
            S    : out std_logic_vector(31 downto 0)
        );
    end component;


    -- INSTRUCTION signals
    signal ADDR_R1_i : std_logic_vector(4 downto 0);
    signal ADDR_R2_i : std_logic_vector(4 downto 0);
    signal ADDR_R3_i : std_logic_vector(4 downto 0);
    signal ADDR_WR_MUX_OUT_i : std_logic_vector(4 downto 0);

    signal PC_IN_i, PC_OUT_i                : std_logic_vector(31 downto 0);
    signal PC_ADDER_OUT_i                   : std_logic_vector(31 downto 0);

    signal RD1_COMP_OUT_i, RD2_COMP_OUT_i   : std_logic;
    signal FORWARD1_EN_i, FORWARD2_EN_i     : std_logic;
    signal DATA_OUT1_RF_i, DATA_OUT2_RF_i   : std_logic_vector(31 downto 0);

    -- Pipeline REGS signals
    -- IF - ID
    signal INSTRMEM_REG_IF_ID_i : std_logic_vector(31 downto 0);
begin


    ADDR_R1_i                    <= INSTRMEM_REG_IF_ID_i(25 downto 21);
    ADDR_R2_i                    <= INSTRMEM_REG_IF_ID_i(20 downto 16);
    ADDR_R3_i                    <= INSTRMEM_REG_IF_ID_i(15 downto 11);
    JLABEL_i                     <= "0000" & INSTRMEM_REG_IF_ID_i(25 downto 0) & "00";
    PC_OUT                       <= PC_OUT_i;

    INSTRUCTION_IF_ID_OUT <= INSTRMEM_REG_IF_ID_i;

    FORWARD1_EN_i <= RD1_COMP_OUT_i and RegWrite;
    FORWARD2_EN_i <= RD2_COMP_OUT_i and RegWrite;

    PC_ADDER        : ADDER port map(PC_OUT_i, x"00000004", PC_ADDER_OUT_i);
    PC              : REG generic map(32) port map(CLK, RST, PC_IN_i, PC_OUT_i);
    ADDR_WR_MUX     : MUX21 generic map(5) port map(ADDR_R2_i, ADDR_R3_i, RegDst, ADDR_WR_MUX_OUT_i);
    JAL_R31_ADDR    : MUX21 generic map(5) port map(ADDR_WR_MUX_OUT_i, "11111", Jal, JAL_R31_ADDR_MUX_OUT_i);
    REGFILE         : RF port map(CLK, RST, RegWrite, ADDR_R1_i, ADDR_R2_i, ADDR_WR, JAL_MUX_OUT_i, DATA_OUT1_RF_i, DATA_OUT2_RF_i);
    PC_MUX          : MUX21 port map(PC_ADDER_OUT_i, PC_BRANCH_ADDER_OUT_i, PcMuxSel, PC_IN_i);

    RD1_COMP        : COMPARATOR generic map(5) port map(ADDR_R1_i, ADDR_WR, RD1_COMP_OUT_i);
    RD2_COMP        : COMPARATOR generic map(5) port map(ADDR_R2_i, ADDR_WR, RD2_COMP_OUT_i);

    FORWARD_RD1_MUX : MUX21 generic map(32) port map(DATA_OUT1_RF_i, JAL_MUX_OUT_i, FORWARD1_EN_i, DATA_OUT1_i);
    FORWARD_RD2_MUX : MUX21 generic map(32) port map(DATA_OUT2_RF_i, JAL_MUX_OUT_i, FORWARD2_EN_i, DATA_OUT2_i);

    -- Pipeline REGS
    PC_ADDER_REG_IF_ID : REG generic map(32) port map(CLK, RST, PC_ADDER_OUT_i, PC_ADDER_REG_IF_ID_i);
    INSTRMEM_REG_IF_ID : REG generic map(32) port map(CLK, RST, INSTRUCTION, INSTRMEM_REG_IF_ID_i);

end struct;
