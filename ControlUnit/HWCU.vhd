library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
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
        Jal       : out std_logic;

    );
end HWCU;

architecture beh of HWCU is

begin

end architecture; -- arch