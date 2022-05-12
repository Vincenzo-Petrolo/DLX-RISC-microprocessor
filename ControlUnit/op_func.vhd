library ieee;
use ieee.std_logic_1164.all;

package op_func is
    constant OPCODE_SIZE : integer := 6;
    constant FUNC_SIZE : integer := 11;

    --OPCODES declaration
    -- R-types
    constant RTYPE : std_logic_vector(OPCODE_SIZE-1 downto 0) := X"02";
    -- I-types
    constant J : std_logic_vector(OPCODE_SIZE-1 downto 0) := 0;

    --FUNC declaration
end op_func;