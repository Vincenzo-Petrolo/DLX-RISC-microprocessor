library ieee;
use ieee.std_logic_1164.all;

entity REG is
    generic (
        BITS : integer := 32
    );
    port (
        CLK, RST : in std_logic;
        I        : in std_logic_vector(BITS - 1 downto 0);
        O        : out std_logic_vector(BITS - 1 downto 0)
    );
end REG;

architecture beh of REG is
begin
    process (CLK)
    begin
		if(RST='1') then
                O <= (others => '0');
		elsif(RST='0') then
			if(rising_edge(CLK)) then
                O <= I;
			end if;
		end if;
    end process;
end beh;
