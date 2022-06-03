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

    subtype WordT is std_logic_vector(31 downto 0);
    type StorageT is array(0 to 63) of WordT;
    signal MEM : StorageT;

begin

    RW : process(RST,MEM,ADDR,DATA_IN,RE,WE)
    begin

        if (RST = '0') then
            if (RE = '1') then
                DATA_OUT <= MEM(to_integer(unsigned(ADDR)));
            end if;
            if (WE = '1') then
                MEM(to_integer(unsigned(ADDR))) <= DATA_IN;
            end if;
        elsif (RST = '1') then
            MEM <= (others => (others => '0'));
        end if;

    end process RW;

end beh;
