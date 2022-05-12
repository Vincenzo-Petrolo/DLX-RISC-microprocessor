library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity INSTRMEM is
    port (
        ADDR_RD  : in std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
    );
end INSTRMEM;

architecture beh of INSTRMEM is

    subtype WordT is std_logic_vector(31 downto 0);
    type StorageT is array(0 to 63) of WordT;
    signal MEM : StorageT;

begin

    DATA_OUT <= MEM(to_integer(unsigned(ADDR_RD)));

end beh;