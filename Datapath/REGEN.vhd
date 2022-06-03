library ieee;
use ieee.std_logic_1164.all;

entity REGEN is
    generic (
        BITS : integer := 32
    );
    port (
        CLK, RST : in std_logic;
        I        : in std_logic_vector(BITS - 1 downto 0);
        O        : out std_logic_vector(BITS - 1 downto 0);
		EN : in std_logic
    );
end REGEN;

architecture beh of REGEN is
	signal curr_reg, next_reg : std_logic_vector(BITS-1 downto 0);
begin
	O <= curr_reg;
	next_reg <= I;
    process (CLK,RST,EN)
    begin
		if (RST = '1') then
                curr_reg <= (others => '0');
		elsif(RST='0') then
        	if (rising_edge(CLK) and EN = '1') then    
                curr_reg <= next_reg;
			elsif(EN='0') then
				curr_reg <= curr_reg;
            end if;
        end if;
    end process;
end beh;
