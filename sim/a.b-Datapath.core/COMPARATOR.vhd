library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity COMPARATOR is
    generic (
        NBIT : natural := 32
    );
    port (
        A, B : in std_logic_vector(NBIT-1 downto 0);
        C    : out std_logic
    );
end entity COMPARATOR;

architecture beh of COMPARATOR is

begin

    process (A, B)
    begin
        if (A = B) then
            C <= '1';
        else    
            C <= '0';
        end if;
    end process;

end architecture beh;