library IEEE;
use IEEE.std_logic_1164.all;

entity PG is
port (  Pik : in std_logic;
        Pdkj : in std_logic;
        Gik : in std_logic;
        Gdkj : in std_logic;
        Pij : out std_logic;
        Gij : out std_logic );
end PG;

architecture beh of PG is
begin
    Pij <= Pik AND Pdkj;
    Gij <= Gik OR (Pik AND Gdkj);
end beh;

configuration cfg_PG_beh of PG is
    for beh
    end for;
end configuration cfg_PG_beh;