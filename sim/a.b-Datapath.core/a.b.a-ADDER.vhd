library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER is
    port (
        A, B : in std_logic_vector(31 downto 0);
        S    : out std_logic_vector(31 downto 0)
    );
end entity ADDER;

architecture beh of ADDER is

begin

    S <= std_logic_vector(signed(A) + signed(B));

end architecture beh;