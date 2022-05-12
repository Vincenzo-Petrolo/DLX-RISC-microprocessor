library ieee;
use ieee.std_logic_1164.all;

package op_func is
    constant OPCODE_SIZE : integer := 6;
    constant FUNC_SIZE   : integer := 11;
    constant NO_INSTRUCTIONS : integer := 64;
    --OPCODES declaration
    -- R-types
    constant RTYPE : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"00";
    -- I-types
    constant J    : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"02";
    constant JAL  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"03";
    constant BEQZ : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"04";
    constant BNEZ : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"05";
    constant ADDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"08";
    constant SUBI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0A";
    constant ANDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0C";
    constant ORI  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0D";
    constant ANDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0C";
    constant XORI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0E";
    constant ANDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0C";
    constant SLLI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"14";
    constant NOP  : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"15";
    constant ANDI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"0C";
    constant SRLI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"16";
    constant SNEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"19";
    constant SLEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"1C";
    constant SGEI : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"1D";
    constant LW   : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"23";
    constant SW   : std_logic_vector(OPCODE_SIZE - 1 downto 0) := X"2B";

    --FUNC declaration for R-type instruction
    constant FUNC_SLL   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"04";
    constant FUNC_SRL   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"06";
    constant FUNC_SLL   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"04";
    constant FUNC_ADD   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"20";
    constant FUNC_SUB   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"22";
    constant FUNC_AND   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"24";
    constant FUNC_OR   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"25";
    constant FUNC_XOR   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"26";
    constant FUNC_SNE   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"29";
    constant FUNC_SLE   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"2C";
    constant FUNC_SGE   : std_logic_vector(FUNC_SIZE - 1 downto 0) := X"2D";
end op_func;