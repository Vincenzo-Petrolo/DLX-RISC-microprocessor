library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TB_CPU is
end entity TB_CPU;

architecture tb_cpu_arch of TB_CPU is
    component CPU is
        port (
            CLK, RST : in std_logic
        );
    end component;

    signal CLK_s, RST_s : std_logic;
    signal clk_period   : time := 20 ns;
begin

    DUT : CPU port map(CLK => CLK_s, RST => RST_s);

    clk_proc : process
    begin
        CLK_s <= '1';
        wait for clk_period/2;
        CLK_s <= '0';
        wait for clk_period/2;
    end process clk_proc;

    vect_proc : process
    begin

        RST_s <= '1';
        wait for 3 * clk_period/4;
        RST_s <= '0';
        wait;

    end process vect_proc;

end architecture tb_cpu_arch;