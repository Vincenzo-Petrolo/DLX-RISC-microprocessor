library IEEE;
use IEEE.std_logic_1164.all;

entity G is
port (  Pik : in std_logic;
        Gik : in std_logic;
        Gdkj : in std_logic;
        Gij : out std_logic );
end G;

architecture beh of G is
begin
    Gij <= Gik OR (Pik AND Gdkj);
end beh;

configuration cfg_G_beh of G is
    for beh
    end for;
end cfg_G_beh;