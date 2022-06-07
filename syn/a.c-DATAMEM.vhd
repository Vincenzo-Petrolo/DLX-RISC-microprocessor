library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DATAMEM is
    port (
        RST      : in std_logic;
        RE       : in std_logic;
        WE       : in std_logic;
        ADDR     : in std_logic_vector(31 downto 0);
        DATA_IN  : in std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
    );
end DATAMEM;

architecture beh of DATAMEM is
begin

end beh;
