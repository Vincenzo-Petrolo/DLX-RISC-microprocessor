library ieee;
use ieee.std_logic_1164.all;

entity REG is
generic (
    BITS : integer := 32
    );
port (
    CLK, RST : in std_logic;
    I : in std_logic_vector(BITS-1 downto 0);
    O : out std_logic_vector(BITS-1 downto 0)
    );
end REG;

architecture beh of REG is
begin
    process (CLK)
    begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                O <= (others => '0');
            else
                O <= I;
            end if;
        end if;
    end process;
end beh;