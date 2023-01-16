library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package op_func is
    constant OPCODE_SIZE     : integer := 6;
    constant FUNC_SIZE       : integer := 11;
    constant NO_INSTRUCTIONS : integer := 64;
    --OPCODES declaration
    -- R-types
    constant RTYPE : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#00#,OPCODE_SIZE));
    -- I-types
    constant J    : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#02#,OPCODE_SIZE));
    constant JAL  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#03#,OPCODE_SIZE));
    constant BEQZ : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#04#,OPCODE_SIZE));
    constant BNEZ : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#05#,OPCODE_SIZE));
    constant ADDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#08#,OPCODE_SIZE));
    constant SUBI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#0A#,OPCODE_SIZE));
    constant ANDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#0C#,OPCODE_SIZE));
    constant ORI  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#0D#,OPCODE_SIZE));
    constant XORI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#0E#,OPCODE_SIZE));
    constant SLLI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#14#,OPCODE_SIZE));
    constant NOP  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#15#,OPCODE_SIZE));
    constant SRLI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#16#,OPCODE_SIZE));
    constant SNEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#19#,OPCODE_SIZE));
    constant SLEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#1C#,OPCODE_SIZE));
    constant SGEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#1D#,OPCODE_SIZE));
    constant LW   : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#23#,OPCODE_SIZE));
    constant SW   : std_logic_vector(OPCODE_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#2B#,OPCODE_SIZE));

    --FUNC declaration for R-type instruction
    constant FUNC_SLL : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#04#,FUNC_SIZE));
    constant FUNC_SRL : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#06#,FUNC_SIZE));
    constant FUNC_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#20#,FUNC_SIZE));
    constant FUNC_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#22#,FUNC_SIZE));
    constant FUNC_AND : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#24#,FUNC_SIZE));
    constant FUNC_OR  : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#25#,FUNC_SIZE));
    constant FUNC_XOR : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#26#,FUNC_SIZE));
    constant FUNC_SEQ : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#28#,FUNC_SIZE));
    constant FUNC_SNE : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#29#,FUNC_SIZE));
    constant FUNC_SLT : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#2A#,FUNC_SIZE));
    constant FUNC_SGT : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#2B#,FUNC_SIZE));
    constant FUNC_SLE : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#2C#,FUNC_SIZE));
    constant FUNC_SGE : std_logic_vector(FUNC_SIZE - 1 downto 0) := std_logic_vector(to_unsigned(16#2D#,FUNC_SIZE));
end op_func;
