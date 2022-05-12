library ieee;
use ieee.std_logic_1164.all;

package cw_flags is
    -- Those are the flags to be used in the hardwired control unit Lookup-table

    -- --CONTROL SIGNALS--
    -- MemToReg : in std_logic;
    -- Jal : in std_logic;

    -- IF stage has control word size of 2
    constant CW_IF_LEN : integer := 2;
    -- Select Program counter source
    signal SEL_PCSRC_0 : std_logic_vector(CU_IF_LEN - 1 downto 0) := "00";
    signal SEL_PCSRC_1 : std_logic_vector(CU_IF_LEN - 1 downto 0) := "10";
    -- Enable the pipeline register
    signal EN_IF_ID_0 : std_logic_vector(CU_IF_LEN - 1 downto 0) := "00";
    signal EN_IF_ID_1 : std_logic_vector(CU_IF_LEN - 1 downto 0) := "01";
    -- End of IF stage

    -- ID stage has control word size of 2
    constant CW_ID_LEN : integer := 2;
    -- Select the destination register
    signal SEL_REGDST_0 : std_logic_vector(CW_ID_LEN - 1 downto 0) := "00";
    signal SEL_REGDST_1 : std_logic_vector(CW_ID_LEN - 1 downto 0) := "10";
    -- Enable the Register file for writing
    signal EN_REGWRITE_0 : std_logic_vector(CW_ID_LEN - 1 downto 0) := "00";
    signal EN_REGWRITE_1 : std_logic_vector(CW_ID_LEN - 1 downto 0) := "01";
    -- End of ID stage

    -- EX mem stage has control word size of 3
    constant CW_EX_LEN : integer := 3;

    -- Enable if branch instruction to execute
    signal BRANCH_0 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "000";
    signal BRANCH_1 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "100";
    -- Enable if jump instruction to execute
    signal JUMP_0 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "000";
    signal JUMP_1 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "010";
    -- Select the source for the second input of the ALU
    signal SEL_ALUSRC_0 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "000";
    signal SEL_ALUSRC_1 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "001";
    -- End of EX stage

    -- MEM stage has control word size of 0
    -- End of MEM stage

    -- WB stage has control word size of 
    constant CW_WB_LEN : integer := 2;
    -- Select the source for the second input of the ALU
    signal SEL_MEMTOREG_0 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "00";
    signal SEL_MEMTOREG_1 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "10";
    -- Select the source for the second input of the ALU
    signal SEL_JAL_0 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "00";
    signal SEL_JAL_1 : std_logic_vector(CW_EX_LEN - 1 downto 0) := "01";
    -- End of WB stage

end cw_flags;