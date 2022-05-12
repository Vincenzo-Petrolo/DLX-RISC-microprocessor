library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RF is
    port (
        -- RF does not need CLK since its functionality is synced by the previous and
        --      the succesive pipeline registers
        RST       : in std_logic;
        WE        : in std_logic;
        ADDR_RD1  : in std_logic_vector(4 downto 0);
        ADDR_RD2  : in std_logic_vector(4 downto 0);
        ADDR_WR   : in std_logic_vector(4 downto 0);
        DATA_IN   : in std_logic_vector(31 downto 0);
        DATA_OUT1 : out std_logic_vector(31 downto 0);
        DATA_OUT2 : out std_logic_vector(31 downto 0)
    );
end RF;

architecture beh of RF is

    subtype REG_ADDR is natural range 0 to 31;
    type REG_ARRAY is array(REG_ADDR) of std_logic_vector(31 downto 0);
    signal REGS : REG_ARRAY;
begin

    RW : process (RST, WE, ADDR_RD1, ADDR_RD2, ADDR_WR, DATA_IN, REGS)
    begin
        if (RST = '0') then
            DATA_OUT1 <= REGS(to_integer(unsigned(ADDR_RD1)));
            DATA_OUT2 <= REGS(to_integer(unsigned(ADDR_RD2)));
            if (WE = '1') then
                REGS(to_integer(unsigned(ADDR_WR))) <= DATA_IN;
            end if;
        elsif (RST = '1') then
            REGS <= (others => (others => '0'));
        end if;
    end process RW;

end beh;