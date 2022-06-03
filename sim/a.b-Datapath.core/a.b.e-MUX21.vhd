library ieee;
use ieee.std_logic_1164.all;

entity MUX21 is

    generic (
        NBIT : natural := 32
    );
    port (
        IN0, IN1 : in std_logic_vector((NBIT - 1) downto 0);
        S        : in std_logic;
        O        : out std_logic_vector((NBIT - 1) downto 0)
    );
end MUX21;

architecture beh of MUX21 is
begin
    process (IN0, IN1, S)
    begin
        if (S = '0') then
            O <= IN0;
        else
            O <= IN1;
        end if;
    end process;
end beh;