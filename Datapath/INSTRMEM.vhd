library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity INSTRMEM is
port (
    ADDR_RD  : in  std_logic_vector(31 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0)
    );
end INSTRMEM;

architecture beh of INSTRMEM is

    subtype MEM_ADDR is natural range 0 to 2**31;
    type MEM_ARRAY is array(MEM_ADDR) of std_logic_vector(31 downto 0);
    signal MEM : MEM_ARRAY;


begin

    DATA_OUT <= MEM(to_integer(unsigned(ADDR_RD)));

end beh;
