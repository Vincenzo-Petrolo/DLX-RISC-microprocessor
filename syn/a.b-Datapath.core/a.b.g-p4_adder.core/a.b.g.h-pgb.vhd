library IEEE;
use IEEE.std_logic_1164.all;

entity pgb is
port (  ai : in std_logic;
        bi : in std_logic;
        p : out std_logic;
        g : out std_logic );
end pgb;

architecture beh of pgb is
begin
    p <= ai XOR bi;
    g <= ai AND bi;
end beh;

configuration cfg_pgb_beh of pgb is
    for beh
    end for;
end cfg_pgb_beh;
